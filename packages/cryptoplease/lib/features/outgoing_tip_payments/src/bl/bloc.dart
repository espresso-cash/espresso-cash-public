import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/base58.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

import '../../../../config.dart';
import '../../../../core/amount.dart';
import '../../../../core/link_shortener.dart';
import '../../../../core/tip_payments.dart';
import '../../../../core/tokens/token.dart';
import '../../../../core/transactions/resign_tx.dart';
import '../../../../core/transactions/tx_sender.dart';
import '../../models/outgoing_tip_payment.dart';
import 'repository.dart';

part 'bloc.freezed.dart';

@freezed
class OTEvent with _$OTEvent {
  const factory OTEvent.create({
    required CryptoAmount amount,
    required String id,
  }) = OTEventCreate;

  const factory OTEvent.process(String id) = OTEventProcess;

  const factory OTEvent.cancel(String id) = OTEventCancel;
}

typedef OTState = ISet<String>;

typedef _Event = OTEvent;
typedef _State = OTState;
typedef _Emitter = Emitter<_State>;

@injectable
class OTBloc extends Bloc<_Event, _State> {
  OTBloc({
    @factoryParam required Ed25519HDKeyPair account,
    required CryptopleaseClient client,
    required OTRepository repository,
    required TxSender txSender,
    required LinkShortener linkShortener,
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
  final OTRepository _repository;
  final TxSender _txSender;
  final LinkShortener _linkShortener;

  EventHandler<_Event, _State> get _handler => (event, emit) => event.map(
        create: (e) => _onCreate(e, emit),
        process: (e) => _onProcess(e, emit),
        cancel: (e) => _onCancel(e, emit),
      );

  Future<void> _onCreate(OTEventCreate event, _Emitter _) async {
    if (event.amount.token != Token.usdc) {
      throw ArgumentError('Only USDC is supported');
    }

    final status = await _createTx(event.amount);

    final payment = OutgoingTipPayment(
      id: event.id,
      amount: event.amount,
      created: DateTime.now(),
      status: status,
    );

    await _repository.save(payment);

    if (status is OTTxCreated) {
      add(OTEvent.process(payment.id));
    }
  }

  Future<void> _onCancel(OTEventCancel event, _Emitter _) async {
    final payment = await _repository.load(event.id);

    if (payment == null) return;

    final escrow = payment.status.mapOrNull(
      txCreated: (it) => it.escrow,
      txSent: (it) => it.escrow,
      txConfirmed: (it) => it.escrow,
      linkReady: (it) => it.escrow,
      txSendFailure: (it) => it.escrow,
      txWaitFailure: (it) => it.escrow,
      txLinksFailure: (it) => it.escrow,
      cancelTxFailure: (it) => it.escrow,
    );

    if (escrow == null) {
      add(OTEvent.process(payment.id));

      return;
    }

    final status = await _createCancelTx(escrow);

    await _repository.save(payment.copyWith(status: status));

    if (status is OTStatusCancelTxCreated) {
      add(OTEvent.process(payment.id));
    }
  }

  Future<void> _onProcess(
    OTEventProcess event,
    _Emitter emit,
  ) async {
    final payment = await _repository.load(event.id);

    if (payment == null) return;
    if (state.contains(payment.id)) return;

    emit(state.add(payment.id));

    final OTStatus newStatus = await payment.status.map(
      txCreated: (status) => _sendTx(status.tx, escrow: status.escrow),
      txSent: (status) => _waitTx(status.tx, escrow: status.escrow),
      txConfirmed: (status) => _createLink(
        escrow: status.escrow,
        token: payment.amount.token,
      ),
      linkReady: (status) async => status,
      withdrawn: (status) async => status,
      canceled: (status) async => status,
      txFailure: (_) => _createTx(payment.amount),
      txSendFailure: (status) => _sendTx(status.tx, escrow: status.escrow),
      txWaitFailure: (status) => _waitTx(status.tx, escrow: status.escrow),
      txLinksFailure: (status) => _createLink(
        escrow: status.escrow,
        token: payment.amount.token,
      ),
      cancelTxFailure: (status) => _createCancelTx(status.escrow),
      cancelTxCreated: (status) =>
          _sendCancelTx(status.tx, escrow: status.escrow),
      cancelTxSent: (status) => _waitCancelTx(status.tx, escrow: status.escrow),
      cancelTxSendFailure: (status) =>
          _sendCancelTx(status.tx, escrow: status.escrow),
      cancelTxWaitFailure: (status) =>
          _waitCancelTx(status.tx, escrow: status.escrow),
    );

    await _repository.save(payment.copyWith(status: newStatus));

    emit(state.remove(payment.id));

    newStatus.map(
      txCreated: (_) => add(OTEvent.process(payment.id)),
      txSent: (_) => add(OTEvent.process(payment.id)),
      txConfirmed: (_) => add(OTEvent.process(payment.id)),
      linkReady: ignore,
      withdrawn: ignore,
      canceled: ignore,
      txFailure: ignore,
      txSendFailure: ignore,
      txWaitFailure: ignore,
      txLinksFailure: ignore,
      cancelTxFailure: ignore,
      cancelTxSendFailure: ignore,
      cancelTxWaitFailure: ignore,
      cancelTxCreated: (_) => add(OTEvent.process(payment.id)),
      cancelTxSent: (_) => add(OTEvent.process(payment.id)),
    );
  }

  Future<OTStatus> _createTx(Amount amount) async {
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

      return OTStatus.txCreated(tx, escrow: escrowAccount);
    } on Exception {
      return const OTStatus.txFailure();
    }
  }

  Future<OTStatus> _sendTx(
    SignedTx tx, {
    required Ed25519HDKeyPair escrow,
  }) async {
    final result = await _txSender.send(tx);

    return result.map(
      sent: (_) => OTStatus.txSent(tx, escrow: escrow),
      invalidBlockhash: (_) => const OTStatus.txFailure(),
      failure: (it) => OTStatus.txFailure(reason: it.reason),
      networkError: (_) => OTStatus.txSendFailure(tx, escrow: escrow),
    );
  }

  Future<OTStatus> _waitTx(
    SignedTx tx, {
    required Ed25519HDKeyPair escrow,
  }) async {
    final result = await _txSender.wait(tx);

    return result.map(
      success: (_) => OTStatus.txConfirmed(escrow: escrow),
      failure: (_) => const OTStatus.txFailure(),
      networkError: (_) => OTStatus.txWaitFailure(tx, escrow: escrow),
    );
  }

  Future<OTStatus> _createLink({
    required Ed25519HDKeyPair escrow,
    required Token token,
  }) async {
    final privateKey = await escrow.extract().then((value) => value.bytes.lock);
    final key = base58encode(privateKey.toList());

    final rawLink = TipPaymentData(
      key: key,
      token: token.publicKey,
    ).toUri();

    final link = await _linkShortener.shorten(rawLink);
    if (link == null) {
      return OTStatus.txLinksFailure(escrow: escrow);
    }

    return OTStatus.linkReady(
      link: link,
      escrow: escrow,
    );
  }

  Future<OTStatus> _createCancelTx(Ed25519HDKeyPair escrow) async {
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

      return OTStatus.cancelTxCreated(tx, escrow: escrow);
    } on Exception {
      return OTStatus.cancelTxFailure(escrow: escrow);
    }
  }

  Future<OTStatus> _sendCancelTx(
    SignedTx tx, {
    required Ed25519HDKeyPair escrow,
  }) async {
    final result = await _txSender.send(tx);

    return result.map(
      sent: (_) => OTStatus.cancelTxSent(tx, escrow: escrow),
      invalidBlockhash: (_) => OTStatus.cancelTxFailure(escrow: escrow),
      failure: (it) =>
          OTStatus.cancelTxFailure(reason: it.reason, escrow: escrow),
      networkError: (_) => OTStatus.cancelTxSendFailure(tx, escrow: escrow),
    );
  }

  Future<OTStatus> _waitCancelTx(
    SignedTx tx, {
    required Ed25519HDKeyPair escrow,
  }) async {
    final result = await _txSender.wait(tx);

    return result.map(
      success: (_) => OTStatus.canceled(txId: tx.id),
      failure: (_) => OTStatus.cancelTxFailure(escrow: escrow),
      networkError: (_) => OTStatus.cancelTxWaitFailure(tx, escrow: escrow),
    );
  }
}
