import 'package:cryptoplease/config.dart';
import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/resign_tx.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/core/tx_sender.dart';
import 'package:cryptoplease/features/outgoing_direct_payments/bl/outgoing_direct_payment.dart';
import 'package:cryptoplease/features/outgoing_direct_payments/bl/repository.dart';
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
class ODPEvent with _$ODPEvent {
  const factory ODPEvent.create({
    required Ed25519HDPublicKey receiver,
    required CryptoAmount amount,
  }) = ODPEventCreate;

  const factory ODPEvent.process(String id) = ODPEventProcess;
}

typedef ODPState = ISet<String>;

typedef _Event = ODPEvent;
typedef _State = ODPState;
typedef _Emitter = Emitter<_State>;

class ODPBloc extends Bloc<_Event, _State> {
  ODPBloc({
    required ODPRepository repository,
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

  final ODPRepository _repository;
  final CryptopleaseClient _client;
  final Ed25519HDKeyPair _account;
  final TxSender _txSender;

  EventHandler<_Event, _State> get _handler => (event, emit) => event.map(
        create: (e) => _onCreate(e, emit),
        process: (e) => _onProcess(e, emit),
      );

  Future<void> _onCreate(ODPEventCreate event, _Emitter _) async {
    if (event.amount.token != Token.usdc) {
      throw ArgumentError('Only USDC is supported');
    }

    final status = await _createTx(event.receiver, event.amount);

    final payment = OutgoingDirectPayment(
      id: const Uuid().v4(),
      receiver: event.receiver,
      amount: event.amount,
      created: DateTime.now(),
      status: status,
    );

    await _repository.save(payment);

    if (status is ODPStatusTxCreated) {
      add(ODPEvent.process(payment.id));
    }
  }

  Future<void> _onProcess(ODPEventProcess event, _Emitter emit) async {
    final payment = await _repository.load(event.id);

    if (payment == null) return;
    if (state.contains(payment.id)) return;

    emit(state.add(payment.id));

    final ODPStatus newStatus = await payment.status.map(
      txCreated: (status) => _sendTx(status.tx),
      txSent: (status) => _waitTx(status.txId),
      success: (status) async => status,
      txFailure: (_) => _createTx(payment.receiver, payment.amount),
      txSendFailure: (status) => _sendTx(status.tx),
      txWaitFailure: (status) => _waitTx(status.txId),
    );

    await _repository.save(payment.copyWith(status: newStatus));

    emit(state.remove(payment.id));

    newStatus.map(
      txCreated: (_) => add(ODPEvent.process(payment.id)),
      txSent: (_) => add(ODPEvent.process(payment.id)),
      success: ignore,
      txFailure: ignore,
      txSendFailure: ignore,
      txWaitFailure: ignore,
    );
  }

  Future<ODPStatus> _createTx(
    Ed25519HDPublicKey receiver,
    Amount amount,
  ) async {
    try {
      final dto = CreateDirectPaymentRequestDto(
        senderAccount: _account.address,
        receiverAccount: receiver.toBase58(),
        amount: amount.value,
        cluster: apiCluster,
      );
      final tx = await _client
          .createDirectPayment(dto)
          .then((it) => it.transaction)
          .then(SignedTx.decode)
          .then((it) => it.resign(_account));

      return ODPStatus.txCreated(tx);
    } on Exception {
      return const ODPStatus.txFailure();
    }
  }

  Future<ODPStatus> _sendTx(SignedTx tx) async {
    final result = await _txSender.send(tx);

    return result.map(
      sent: (_) => ODPStatus.txSent(tx.id),
      invalidBlockhash: (_) => const ODPStatus.txFailure(),
      failure: (_) => const ODPStatus.txFailure(),
      networkError: (_) => ODPStatus.txSendFailure(tx),
    );
  }

  Future<ODPStatus> _waitTx(String txId) async {
    final result = await _txSender.wait(txId);

    return result.map(
      success: (_) => ODPStatus.success(txId: txId),
      failure: (_) => const ODPStatus.txFailure(),
      networkError: (_) => ODPStatus.txWaitFailure(txId),
    );
  }
}
