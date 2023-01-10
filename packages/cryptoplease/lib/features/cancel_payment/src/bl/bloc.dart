import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

import '../../../../config.dart';
import '../../../../core/transactions/resign_tx.dart';
import '../../../../core/transactions/tx_sender.dart';
import '../payment_cancel.dart';
import 'repository.dart';

part 'bloc.freezed.dart';

@freezed
class PaymentCancelException
    with _$PaymentCancelException
    implements Exception {
  const factory PaymentCancelException.nonCancelable() = _NonCancelable;
  const factory PaymentCancelException.generic(Exception e) = _Generic;
}

typedef PaymentCancelState = ISet<String>;

@freezed
class PaymentCancelEvent with _$PaymentCancelEvent {
  const factory PaymentCancelEvent.cancelRequested({
    required String paymentId,
    required Ed25519HDKeyPair escrow,
  }) = _CancelRequested;

  const factory PaymentCancelEvent.process(String id) = _Process;
}

typedef _Event = PaymentCancelEvent;
typedef _State = PaymentCancelState;
typedef _EventHandler = EventHandler<_Event, _State>;
typedef _Emitter = Emitter<_State>;

@injectable
class PaymentCancelBloc extends Bloc<_Event, _State> {
  PaymentCancelBloc({
    @factoryParam required Ed25519HDKeyPair account,
    required CryptopleaseClient client,
    required PaymentCancelRepository repository,
    required TxSender txSender,
  })  : _account = account,
        _client = client,
        _repository = repository,
        _txSender = txSender,
        super(const ISetConst({})) {
    on<_Event>(_handler);
  }

  final Ed25519HDKeyPair _account;
  final CryptopleaseClient _client;
  final PaymentCancelRepository _repository;
  final TxSender _txSender;

  _EventHandler get _handler => (event, emit) => event.map(
        cancelRequested: (e) => _onCancelRequested(e, emit),
        process: (e) => _onProcess(e, emit),
      );

  Future<void> _onCancelRequested(_CancelRequested event, _Emitter _) async {
    final paymentId = event.paymentId;
    final escrow = event.escrow;

    final status = await _createReversalPayment(escrow);

    final cancel = PaymentCancel(
      paymentId: paymentId,
      created: DateTime.now(),
      escrow: escrow,
      status: status,
    );

    await _repository.save(cancel);

    if (status is PaymentCancelStatusTxCreated) {
      add(PaymentCancelEvent.process(paymentId));
    }
  }

  Future<void> _onProcess(_Process event, _Emitter emit) async {
    final cancel = await _repository.load(event.id);

    if (cancel == null) return;
    if (state.contains(cancel.paymentId)) return;

    emit(state.add(cancel.paymentId));

    final newStatus = await cancel.status.map(
      txCreated: (status) => _sendTx(status.tx),
      txSent: (status) => _waitTx(status.tx),
      success: (status) async => status,
      txFailure: (_) => _createReversalPayment(cancel.escrow),
      txSendFailure: (status) => _sendTx(status.tx),
      txWaitFailure: (status) => _waitTx(status.tx),
      txEscrowFailure: (status) async => status,
    );

    await _repository.save(cancel.copyWith(status: newStatus));

    emit(state.remove(cancel.paymentId));

    newStatus.map(
      txCreated: (_) => add(PaymentCancelEvent.process(cancel.paymentId)),
      txSent: (_) => add(PaymentCancelEvent.process(cancel.paymentId)),
      success: ignore,
      txFailure: ignore,
      txSendFailure: ignore,
      txWaitFailure: ignore,
      txEscrowFailure: ignore,
    );
  }

  Future<PaymentCancelStatus> _createReversalPayment(
    Ed25519HDKeyPair escrow,
  ) async {
    try {
      final dto = ReceivePaymentRequestDto(
        receiverAccount: _account.address,
        escrowAccount: escrow.address,
        cluster: apiCluster,
      );

      final tx = await _client
          .receivePayment(dto)
          .then((it) => it.transaction)
          .then(SignedTx.decode)
          .then((it) => it.resign(escrow));

      return PaymentCancelStatus.txCreated(tx);
    } on Exception {
      return const PaymentCancelStatus.txFailure();
    }
  }

  Future<PaymentCancelStatus> _sendTx(SignedTx tx) async {
    final result = await _txSender.send(tx);

    return result.map(
      sent: (_) => PaymentCancelStatus.txSent(tx),
      invalidBlockhash: (_) => const PaymentCancelStatus.txFailure(),
      failure: (_) => const PaymentCancelStatus.txEscrowFailure(),
      networkError: (_) => PaymentCancelStatus.txSendFailure(tx),
    );
  }

  Future<PaymentCancelStatus> _waitTx(SignedTx tx) async {
    final result = await _txSender.wait(tx);

    return result.map(
      success: (_) => PaymentCancelStatus.success(txId: tx.id),
      failure: (_) => const PaymentCancelStatus.txEscrowFailure(),
      networkError: (_) => PaymentCancelStatus.txWaitFailure(tx),
    );
  }
}
