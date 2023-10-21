import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:collection/collection.dart';
import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:solana/dto.dart';
import 'package:solana/solana.dart';
import 'package:solana/solana_pay.dart';

part 'request_verifier_bloc.freezed.dart';

typedef PayResponse = ({
  String signature,
  Decimal receivedAmount,
  DateTime timestamp,
});

@freezed
class PaymentRequestVerifierEvent with _$PaymentRequestVerifierEvent {
  const factory PaymentRequestVerifierEvent.waitingFailed(Exception e) =
      WaitingFailed;

  const factory PaymentRequestVerifierEvent.txAdded(List<TransactionId> ids) =
      TxAdded;

  const factory PaymentRequestVerifierEvent.verificationFailed(
    Exception error, {
    required List<TransactionId> ids,
  }) = VerificationFailed;

  const factory PaymentRequestVerifierEvent.suceeded({
    required List<PayResponse> responses,
  }) = Succeeded;
}

@freezed
class PaymentRequestVerifierState with _$PaymentRequestVerifierState {
  const factory PaymentRequestVerifierState.waiting() = Waiting;
  const factory PaymentRequestVerifierState.retrying() = Retrying;
  const factory PaymentRequestVerifierState.verifying() = Verifying;
  const factory PaymentRequestVerifierState.success({
    required List<PayResponse> responses,
  }) = Success;
  const factory PaymentRequestVerifierState.failure() = Failure;
}

typedef _Event = PaymentRequestVerifierEvent;
typedef _State = PaymentRequestVerifierState;
typedef _EventHandler = EventHandler<_Event, _State>;
typedef _Emitter = Emitter<_State>;

class RequestVerifierBloc extends Bloc<_Event, _State> {
  RequestVerifierBloc({
    required SolanaClient solanaClient,
    required SolanaPayRequest request,
  })  : _solanaClient = solanaClient,
        _request = request,
        super(const Waiting()) {
    on<_Event>(_eventHandler, transformer: sequential());
    _waitForTx();
  }

  final SolanaClient _solanaClient;
  final SolanaPayRequest _request;

  StreamSubscription<List<TransactionId>>? _txSubscription;

  @override
  Future<void> close() async {
    await _txSubscription?.cancel();
    await super.close();
  }

  Duration _currentBackoff = _minBackoff;

  void _waitForTx() {
    final reference = _request.reference?.firstOrNull;
    if (reference == null) return;

    Stream<List<TransactionId>> solanaPayTransaction() => _solanaClient
        .findSolanaPayTransactions(
          reference: reference,
          commitment: Commitment.confirmed,
        )
        .asStream()
        .whereType<List<TransactionId>>();

    _txSubscription = Stream<void>.periodic(const Duration(seconds: 10))
        .flatMap((a) => solanaPayTransaction())
        .mergeWith([solanaPayTransaction()]).listen(
      (id) {
        _txSubscription?.cancel();
        add(TxAdded(id));
      },
      onError: (dynamic error) {
        _txSubscription?.cancel();
        add(WaitingFailed(error is Exception ? error : Exception(error)));
      },
    );
  }

  Future<void> _verifyTx(List<TransactionId> ids) async {
    try {
      final List<PayResponse> responses = [];

      for (final id in ids) {
        final response = await _solanaClient.validatePayTransaction(
          signature: id,
          reference: _request.reference,
          commitment: Commitment.confirmed,
        );

        responses.add(await _parseTransaction(response));
      }

      final totalReceived = responses.fold<Decimal>(
        Decimal.zero,
        (previousValue, element) => previousValue + element.receivedAmount,
      );

      add(Succeeded(responses: responses));

      if (totalReceived < (_request.amount ?? Decimal.zero)) {
        await Future<void>.delayed(_currentBackoff);
        _currentBackoff *= _backoffStep;
        if (_currentBackoff > _maxBackoff) {
          _currentBackoff = _maxBackoff;
        }
        _waitForTx();
      }
    } on Exception catch (error) {
      add(VerificationFailed(error, ids: ids));
    }
  }

  Future<PayResponse> _parseTransaction(TransactionDetails tx) async {
    final meta = tx.meta;

    final timestamp = tx.blockTime?.let(
          (it) => DateTime.fromMillisecondsSinceEpoch(it * 1000),
        ) ??
        DateTime.now();

    if (meta == null) {
      throw Exception();
    }

    final Decimal preAmount, postAmount;

    final recipientATA = await findAssociatedTokenAddress(
      owner: _request.recipient,
      mint: _request.splToken!,
    );
    final accountIndex = (tx.transaction as ParsedTransaction)
        .message
        .accountKeys
        .indexWhere((a) => a.pubkey == recipientATA.toBase58());
    if (accountIndex == -1) {
      throw Exception();
    }

    final preBalance = meta.preTokenBalances
        .firstWhereOrNull((a) => a.accountIndex == accountIndex);
    final postBalance = meta.postTokenBalances
        .firstWhereOrNull((a) => a.accountIndex == accountIndex);

    preAmount = Decimal.parse(preBalance?.uiTokenAmount.uiAmountString ?? '0');
    postAmount =
        Decimal.parse(postBalance?.uiTokenAmount.uiAmountString ?? '0');

    final receivedAmount = postAmount - preAmount;

    return (
      signature: (tx.transaction as ParsedTransaction).signatures.first,
      receivedAmount: receivedAmount,
      timestamp: timestamp,
    );
  }

  _EventHandler get _eventHandler => (event, emit) => event.map(
        waitingFailed: (event) => _onWaitingFailed(event, emit),
        txAdded: (event) => _onTxAdded(event, emit),
        verificationFailed: (event) => _onVerificationFailed(event, emit),
        suceeded: (event) => _onSucceeded(event, emit),
      );

  Future<void> _onWaitingFailed(WaitingFailed _, _Emitter emit) async {
    emit(const Retrying());

    await Future<void>.delayed(_currentBackoff);
    _currentBackoff *= _backoffStep;
    if (_currentBackoff > _maxBackoff) {
      _currentBackoff = _maxBackoff;
    }
    _waitForTx();
  }

  Future<void> _onTxAdded(TxAdded event, _Emitter _) async {
    await _verifyTx(event.ids);
  }

  Future<void> _onVerificationFailed(
    VerificationFailed event,
    _Emitter emit,
  ) async {
    if (event.error is ValidateTransactionException) {
      emit(const Failure());

      return;
    }

    emit(const Retrying());

    await Future<void>.delayed(_currentBackoff);
    _currentBackoff *= _backoffStep;
    if (_currentBackoff > _maxBackoff) {
      _currentBackoff = _maxBackoff;
    }
    await _verifyTx(event.ids);
  }

  void _onSucceeded(Succeeded e, _Emitter emit) {
    emit(Success(responses: e.responses));
  }
}

const _backoffStep = 2;
const _minBackoff = Duration(seconds: 2);
const _maxBackoff = Duration(minutes: 1);

extension on SolanaClient {
  Future<List<TransactionId>?> findSolanaPayTransactions({
    required Ed25519HDPublicKey reference,
    Commitment commitment = Commitment.finalized,
  }) async {
    final signatures = await rpcClient.getSignaturesForAddress(
      reference.toBase58(),
      commitment: commitment,
    );

    if (signatures.isEmpty) return null;

    return signatures.map((a) => a.signature).toList();
  }

  Future<TransactionDetails> validatePayTransaction({
    required TransactionId signature,
    Iterable<Ed25519HDPublicKey>? reference,
    Commitment commitment = Commitment.finalized,
  }) async {
    final response = await rpcClient.getTransaction(
      signature,
      commitment: commitment,
    );

    if (response == null) {
      throw const ValidateTransactionException('Transaction not found.');
    }

    final meta = response.meta;
    if (meta == null) {
      throw const ValidateTransactionException('Missing meta.');
    }

    if (meta.err != null) {
      throw const ValidateTransactionException('Transaction error.');
    }

    if (reference != null) {
      final keys = (response.transaction as ParsedTransaction)
          .message
          .accountKeys
          .map((e) => e.pubkey);
      if (reference.any((e) => !keys.contains(e.toBase58()))) {
        throw const ValidateTransactionException('Reference not found.');
      }
    }

    return response;
  }
}
