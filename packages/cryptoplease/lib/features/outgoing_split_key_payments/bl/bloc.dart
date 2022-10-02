import 'package:cryptoplease/config.dart';
import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/payments/split_key_payments/split_key_api_version.dart';
import 'package:cryptoplease/core/resign_tx.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/core/tx_sender.dart';
import 'package:cryptoplease/features/incoming_split_key_payment/bl/models.dart';
import 'package:cryptoplease/features/outgoing_split_key_payments/bl/link_shortener.dart';
import 'package:cryptoplease/features/outgoing_split_key_payments/bl/outgoing_split_key_payment.dart';
import 'package:cryptoplease/features/outgoing_split_key_payments/bl/repository.dart';
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
class OSKPEvent with _$OSKPEvent {
  const factory OSKPEvent.create({required CryptoAmount amount}) =
      OSKPEventCreate;

  const factory OSKPEvent.process(String id) = OSKPEventProcess;
}

typedef OSKPState = ISet<String>;

typedef _Event = OSKPEvent;
typedef _State = OSKPState;
typedef _Emitter = Emitter<_State>;

class OSKPBloc extends Bloc<_Event, _State> {
  OSKPBloc({
    required Ed25519HDKeyPair account,
    required CryptopleaseClient client,
    required OSKPRepository repository,
    required TxSender txSender,
    LinkShortener linkShortener = const LinkShortener(),
  })  : _account = account,
        _client = client,
        _repository = repository,
        _txSender = txSender,
        _linkShortener = linkShortener,
        super(const ISetConst({})) {
    on<_Event>(_handler);
  }

  final Ed25519HDKeyPair _account;
  final CryptopleaseClient _client;
  final OSKPRepository _repository;
  final TxSender _txSender;
  final LinkShortener _linkShortener;

  EventHandler<_Event, _State> get _handler => (event, emit) => event.map(
        create: (e) => _onCreate(e, emit),
        process: (e) => _onProcess(e, emit),
      );

  Future<void> _onCreate(OSKPEventCreate event, _Emitter _) async {
    if (event.amount.token != Token.usdc) {
      throw ArgumentError('Only USDC is supported');
    }

    final status = await _createTx(event.amount);

    final payment = OutgoingSplitKeyPayment(
      id: const Uuid().v4(),
      amount: event.amount,
      created: DateTime.now(),
      status: status,
    );

    await _repository.save(payment);

    if (status is OSKPStatusTxCreated) {
      add(OSKPEvent.process(payment.id));
    }
  }

  Future<void> _onProcess(OSKPEventProcess event, _Emitter emit) async {
    final payment = await _repository.load(event.id);

    if (payment == null) return;
    if (state.contains(payment.id)) return;

    emit(state.add(payment.id));

    final OSKPStatus newStatus = await payment.status.map(
      txCreated: (status) => _sendTx(status.tx, escrow: status.escrow),
      txSent: (status) => _waitTx(status.txId, escrow: status.escrow),
      txConfirmed: (status) => _createLinks(
        escrow: status.escrow,
        token: payment.amount.token,
      ),
      linksReady: (status) async => status,
      success: (status) async => status,
      txFailure: (_) => _createTx(payment.amount),
      txSendFailure: (status) => _sendTx(status.tx, escrow: status.escrow),
      txWaitFailure: (status) => _waitTx(status.txId, escrow: status.escrow),
      txLinksFailure: (status) => _createLinks(
        escrow: status.escrow,
        token: payment.amount.token,
      ),
    );

    await _repository.save(payment.copyWith(status: newStatus));

    emit(state.remove(payment.id));

    newStatus.map(
      txCreated: (_) => add(OSKPEvent.process(payment.id)),
      txSent: (_) => add(OSKPEvent.process(payment.id)),
      txConfirmed: (_) => add(OSKPEvent.process(payment.id)),
      linksReady: ignore,
      success: ignore,
      txFailure: ignore,
      txSendFailure: ignore,
      txWaitFailure: ignore,
      txLinksFailure: ignore,
    );
  }

  Future<OSKPStatus> _createTx(Amount amount) async {
    try {
      final escrowAccount = await Ed25519HDKeyPair.random();

      final dto = CreatePaymentRequestDto(
        senderAccount: _account.address,
        escrowAccount: escrowAccount.address,
        amount: amount.value,
        cluster: apiCluster,
      );

      final tx = await _client
          .createPayment(dto)
          .then((it) => it.transaction)
          .then(SignedTx.decode)
          .then((it) => it.resign(_account));

      return OSKPStatus.txCreated(tx, escrow: escrowAccount);
    } on Exception {
      return const OSKPStatus.txFailure();
    }
  }

  Future<OSKPStatus> _sendTx(
    SignedTx tx, {
    required Ed25519HDKeyPair escrow,
  }) async {
    final result = await _txSender.send(tx);

    return result.map(
      sent: (_) => OSKPStatus.txSent(tx.id, escrow: escrow),
      invalidBlockhash: (_) => const OSKPStatus.txFailure(),
      failure: (_) => const OSKPStatus.txFailure(),
      networkError: (_) => OSKPStatus.txSendFailure(tx, escrow: escrow),
    );
  }

  Future<OSKPStatus> _waitTx(
    String txId, {
    required Ed25519HDKeyPair escrow,
  }) async {
    final result = await _txSender.wait(txId);

    return result.map(
      success: (_) => OSKPStatus.txConfirmed(escrow: escrow),
      failure: (_) => const OSKPStatus.txFailure(),
      networkError: (_) => OSKPStatus.txWaitFailure(txId, escrow: escrow),
    );
  }

  Future<OSKPStatus> _createLinks({
    required Ed25519HDKeyPair escrow,
    required Token token,
  }) async {
    final privateKey = await escrow.extract().then((value) => value.bytes.lock);
    final rawFirstLink = buildFirstLink(
      privateKey,
      token.address,
      SplitKeyApiVersion.v2,
    );

    final firstLink = await _linkShortener.shorten(rawFirstLink);
    if (firstLink == null) {
      return OSKPStatus.txLinksFailure(escrow: escrow);
    }

    final secondLink = buildSecondLink(privateKey);

    return OSKPStatus.linksReady(
      link1: firstLink,
      link2: secondLink,
      escrow: escrow,
    );
  }
}
