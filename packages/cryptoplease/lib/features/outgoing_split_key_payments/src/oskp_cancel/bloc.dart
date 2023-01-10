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
import '../../models/outgoing_split_key_payment.dart';
import 'oskp_cancel.dart';
import 'repository.dart';

part 'bloc.freezed.dart';

@freezed
class OSKPCancelException with _$OSKPCancelException implements Exception {
  const factory OSKPCancelException.nonCancelable() = _NonCancelable;
  const factory OSKPCancelException.generic(Exception e) = _Generic;
}

typedef OSKPCancelState = ISet<String>;

@freezed
class OSKPCancelEvent with _$OSKPCancelEvent {
  const factory OSKPCancelEvent.cancelRequested(OutgoingSplitKeyPayment oskp) =
      _CancelRequested;
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
    required OSKPCancelRepository repository,
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
  final OSKPCancelRepository _repository;
  final TxSender _txSender;

  _EventHandler get _handler => (event, emit) => event.map(
        cancelRequested: (e) => _onCreate(e, emit),
        process: (e) => _onProcess(e, emit),
      );

  Future<void> _onCreate(_CancelRequested event, _Emitter _) async {
    final escrow = event.oskp.status.map(
      txCreated: (status) => status.escrow,
      txSent: (status) => status.escrow,
      txConfirmed: (status) => status.escrow,
      linksReady: (status) => status.escrow,
      canceled: (_) => null,
      withdrawn: (_) => null,
      txFailure: (_) => null,
      txSendFailure: (status) => status.escrow,
      txWaitFailure: (status) => status.escrow,
      txLinksFailure: (status) => status.escrow,
    );
    final oskpId = event.oskp.id;

    if (escrow == null) return;

    final status = await _createReceivePayment(escrow);

    final cancel = OSKPCancel(
      oskpId: oskpId,
      created: DateTime.now(),
      escrow: escrow,
      status: status,
    );

    await _repository.save(cancel);

    if (status is OSKPCancelStatusTxCreated) {
      add(OSKPCancelEvent.process(oskpId));
    }
  }

  Future<void> _onProcess(_Process event, _Emitter emit) async {
    final cancel = await _repository.load(event.id);

    if (cancel == null) return;
    if (state.contains(cancel.oskpId)) return;

    emit(state.add(cancel.oskpId));

    final newStatus = await cancel.status.map(
      txCreated: (status) => _sendTx(status.tx),
      txSent: (status) => _waitTx(status.tx),
      success: (status) async => status,
      txFailure: (_) => _createReceivePayment(cancel.escrow),
      txSendFailure: (status) => _sendTx(status.tx),
      txWaitFailure: (status) => _waitTx(status.tx),
      txEscrowFailure: (status) async => status,
    );

    await _repository.save(cancel.copyWith(status: newStatus));

    emit(state.remove(cancel.oskpId));

    newStatus.map(
      txCreated: (_) => add(OSKPCancelEvent.process(cancel.oskpId)),
      txSent: (_) => add(OSKPCancelEvent.process(cancel.oskpId)),
      success: ignore,
      txFailure: ignore,
      txSendFailure: ignore,
      txWaitFailure: ignore,
      txEscrowFailure: ignore,
    );
  }

  Future<OSKPCancelStatus> _createReceivePayment(
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

      return OSKPCancelStatus.txCreated(tx);
    } on Exception {
      return const OSKPCancelStatus.txFailure();
    }
  }

  Future<OSKPCancelStatus> _sendTx(SignedTx tx) async {
    final result = await _txSender.send(tx);

    return result.map(
      sent: (_) => OSKPCancelStatus.txSent(tx),
      invalidBlockhash: (_) => const OSKPCancelStatus.txFailure(),
      failure: (_) => const OSKPCancelStatus.txEscrowFailure(),
      networkError: (_) => OSKPCancelStatus.txSendFailure(tx),
    );
  }

  Future<OSKPCancelStatus> _waitTx(SignedTx tx) async {
    final result = await _txSender.wait(tx);

    return result.map(
      success: (_) => OSKPCancelStatus.success(txId: tx.id),
      failure: (_) => const OSKPCancelStatus.txEscrowFailure(),
      networkError: (_) => OSKPCancelStatus.txWaitFailure(tx),
    );
  }
}
