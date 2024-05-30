import 'dart:async';

import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:solana/solana.dart';
import 'package:solana/solana_pay.dart';
import 'package:uuid/uuid.dart';

import '../../accounts/auth_scope.dart';
import '../../balances/services/refresh_balance.dart';
import '../../currency/models/amount.dart';
import '../../tokens/token.dart';
import '../data/repository.dart';
import '../models/payment_request.dart';

@Singleton(scope: authScope)
class PaymentRequestService implements Disposable {
  PaymentRequestService(
    this._repository,
    this._solanaClient,
    this._refreshBalance,
    this._ecClient,
  );

  final PaymentRequestRepository _repository;
  final SolanaClient _solanaClient;
  final RefreshBalance _refreshBalance;
  final EspressoCashClient _ecClient;

  final Map<String, StreamSubscription<void>> _subscriptions = {};
  final Map<String, Duration> _currentBackoffs = {};

  StreamSubscription<void>? _watcher;

  @PostConstruct(preResolve: true)
  Future<void> init() async {
    final pendingPayments = await _repository.getAllPending();

    for (final payment in pendingPayments) {
      _subscribe(payment);
    }
  }

  void _subscribe(PaymentRequest request) {
    if (!request.state.isInitial) return;

    _subscriptions[request.id]?.cancel();
    _subscriptions[request.id] = _createSubscription(request);
  }

  void initWatcher(PaymentRequest request) {
    if (!request.state.isInitial) return;

    _watcher?.cancel();
    _watcher = _createSubscription(request, interval: _focusedInterval);
  }

  void disposeWatcher() {
    _watcher?.cancel();
  }

  StreamSubscription<void> _createSubscription(
    PaymentRequest request, {
    Duration interval = _backgroundInterval,
  }) {
    final reference = request.payRequest.reference?.firstOrNull;

    if (reference == null) {
      return const Stream<void>.empty().listen(null);
    }

    Stream<TransactionId> solanaPayTransaction() => _solanaClient
        .findSolanaPayTransaction(
          reference: reference,
          commitment: Commitment.confirmed,
        )
        .asStream()
        .whereType<TransactionId>();

    return Stream<void>.periodic(interval)
        .flatMap((a) => solanaPayTransaction())
        .mergeWith([solanaPayTransaction()]).listen(
      (id) {
        _verifyTx(id, request);
      },
      onError: (_) async {
        _currentBackoffs[request.id] =
            (_currentBackoffs[request.id] ?? _minBackoff) * _backoffStep;

        if (_currentBackoffs[request.id]! > _maxBackoff) {
          _currentBackoffs[request.id] = _maxBackoff;
        }
        await Future<void>.delayed(_currentBackoffs[request.id]!);

        _subscribe(request);
      },
    );
  }

  Future<void> _verifyTx(TransactionId id, PaymentRequest request) async {
    try {
      final txDetails = await _solanaClient.validateSolanaPayTransaction(
        signature: id,
        recipient: request.payRequest.recipient,
        splToken: request.payRequest.splToken,
        reference: request.payRequest.reference,
        amount: request.payRequest.amount ?? Decimal.zero,
        commitment: Commitment.confirmed,
      );

      final timestamp = txDetails.blockTime?.let(
            (it) => DateTime.fromMillisecondsSinceEpoch(it * 1000),
          ) ??
          DateTime.now();

      await _repository.save(
        request.copyWith(
          state: PaymentRequestState.completed,
          transactionId: id,
          resolvedAt: timestamp,
        ),
      );

      _refreshBalance();

      await _subscriptions[request.id]?.cancel();
      await _watcher?.cancel();
    } on Exception {
      _currentBackoffs[request.id] =
          (_currentBackoffs[request.id] ?? _minBackoff) * _backoffStep;
      if (_currentBackoffs[request.id]! > _maxBackoff) {
        _currentBackoffs[request.id] = _maxBackoff;
      }
      await Future<void>.delayed(_currentBackoffs[request.id]!);
      // ignore: avoid-recursive-calls, async call without waiting
      unawaited(_verifyTx(id, request));
    }
  }

  Future<PaymentRequest> create({
    required Ed25519HDPublicKey recipient,
    required CryptoAmount tokenAmount,
    required String? label,
  }) async {
    final reference = await compute(_randomPublicKey, null);
    final Token token = tokenAmount.token;
    final Decimal amount = tokenAmount.decimal;

    final request = SolanaPayRequest(
      recipient: recipient,
      amount: amount,
      splToken: token == Token.sol ? null : token.publicKey,
      label: label,
      reference: [reference],
    );
    final id = const Uuid().v4();

    final fullLink = request.toUniversalLink().toString();

    final shortLink = await _ecClient
        .shortenLink(ShortenLinkRequestDto(fullLink: fullLink))
        .then((e) => e.shortLink);

    final paymentRequest = PaymentRequest(
      id: id,
      created: DateTime.now(),
      payRequest: request,
      dynamicLink: fullLink,
      shortLink: shortLink,
      state: PaymentRequestState.initial,
      transactionId: null,
      resolvedAt: null,
    );
    await _repository.save(paymentRequest);

    _subscribe(paymentRequest);

    return paymentRequest;
  }

  Future<void> cancel(String id) async {
    await _repository.delete(id);

    await _subscriptions[id]?.cancel();
  }

  Future<Uri> unshortenLink(String shortLink) => _ecClient
      .unshortenLink(UnshortenLinkRequestDto(shortLink: shortLink))
      .then((e) => Uri.parse(e.fullLink));

  @override
  Future<void> onDispose() async {
    await _watcher?.cancel();
    await Future.wait(_subscriptions.values.map((it) => it.cancel()));
  }
}

Future<Ed25519HDPublicKey> _randomPublicKey([dynamic _]) async {
  final keyPair = await Ed25519HDKeyPair.random();

  return keyPair.publicKey;
}

const _backoffStep = 2;
const _minBackoff = Duration(seconds: 2);
const _maxBackoff = Duration(minutes: 1);

const _backgroundInterval = Duration(seconds: 30);
const _focusedInterval = Duration(seconds: 1);

extension on PaymentRequestState {
  bool get isInitial => this == PaymentRequestState.initial;
}
