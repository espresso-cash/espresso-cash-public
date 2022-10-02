import 'package:cryptoplease/config.dart';
import 'package:cryptoplease/core/resign_tx.dart';
import 'package:cryptoplease/core/tx_sender.dart';
import 'package:cryptoplease/features/incoming_split_key_payments/bl/incoming_split_key_payment.dart';
import 'package:cryptoplease/features/incoming_split_key_payments/bl/repository.dart';
import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';
import 'package:uuid/uuid.dart';

part 'bloc.freezed.dart';

@freezed
class ISKPEvent with _$ISKPEvent {
  const factory ISKPEvent.create(Ed25519HDKeyPair escrow) = ISKPEventCreate;

  const factory ISKPEvent.process(String id) = ISKPEventProcess;
}

typedef ISKPState = ISet<String>;

typedef _Event = ISKPEvent;
typedef _State = ISKPState;
typedef _Emitter = Emitter<_State>;

class ISKPBloc extends Bloc<_Event, _State> {
  ISKPBloc({
    required ISKPRepository repository,
    required CryptopleaseClient client,
    required Ed25519HDKeyPair account,
    required TxSender txSender,
  })  : _repository = repository,
        _client = client,
        _account = account,
        _txSender = txSender,
        super(const ISetConst({})) {
    on<_Event>(_handler);
  }

  final ISKPRepository _repository;
  final CryptopleaseClient _client;
  final Ed25519HDKeyPair _account;
  final TxSender _txSender;

  EventHandler<_Event, _State> get _handler => (event, emit) => event.map(
        create: (e) => _onCreate(e, emit),
        process: (e) => _onProcess(e, emit),
      );

  Future<void> _onCreate(ISKPEventCreate event, _Emitter _) async {
    // TODO(KB): Check whether the account is correct.

    final status = await _createTx(event.escrow);

    final payment = IncomingSplitKeyPayment(
      id: const Uuid().v4(),
      created: DateTime.now(),
      escrow: event.escrow,
      status: status,
    );

    await _repository.save(payment);

    if (status is ISKPStatusTxCreated) {
      add(ISKPEvent.process(payment.id));
    }
  }

  Future<void> _onProcess(ISKPEventProcess event, _Emitter emit) async {
    final payment = await _repository.load(event.id);

    if (payment == null) return;
    if (state.contains(payment.id)) return;

    emit(state.add(payment.id));

    final ISKPStatus newStatus = await payment.status.map(
      privateKeyReady: (_) => _createTx(payment.escrow),
      txCreated: (status) => _sendTx(status.tx),
      txSent: (status) => _waitTx(status.txId),
      success: (status) async => status,
      txFailure: (_) => _createTx(payment.escrow),
      txSendFailure: (status) => _sendTx(status.tx),
      txWaitFailure: (status) => _waitTx(status.txId),
      txEscrowFailure: (status) async => status,
    );

    await _repository.save(payment.copyWith(status: newStatus));

    emit(state.remove(payment.id));

    newStatus.map(
      privateKeyReady: (_) => add(ISKPEvent.process(payment.id)),
      txCreated: (_) => add(ISKPEvent.process(payment.id)),
      txSent: (_) => add(ISKPEvent.process(payment.id)),
      success: ignore,
      txFailure: ignore,
      txSendFailure: ignore,
      txWaitFailure: ignore,
      txEscrowFailure: ignore,
    );
  }

  Future<ISKPStatus> _createTx(Ed25519HDKeyPair escrow) async {
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
          .then((it) => it.resign(_account));

      return ISKPStatus.txCreated(tx);
    } on Exception {
      return const ISKPStatus.txFailure();
    }
  }

  Future<ISKPStatus> _sendTx(SignedTx tx) async {
    final result = await _txSender.send(tx);

    return result.map(
      sent: (_) => ISKPStatus.txSent(tx.id),
      invalidBlockhash: (_) => const ISKPStatus.txFailure(),
      failure: (_) => const ISKPStatus.txEscrowFailure(),
      networkError: (_) => ISKPStatus.txSendFailure(tx),
    );
  }

  Future<ISKPStatus> _waitTx(String txId) async {
    final result = await _txSender.wait(txId);

    return result.map(
      success: (_) => const ISKPStatus.success(),
      failure: (_) => const ISKPStatus.txEscrowFailure(),
      networkError: (_) => ISKPStatus.txWaitFailure(txId),
    );
  }
}
