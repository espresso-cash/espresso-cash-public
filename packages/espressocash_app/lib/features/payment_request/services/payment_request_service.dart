import 'dart:async';

import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:espressocash_api/espressocash_api.dart';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:solana/solana.dart';
import 'package:solana/solana_pay.dart';
import 'package:uuid/uuid.dart';

import '../../authenticated/auth_scope.dart';
import '../../balances/services/refresh_balance.dart';
import '../../currency/models/amount.dart';
import '../../feature_flags/services/feature_flags_manager.dart';
import '../../tokens/token.dart';
import '../data/repository.dart';
import '../models/payment_request.dart';

@Singleton(scope: authScope)
class PaymentRequestService {
  PaymentRequestService(
    this._repository,
    this._solanaClient,
    this._refreshBalance,
    this._featureFlags,
    this._ecClient,
  );

  final PaymentRequestRepository _repository;
  final SolanaClient _solanaClient;
  final RefreshBalance _refreshBalance;
  final FeatureFlagsManager _featureFlags;
  final EspressoCashClient _ecClient;

  final Map<String, StreamSubscription<void>> _subscriptions = {};
  final Map<String, Duration> _currentBackoffs = {};

  @PostConstruct(preResolve: true)
  Future<void> init() async {
    final pendingPayments = await _repository.getAllPending();

    for (final payment in pendingPayments) {
      _subscribe(payment);
    }
  }

  void _subscribe(PaymentRequest request) {
    _waitForTx(request);
  }

  void _waitForTx(PaymentRequest request) {
    if (!request.state.isInitial) return;

    final reference = request.payRequest.reference?.firstOrNull;
    if (reference == null) return;

    Stream<TransactionId> solanaPayTransaction() => _solanaClient
        .findSolanaPayTransaction(
          reference: reference,
          commitment: Commitment.confirmed,
        )
        .asStream()
        .whereType<TransactionId>();

    _subscriptions[request.id] =
        Stream<void>.periodic(const Duration(seconds: 30))
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
        // ignore: avoid-recursive-calls, called in async callback
        _waitForTx(request);
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

    final showDlnFeature = _featureFlags.isIncomingDlnEnabled();

    final fullLink =
        request.toUniversalLink(showDln: showDlnFeature).toString();

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

  Future<Uri> unshortenLink(String shortLink) => _ecClient
      .unshortenLink(UnshortenLinkRequestDto(shortLink: shortLink))
      .then((e) => Uri.parse(e.fullLink));
}

Future<Ed25519HDPublicKey> _randomPublicKey([dynamic _]) async {
  final keyPair = await Ed25519HDKeyPair.random();

  return keyPair.publicKey;
}

const _backoffStep = 2;
const _minBackoff = Duration(seconds: 2);
const _maxBackoff = Duration(minutes: 1);

extension on PaymentRequestState {
  bool get isInitial => this == PaymentRequestState.initial;
}
