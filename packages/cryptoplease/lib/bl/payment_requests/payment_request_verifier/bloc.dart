import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:cryptoplease/bl/payment_requests/payment_request.dart';
import 'package:cryptoplease/bl/payment_requests/repository.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:solana/solana.dart';
import 'package:solana/solana_pay.dart';

part 'bloc.freezed.dart';
part 'event.dart';
part 'state.dart';

typedef _Event = PaymentRequestVerifierEvent;
typedef _State = PaymentRequestVerifierState;
typedef _EventHandler = EventHandler<_Event, _State>;
typedef _Emitter = Emitter<_State>;

class PaymentRequestVerifierBloc extends Bloc<_Event, _State> {
  PaymentRequestVerifierBloc({
    required SolanaClient solanaClient,
    required PaymentRequest request,
    required PaymentRequestRepository repository,
  })  : _solanaClient = solanaClient,
        _request = request,
        _repository = repository,
        super(const Waiting()) {
    on<_Event>(_eventHandler, transformer: sequential());
    _waitForTx();
  }

  final SolanaClient _solanaClient;
  final PaymentRequest _request;
  final PaymentRequestRepository _repository;

  StreamSubscription<TransactionId>? _txSubscription;

  @override
  Future<void> close() async {
    await _txSubscription?.cancel();
    await super.close();
  }

  Duration _currentBackoff = _minBackoff;

  Future<void> _waitForTx() async {
    if (_request.state != PaymentRequestState.initial) return;

    final reference = _request.payRequest.reference?.firstOrNull;
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
      onError: (dynamic e) {
        _txSubscription?.cancel();
        add(WaitingFailed(e is Exception ? e : Exception(e)));
      },
    );
  }

  Future<void> _verifyTx(TransactionId id) async {
    try {
      await _solanaClient.validateSolanaPayTransaction(
        signature: id,
        recipient: _request.payRequest.recipient,
        amount: _request.payRequest.amount ?? Decimal.zero,
        commitment: Commitment.confirmed,
      );
      await _repository
          .save(_request.copyWith(state: PaymentRequestState.completed));
      add(const Succeeded());
    } on Exception catch (e) {
      add(VerificationFailed(e, transactionId: id));
    }
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
    await _waitForTx();
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
      await _repository
          .save(_request.copyWith(state: PaymentRequestState.error));
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

  Future<void> _onSucceeded(Succeeded _, _Emitter emit) async {
    emit(const Success());
  }
}

const _backoffStep = 2;
const _minBackoff = Duration(seconds: 2);
const _maxBackoff = Duration(minutes: 1);
