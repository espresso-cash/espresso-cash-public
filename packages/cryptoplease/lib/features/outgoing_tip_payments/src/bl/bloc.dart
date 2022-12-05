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
import '../../../../core/split_key_payments.dart';
import '../../../../core/tokens/token.dart';
import '../../../../core/transactions/resign_tx.dart';
import '../../../../core/transactions/tx_sender.dart';
import 'link_shortener.dart';
import 'outgoing_tip_payment.dart';
import 'repository.dart';

part 'bloc.freezed.dart';

@freezed
class OutgoingTipPaymentEvent with _$OutgoingTipPaymentEvent {
  const factory OutgoingTipPaymentEvent.create({
    required CryptoAmount amount,
    required String id,
  }) = OutgoingTipPaymentEventCreate;

  const factory OutgoingTipPaymentEvent.process(String id) =
      OutgoingTipPaymentEventProcess;
}

typedef OutgoingTipPaymentState = ISet<String>;

typedef _Event = OutgoingTipPaymentEvent;
typedef _State = OutgoingTipPaymentState;
typedef _Emitter = Emitter<_State>;

@injectable
class OutgoingTipPaymentBloc extends Bloc<_Event, _State> {
  OutgoingTipPaymentBloc({
    @factoryParam required Ed25519HDKeyPair account,
    required CryptopleaseClient client,
    required OutgoingTipRepository repository,
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
  final OutgoingTipRepository _repository;
  final TxSender _txSender;
  final LinkShortener _linkShortener;

  EventHandler<_Event, _State> get _handler => (event, emit) => event.map(
        create: (e) => _onCreate(e, emit),
        process: (e) => _onProcess(e, emit),
      );

  Future<void> _onCreate(
    OutgoingTipPaymentEventCreate event,
    _Emitter _,
  ) async {
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

    if (status is OutgoingTipTxCreated) {
      add(OutgoingTipPaymentEvent.process(payment.id));
    }
  }

  Future<void> _onProcess(
    OutgoingTipPaymentEventProcess event,
    _Emitter emit,
  ) async {
    final payment = await _repository.load(event.id);

    if (payment == null) return;
    if (state.contains(payment.id)) return;

    emit(state.add(payment.id));

    final OutgoingTipStatus newStatus = await payment.status.map(
      txCreated: (status) => _sendTx(status.tx, escrow: status.escrow),
      txSent: (status) => _waitTx(status.tx, escrow: status.escrow),
      txConfirmed: (status) => _createLink(
        escrow: status.escrow,
        token: payment.amount.token,
      ),
      linkReady: (status) async => status,
      success: (status) async => status,
      txFailure: (_) => _createTx(payment.amount),
      txSendFailure: (status) => _sendTx(status.tx, escrow: status.escrow),
      txWaitFailure: (status) => _waitTx(status.tx, escrow: status.escrow),
      txLinksFailure: (status) => _createLink(
        escrow: status.escrow,
        token: payment.amount.token,
      ),
    );

    await _repository.save(payment.copyWith(status: newStatus));

    emit(state.remove(payment.id));

    newStatus.map(
      txCreated: (_) => add(OutgoingTipPaymentEvent.process(payment.id)),
      txSent: (_) => add(OutgoingTipPaymentEvent.process(payment.id)),
      txConfirmed: (_) => add(OutgoingTipPaymentEvent.process(payment.id)),
      linkReady: ignore,
      success: ignore,
      txFailure: ignore,
      txSendFailure: ignore,
      txWaitFailure: ignore,
      txLinksFailure: ignore,
    );
  }

  Future<OutgoingTipStatus> _createTx(Amount amount) async {
    try {
      final escrowAccount = await Ed25519HDKeyPair.random();

      final dto = CreatePaymentRequestDto(
        senderAccount: _account.address,
        escrowAccount: escrowAccount.address,
        amount: amount.value,
        cluster: apiCluster,
      );

      final tx = await _client
          .createPayment(dto) //TODO
          .then((it) => it.transaction)
          .then(SignedTx.decode)
          .then((it) => it.resign(_account));

      return OutgoingTipStatus.txCreated(tx, escrow: escrowAccount);
    } on Exception {
      return const OutgoingTipStatus.txFailure();
    }
  }

  Future<OutgoingTipStatus> _sendTx(
    SignedTx tx, {
    required Ed25519HDKeyPair escrow,
  }) async {
    final result = await _txSender.send(tx);

    return result.map(
      sent: (_) => OutgoingTipStatus.txSent(tx, escrow: escrow),
      invalidBlockhash: (_) => const OutgoingTipStatus.txFailure(),
      failure: (it) => OutgoingTipStatus.txFailure(reason: it.reason),
      networkError: (_) => OutgoingTipStatus.txSendFailure(tx, escrow: escrow),
    );
  }

  Future<OutgoingTipStatus> _waitTx(
    SignedTx tx, {
    required Ed25519HDKeyPair escrow,
  }) async {
    final result = await _txSender.wait(tx);

    return result.map(
      success: (_) => OutgoingTipStatus.txConfirmed(escrow: escrow),
      failure: (_) => const OutgoingTipStatus.txFailure(),
      networkError: (_) => OutgoingTipStatus.txWaitFailure(tx, escrow: escrow),
    );
  }

  Future<OutgoingTipStatus> _createLink({
    required Ed25519HDKeyPair escrow,
    required Token token,
  }) async {
    final privateKey = await escrow.extract().then((value) => value.bytes.lock);
    final key = base58encode(privateKey.toList());

    final rawFirstLink = SplitKeyFirstLink(
      //TODO
      key: key,
      token: token.publicKey,
    ).toUri();

    final link = await _linkShortener.shorten(rawFirstLink);
    if (link == null) {
      return OutgoingTipStatus.txLinksFailure(escrow: escrow);
    }

    return OutgoingTipStatus.linkReady(
      link: link,
      escrow: escrow,
    );
  }
}

// List<String> _splitKey(IList<int> privateKey) {
//   final parts = privateKey.splitAt(privateKey.length ~/ 2);

//   return [
//     base58encode(parts.first.toList()),
//     base58encode(parts.second.toList()),
//   ];
// }
