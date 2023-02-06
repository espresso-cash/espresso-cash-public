import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:dfunc/dfunc.dart';
import 'package:dio/dio.dart';
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
import 'incoming_tip_payment.dart';
import 'it_repository.dart';

part 'it_bloc.freezed.dart';

@freezed
class ITEvent with _$ITEvent {
  const factory ITEvent.create(
    Ed25519HDKeyPair escrow, {
    required String id,
  }) = ITEventCreate;

  const factory ITEvent.process(String id) = ITEventProcess;
}

typedef ITState = ISet<String>;

typedef _Event = ITEvent;
typedef _State = ITState;
typedef _Emitter = Emitter<_State>;

@injectable
class ITBloc extends Bloc<_Event, _State> {
  ITBloc({
    required ITRepository repository,
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

  final ITRepository _repository;
  final CryptopleaseClient _client;
  final Ed25519HDKeyPair _account;
  final TxSender _txSender;

  EventHandler<_Event, _State> get _handler => (event, emit) => event.map(
        create: (e) => _onCreate(e, emit),
        process: (e) => _onProcess(e, emit),
      );

  Future<void> _onCreate(ITEventCreate event, _Emitter _) async {
    final status = await _createTx(event.escrow);

    final payment = IncomingTipPayment(
      id: event.id,
      created: DateTime.now(),
      escrow: event.escrow,
      status: status,
    );

    await _repository.save(payment);

    if (status is ITStatusTxCreated) {
      add(ITEvent.process(payment.id));
    }
  }

  Future<void> _onProcess(ITEventProcess event, _Emitter emit) async {
    final payment = await _repository.load(event.id);

    if (payment == null) return;
    if (state.contains(payment.id)) return;

    emit(state.add(payment.id));

    final ITStatus newStatus = await payment.status.map(
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
      privateKeyReady: (_) => add(ITEvent.process(payment.id)),
      txCreated: (_) => add(ITEvent.process(payment.id)),
      txSent: (_) => add(ITEvent.process(payment.id)),
      success: ignore,
      txFailure: ignore,
      txSendFailure: ignore,
      txWaitFailure: ignore,
      txEscrowFailure: ignore,
    );
  }

  Future<ITStatus> _createTx(Ed25519HDKeyPair escrow) async {
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

      return ITStatus.txCreated(tx);
    } on DioError catch (e) {
      if (e.toEspressoCashError() == EspressoCashError.invalidEscrowAccount) {
        return const ITStatus.txEscrowFailure();
      }

      return const ITStatus.txFailure();
    } on Exception {
      return const ITStatus.txFailure();
    }
  }

  Future<ITStatus> _sendTx(SignedTx tx) async {
    final result = await _txSender.send(tx);

    return result.map(
      sent: (_) => ITStatus.txSent(tx),
      invalidBlockhash: (_) => const ITStatus.txFailure(),
      failure: (_) => const ITStatus.txEscrowFailure(),
      networkError: (_) => ITStatus.txSendFailure(tx),
    );
  }

  Future<ITStatus> _waitTx(SignedTx tx) async {
    final result = await _txSender.wait(tx);

    return result.map(
      success: (_) => ITStatus.success(txId: tx.id),
      failure: (_) => const ITStatus.txEscrowFailure(),
      networkError: (_) => ITStatus.txWaitFailure(tx),
    );
  }
}
