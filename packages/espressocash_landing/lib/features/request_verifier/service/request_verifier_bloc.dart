import 'dart:async';

import 'package:decimal/decimal.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:solana/solana.dart';
import 'package:solana/solana_pay.dart';

part 'request_verifier_bloc.freezed.dart';

@freezed
class PaymentRequestVerifierEvent with _$PaymentRequestVerifierEvent {
  const factory PaymentRequestVerifierEvent.init(SolanaPayRequest request) =
      Init;

  const factory PaymentRequestVerifierEvent.waitingFailed(Exception e) =
      WaitingFailed;

  const factory PaymentRequestVerifierEvent.txAdded(TransactionId id) = TxAdded;

  const factory PaymentRequestVerifierEvent.verificationFailed(
    Exception error, {
    required TransactionId transactionId,
  }) = VerificationFailed;

  const factory PaymentRequestVerifierEvent.suceeded() = Succeeded;
}

@freezed
sealed class PaymentRequestVerifierState with _$PaymentRequestVerifierState {
  const factory PaymentRequestVerifierState.waiting() = Waiting;
  const factory PaymentRequestVerifierState.retrying() = Retrying;
  const factory PaymentRequestVerifierState.verifying() = Verifying;
  const factory PaymentRequestVerifierState.success() = Success;
  const factory PaymentRequestVerifierState.failure() = Failure;
}

typedef _Event = PaymentRequestVerifierEvent;
typedef _State = PaymentRequestVerifierState;
typedef _EventHandler = EventHandler<_Event, _State>;
typedef _Emitter = Emitter<_State>;

@singleton
class RequestVerifierBloc extends Bloc<_Event, _State> {
  RequestVerifierBloc({
    required SolanaClient solanaClient,
  })  : _solanaClient = solanaClient,
        super(const Waiting()) {
    on<_Event>(_eventHandler);
  }

  final SolanaClient _solanaClient;
  late SolanaPayRequest _request;

  StreamSubscription<TransactionId>? _txSubscription;

  Duration _currentBackoff = _minBackoff;

  void _waitForTx() {
    final reference = _request.reference?.firstOrNull;
    if (reference == null) return;

    Stream<TransactionId> solanaPayTransaction() => _solanaClient
        .findSolanaPayTransaction(
          reference: reference,
          commitment: Commitment.confirmed,
        )
        .asStream()
        .whereType<TransactionId>();

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

  void _init(Init event) {
    _request = event.request;
    _waitForTx();
  }

  Future<void> _verifyTx(TransactionId id) async {
    try {
      await _solanaClient.validateSolanaPayTransaction(
        signature: id,
        recipient: _request.recipient,
        splToken: _request.splToken,
        reference: _request.reference,
        amount: Decimal.zero,
        commitment: Commitment.confirmed,
      );
      add(const Succeeded());
    } on Exception catch (error) {
      add(VerificationFailed(error, transactionId: id));
    }
  }

  _EventHandler get _eventHandler => (event, emit) => event.map(
        init: _init,
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

  Future<void> _onTxAdded(TxAdded event, _Emitter emit) async {
    emit(const Verifying());

    await _verifyTx(event.id);
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
    await _verifyTx(event.transactionId);
  }

  void _onSucceeded(Succeeded _, _Emitter emit) {
    emit(const Success());
  }

  @override
  Future<void> close() async {
    await _txSubscription?.cancel();
    await super.close();
  }
}

const _backoffStep = 2;
const _minBackoff = Duration(seconds: 2);
const _maxBackoff = Duration(minutes: 1);
