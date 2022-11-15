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
import '../../../outgoing_split_key_payments/module.dart';

part 'oskp_cancel_bloc.freezed.dart';

@freezed
class OSKPCancelException with _$OSKPCancelException implements Exception {
  const factory OSKPCancelException.nonCancelable() = _NonCancelable;
  const factory OSKPCancelException.generic(Exception e) = _Generic;
}

typedef OSKPCancelState = ISet<String>;

@freezed
class OSKPCancelEvent with _$OSKPCancelEvent {
  const factory OSKPCancelEvent.cancelRequested(String id) = _CancelRequested;
  const factory OSKPCancelEvent.process(String id) = _Process;
}

typedef _Event = OSKPCancelEvent;
typedef _State = OSKPCancelState;
typedef _EventHandler = EventHandler<_Event, _State>;
typedef _Emitter = Emitter<_State>;

@injectable
class OSKPCancelBloc extends Bloc<_Event, _State> {
  OSKPCancelBloc({
    @factoryParam required Ed25519HDKeyPair account,
    required CryptopleaseClient client,
    required OSKPRepository repository,
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
  final OSKPRepository _repository;
  final TxSender _txSender;

  _EventHandler get _handler => (event, emit) => event.map(
        cancelRequested: (e) => _onCancelRequested(e, emit),
        process: (e) => _onCancelRequested(e, emit),
      );

  Future<void> _onCancelRequested(
    _CancelRequested event,
    _Emitter emit,
  ) async {
    final payment = await _repository.load(event.id);

    if (payment == null) return;
    if (state.contains(payment.id)) return;

    emit(state.add(payment.id));

    final newStatus = await payment.status.map(
      txCreated: (tx) => _createReceivePayment(tx.escrow),
      linksReady: (tx) => _createReceivePayment(tx.escrow),
      txSendFailure: (tx) => _createReceivePayment(tx.escrow),
      txWaitFailure: (tx) => _createReceivePayment(tx.escrow),
      txLinksFailure: (tx) => _createReceivePayment(tx.escrow),
      txSent: (status) async => status,
      txConfirmed: (status) async => status,
      txFailure: (status) async => status,
      success: (status) async => status,
      cancel: (status) async => status.cancelStatus.map(
        txCreated: (it) => _sendTx(it.tx),
        txSent: (it) => _waitTx(it.tx),
        txSendFailure: (it) => _sendTx(it.tx),
        txWaitFailure: (it) => _waitTx(it.tx),
        success: (_) async => status,
        txFailure: (_) async => _createReceivePayment(status.escrow),
      ),
    );

    await _repository.save(payment.copyWith(status: newStatus));

    // final OSKPStatus newStatus = await payment.status.map(
    //   privateKeyReady: (_) => _createTx(payment.escrow),
    //   txCreated: (status) => _sendTx(status.tx),
    //   txSent: (status) => _waitTx(status.txId),
    //   success: (status) async => status,
    //   txFailure: (_) => _createTx(payment.escrow),
    //   txSendFailure: (status) => _sendTx(status.tx),
    //   txWaitFailure: (status) => _waitTx(status.txId),
    //   txEscrowFailure: (status) async => status,
    // );

    // await _repository.save(payment.copyWith(status: newStatus));

    emit(state.remove(payment.id));

    newStatus.map(
      txCreated: ignore,
      txSent: ignore,
      txConfirmed: ignore,
      linksReady: ignore,
      success: ignore,
      txFailure: ignore,
      txSendFailure: ignore,
      txWaitFailure: ignore,
      txLinksFailure: ignore,
      cancel: cancel,
    );
  }

  Future<OSKPStatus> _createReceivePayment(Ed25519HDKeyPair escrow) async {
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

      return OSKPStatus.cancel(
        escrow: escrow,
        cancelStatus: OSKPCancelStatus.txCreated(tx),
      );
    } on Exception {
      return OSKPStatus.cancel(
        escrow: escrow,
        cancelStatus: const OSKPCancelStatus.txFailure(),
      );
    }
  }

  Future<OSKPStatus> _sendTx(SignedTx tx) async {
    final result = await _txSender.send(tx);

    return result.map(
      sent: (_) => OSKPStatus.txSent(tx.id),
      invalidBlockhash: (_) => const OSKPStatus.txFailure(),
      failure: (_) => const OSKPStatus.txEscrowFailure(),
      networkError: (_) => OSKPStatus.txSendFailure(tx),
    );
  }

  Future<OSKPStatus> _waitTx(SignedTx tx) async {
    final result = await _txSender.wait(txId);

    return result.map(
      success: (_) => OSKPStatus.success(txId: txId),
      failure: (_) => const OSKPStatus.txEscrowFailure(),
      networkError: (_) => OSKPStatus.txWaitFailure(txId),
    );
  }
}
