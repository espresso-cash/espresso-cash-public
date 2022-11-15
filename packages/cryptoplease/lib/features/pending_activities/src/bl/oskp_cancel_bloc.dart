import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

import '../../../../config.dart';
import '../../../../core/transactions/resign_tx.dart';
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
  })  : _account = account,
        _client = client,
        _repository = repository,
        super(const ISetConst({})) {
    on<_Event>(_handler);
  }

  final Ed25519HDKeyPair _account;
  final CryptopleaseClient _client;
  final OSKPRepository _repository;

  _EventHandler get _handler => (event, emit) => event.map(
        cancelRequested: (e) => _onCancelRequested(e, emit),
        process: (e) => _onCancelRequested(e, emit),
      );

  Future<void> _onCancelRequested(
    _CancelRequested event,
    _Emitter emit,
  ) async {
    final payment = await _repository.load(event.id);
    final escrow = payment?.escrow;

    if (payment == null || escrow == null) return;
    if (state.contains(payment.id)) return;

    emit(state.add(payment.id));

    final newStatus = await _revert(escrow);

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
      txCreated: txCreated,
      txSent: txSent,
      txConfirmed: txConfirmed,
      linksReady: linksReady,
      success: success,
      txFailure: txFailure,
      txSendFailure: txSendFailure,
      txWaitFailure: txWaitFailure,
      txLinksFailure: txLinksFailure,
      cancel: cancel,
    );
  }

  Future<OSKPStatus> _revert(Ed25519HDKeyPair escrow) async {
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
}

extension OSKPCancelExt on OutgoingSplitKeyPayment {
  bool isCancelable() => escrow != null;

  Ed25519HDKeyPair? get escrow => status.map(
        txCreated: (tx) => tx.escrow,
        linksReady: (tx) => tx.escrow,
        txSendFailure: (tx) => tx.escrow,
        txWaitFailure: (tx) => tx.escrow,
        txLinksFailure: (tx) => tx.escrow,
        txSent: (_) => null,
        txConfirmed: (_) => null,
        txFailure: (_) => null,
        success: (_) => null,
        cancel: (c) => c.escrow,
      );
}
