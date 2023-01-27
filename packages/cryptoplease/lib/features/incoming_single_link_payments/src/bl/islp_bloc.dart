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
import 'islp_payment.dart';
import 'islp_repository.dart';

part 'islp_bloc.freezed.dart';

@freezed
class ISLPEvent with _$ISLPEvent {
  const factory ISLPEvent.create(
    Ed25519HDKeyPair escrow, {
    required String id,
  }) = ISLPEventCreate;

  const factory ISLPEvent.process(String id) = ISLPEventProcess;
}

typedef ISLPState = ISet<String>;

typedef _Event = ISLPEvent;
typedef _State = ISLPState;
typedef _Emitter = Emitter<_State>;

@injectable
class ISLPBloc extends Bloc<_Event, _State> {
  ISLPBloc({
    required ISLPRepository repository,
    required CryptopleaseClient client,
    @factoryParam required Ed25519HDKeyPair account,
    required TxSender txSender,
  })  : _repository = repository,
        _client = client,
        _account = account,
        _txSender = txSender,
        super(const ISetConst({})) {
    on<_Event>(_handler);
  }

  final ISLPRepository _repository;
  final CryptopleaseClient _client;
  final Ed25519HDKeyPair _account;
  final TxSender _txSender;

  EventHandler<_Event, _State> get _handler => (event, emit) => event.map(
        create: (e) => _onCreate(e, emit),
        process: (e) => _onProcess(e, emit),
      );

  Future<void> _onCreate(ISLPEventCreate event, _Emitter _) async {
    final status = await _createTx(event.escrow);

    final payment = IncomingSingleLinkPayment(
      id: event.id,
      created: DateTime.now(),
      escrow: event.escrow,
      status: status,
    );

    await _repository.save(payment);

    if (status is ISLPStatusTxCreated) {
      add(ISLPEvent.process(payment.id));
    }
  }

  Future<void> _onProcess(ISLPEventProcess event, _Emitter emit) async {
    final payment = await _repository.load(event.id);

    if (payment == null) return;
    if (state.contains(payment.id)) return;

    emit(state.add(payment.id));

    final ISLPStatus newStatus = await payment.status.map(
      privateKeyReady: (_) => _createTx(payment.escrow),
      txCreated: (status) => _sendTx(status.tx),
      txSent: (status) => _waitTx(status.tx),
      success: (status) async => status,
      txFailure: (_) => _createTx(payment.escrow),
      txSendFailure: (status) => _sendTx(status.tx),
      txWaitFailure: (status) => _waitTx(status.tx),
      txEscrowFailure: (status) async => status,
    );

    await _repository.save(payment.copyWith(status: newStatus));

    emit(state.remove(payment.id));

    newStatus.map(
      privateKeyReady: (_) => add(ISLPEvent.process(payment.id)),
      txCreated: (_) => add(ISLPEvent.process(payment.id)),
      txSent: (_) => add(ISLPEvent.process(payment.id)),
      success: ignore,
      txFailure: ignore,
      txSendFailure: ignore,
      txWaitFailure: ignore,
      txEscrowFailure: ignore,
    );
  }

  Future<ISLPStatus> _createTx(Ed25519HDKeyPair escrow) async {
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

      return ISLPStatus.txCreated(tx);
    } on Exception {
      return const ISLPStatus.txFailure();
    }
  }

  Future<ISLPStatus> _sendTx(SignedTx tx) async {
    final result = await _txSender.send(tx);

    return result.map(
      sent: (_) => ISLPStatus.txSent(tx),
      invalidBlockhash: (_) => const ISLPStatus.txFailure(),
      failure: (_) => const ISLPStatus.txEscrowFailure(),
      networkError: (_) => ISLPStatus.txSendFailure(tx),
    );
  }

  Future<ISLPStatus> _waitTx(SignedTx tx) async {
    final result = await _txSender.wait(tx);

    return result.map(
      success: (_) => ISLPStatus.success(txId: tx.id),
      failure: (_) => const ISLPStatus.txEscrowFailure(),
      networkError: (_) => ISLPStatus.txWaitFailure(tx),
    );
  }
}
