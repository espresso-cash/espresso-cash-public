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
import '../../../../core/split_key_payments.dart';
import '../../../../core/tokens/token.dart';
import '../../../../core/transactions/resign_tx.dart';
import '../../../../core/transactions/tx_sender.dart';
import '../../../cancel_outgoing_payment/cancel_tx_sender.dart';
import '../../models/outgoing_split_key_payment.dart';
import 'repository.dart';

part 'bloc.freezed.dart';

@freezed
class OSKPEvent with _$OSKPEvent {
  const factory OSKPEvent.create({
    required CryptoAmount amount,
    required String id,
  }) = OSKPEventCreate;

  const factory OSKPEvent.process(String id) = OSKPEventProcess;

  const factory OSKPEvent.cancel(String id) = OSKPEventCancel;
}

typedef OSKPState = ISet<String>;

typedef _Event = OSKPEvent;
typedef _State = OSKPState;
typedef _Emitter = Emitter<_State>;

@injectable
class OSKPBloc extends Bloc<_Event, _State> {
  OSKPBloc({
    @factoryParam required Ed25519HDKeyPair account,
    required CryptopleaseClient client,
    required OSKPRepository repository,
    required TxSender txSender,
    required LinkShortener linkShortener,
    required CancelTxSender cancelTxSender,
  })  : _account = account,
        _client = client,
        _repository = repository,
        _txSender = txSender,
        _cancelTxSender = cancelTxSender,
        _linkShortener = linkShortener,
        super(const ISetConst({})) {
    on<_Event>(_handler);
  }

  final Ed25519HDKeyPair _account;
  final CryptopleaseClient _client;
  final OSKPRepository _repository;
  final TxSender _txSender;
  final LinkShortener _linkShortener;
  final CancelTxSender _cancelTxSender;

  EventHandler<_Event, _State> get _handler => (event, emit) => event.map(
        create: (e) => _onCreate(e, emit),
        process: (e) => _onProcess(e, emit),
        cancel: (e) => _onCancel(e, emit),
      );

  Future<void> _onCreate(OSKPEventCreate event, _Emitter _) async {
    if (event.amount.token != Token.usdc) {
      throw ArgumentError('Only USDC is supported');
    }

    final status = await _createTx(event.amount);

    final payment = OutgoingSplitKeyPayment(
      id: event.id,
      amount: event.amount,
      created: DateTime.now(),
      status: status,
    );

    await _repository.save(payment);

    if (status is OSKPStatusTxCreated) {
      add(OSKPEvent.process(payment.id));
    }
  }

  Future<void> _onCancel(OSKPEventCancel event, _Emitter _) async {
    final payment = await _repository.load(event.id);

    if (payment == null) return;

    final escrow = payment.status.mapOrNull(
      txCreated: (it) => it.escrow,
      txSent: (it) => it.escrow,
      txConfirmed: (it) => it.escrow,
      linksReady: (it) => it.escrow,
      txSendFailure: (it) => it.escrow,
      txWaitFailure: (it) => it.escrow,
      txLinksFailure: (it) => it.escrow,
      cancel: (it) => it.cancelStatus.maybeMap(
        orElse: () => it.escrow,
        success: null,
      ),
    );

    if (escrow == null) return;

    final status = await _cancelTxSender
        .processCancelEscrow(wallet: _account.publicKey, escrow: escrow)
        .letAsync((it) => OSKPStatus.cancel(it, escrow: escrow));

    await _repository.save(payment.copyWith(status: status));

    if (status is OSKPStatusCancel) {
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
      txSent: (status) => _waitTx(status.tx, escrow: status.escrow),
      txConfirmed: (status) => _createLinks(
        escrow: status.escrow,
        token: payment.amount.token,
      ),
      linksReady: (status) async => status,
      withdrawn: (status) async => status,
      txFailure: (_) => _createTx(payment.amount),
      txSendFailure: (status) => _sendTx(status.tx, escrow: status.escrow),
      txWaitFailure: (status) => _waitTx(status.tx, escrow: status.escrow),
      txLinksFailure: (status) => _createLinks(
        escrow: status.escrow,
        token: payment.amount.token,
      ),
      cancel: (status) async => _cancelTx(status),
    );

    await _repository.save(payment.copyWith(status: newStatus));

    emit(state.remove(payment.id));

    newStatus.map(
      txCreated: (_) => add(OSKPEvent.process(payment.id)),
      txSent: (_) => add(OSKPEvent.process(payment.id)),
      txConfirmed: (_) => add(OSKPEvent.process(payment.id)),
      linksReady: ignore,
      withdrawn: ignore,
      txFailure: ignore,
      txSendFailure: ignore,
      txWaitFailure: ignore,
      txLinksFailure: ignore,
      cancel: (it) => it.cancelStatus.maybeMap(
        orElse: ignore,
        txCreated: (_) => add(OSKPEvent.process(payment.id)),
        txSent: (_) => add(OSKPEvent.process(payment.id)),
      ),
    );
  }

  Future<OSKPStatus> _cancelTx(OSKPStatusCancel status) async {
    try {
      final cancelStatus = await _cancelTxSender.processCancelEscrow(
        wallet: _account.publicKey,
        escrow: status.escrow,
        status: status.cancelStatus,
      );

      return OSKPStatus.cancel(cancelStatus, escrow: status.escrow);
    } on Exception {
      return const OSKPStatus.txFailure();
    }
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
      sent: (_) => OSKPStatus.txSent(tx, escrow: escrow),
      invalidBlockhash: (_) => const OSKPStatus.txFailure(),
      failure: (it) => OSKPStatus.txFailure(reason: it.reason),
      networkError: (_) => OSKPStatus.txSendFailure(tx, escrow: escrow),
    );
  }

  Future<OSKPStatus> _waitTx(
    SignedTx tx, {
    required Ed25519HDKeyPair escrow,
  }) async {
    final result = await _txSender.wait(tx);

    return result.map(
      success: (_) => OSKPStatus.txConfirmed(escrow: escrow),
      failure: (_) => const OSKPStatus.txFailure(),
      networkError: (_) => OSKPStatus.txWaitFailure(tx, escrow: escrow),
    );
  }

  Future<OSKPStatus> _createLinks({
    required Ed25519HDKeyPair escrow,
    required Token token,
  }) async {
    final privateKey = await escrow.extract().then((value) => value.bytes.lock);
    final keyParts = _splitKey(privateKey);

    final rawFirstLink = SplitKeyFirstLink(
      key: keyParts.first,
      token: token.publicKey,
    ).toUri();

    final firstLink = await _linkShortener.shorten(rawFirstLink);
    if (firstLink == null) {
      return OSKPStatus.txLinksFailure(escrow: escrow);
    }

    final secondLink = SplitKeySecondLink(key: keyParts.last).toUri();

    return OSKPStatus.linksReady(
      link1: firstLink,
      link2: secondLink,
      escrow: escrow,
    );
  }
}

List<String> _splitKey(IList<int> privateKey) {
  final parts = privateKey.splitAt(privateKey.length ~/ 2);

  return [
    base58encode(parts.first.toList()),
    base58encode(parts.second.toList()),
  ];
}
