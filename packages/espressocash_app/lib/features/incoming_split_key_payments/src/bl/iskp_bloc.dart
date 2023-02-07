import 'package:dfunc/dfunc.dart';
import 'package:dio/dio.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

import '../../../../config.dart';
import '../../../../core/extensions.dart';
import '../../../../core/transactions/resign_tx.dart';
import '../../../../core/transactions/tx_sender.dart';
import 'incoming_split_key_payment.dart';
import 'iskp_repository.dart';

part 'iskp_bloc.freezed.dart';

@freezed
class ISKPEvent with _$ISKPEvent {
  const factory ISKPEvent.create(
    Ed25519HDKeyPair escrow, {
    required String id,
  }) = ISKPEventCreate;

  const factory ISKPEvent.process(String id) = ISKPEventProcess;
}

typedef ISKPState = ISet<String>;

typedef _Event = ISKPEvent;
typedef _State = ISKPState;
typedef _Emitter = Emitter<_State>;

@injectable
class ISKPBloc extends Bloc<_Event, _State> {
  ISKPBloc({
    required ISKPRepository repository,
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
      id: event.id,
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
          .then((it) => it.resign(escrow));

      return ISKPStatus.txCreated(tx);
    } on DioError catch (e) {
      if (e.toEspressoCashError() == EspressoCashError.invalidEscrowAccount) {
        return const ISKPStatus.txEscrowFailure();
      }

      return const ISKPStatus.txFailure();
    } on Exception {
      return const ISKPStatus.txFailure();
    }
  }

  Future<ISKPStatus> _sendTx(SignedTx tx) async {
    final result = await _txSender.send(tx);

    return result.map(
      sent: (_) => ISKPStatus.txSent(tx),
      invalidBlockhash: (_) => const ISKPStatus.txFailure(),
      failure: (_) => const ISKPStatus.txEscrowFailure(),
      networkError: (_) => ISKPStatus.txSendFailure(tx),
    );
  }

  Future<ISKPStatus> _waitTx(SignedTx tx) async {
    final result = await _txSender.wait(tx);

    return result.map(
      success: (_) => ISKPStatus.success(txId: tx.id),
      failure: (_) => const ISKPStatus.txEscrowFailure(),
      networkError: (_) => ISKPStatus.txWaitFailure(tx),
    );
  }
}
