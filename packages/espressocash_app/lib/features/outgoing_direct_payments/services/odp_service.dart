import 'dart:async';

import 'package:dfunc/dfunc.dart';
import 'package:espressocash_api/espressocash_api.dart';

import 'package:injectable/injectable.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';
import 'package:uuid/uuid.dart';

import '../../../config.dart';
import '../../accounts/models/ec_wallet.dart';
import '../../authenticated/auth_scope.dart';
import '../../currency/models/amount.dart';
import '../../transactions/models/tx_results.dart';
import '../../transactions/services/resign_tx.dart';
import '../../transactions/services/tx_sender.dart';
import '../data/repository.dart';
import '../models/outgoing_direct_payment.dart';

@Singleton(scope: authScope)
class ODPService {
  ODPService(this._client, this._repository, this._txSender);

  final EspressoCashClient _client;
  final ODPRepository _repository;
  final TxSender _txSender;

  final Map<String, StreamSubscription<void>> _subscriptions = {};

  @PostConstruct(preResolve: true)
  Future<void> init() async {
    final nonCompletedPayments = await _repository.getNonCompletedPaymentIds();

    for (final payment in nonCompletedPayments) {
      _subscribe(payment);
    }
  }

  Future<OutgoingDirectPayment> create({
    required ECWallet account,
    required CryptoAmount amount,
    required Ed25519HDPublicKey receiver,
    required Ed25519HDPublicKey? reference,
  }) async {
    final id = const Uuid().v4();

    final status = await _createTx(
      account: account,
      receiver: receiver,
      amount: amount,
      reference: reference,
    );

    final payment = OutgoingDirectPayment(
      id: id,
      receiver: receiver,
      reference: reference,
      amount: amount,
      created: DateTime.now(),
      status: status,
    );

    await _repository.save(payment);
    _subscribe(id);

    return payment;
  }

  Future<void> retry(
    String paymentId, {
    required ECWallet account,
  }) async {
    final payment = await _repository.load(paymentId);
    if (payment == null || !payment.isRetriable) return;

    final status = await _createTx(
      account: account,
      receiver: payment.receiver,
      amount: payment.amount,
      reference: payment.reference,
    );

    final newPayment = payment.copyWith(status: status);

    await _repository.save(newPayment);
    _subscribe(newPayment.id);
  }

  Future<void> cancel(String paymentId) async {
    final payment = await _repository.load(paymentId);
    if (payment == null || !payment.isRetriable) return;

    await _repository.delete(paymentId);
  }

  Future<ODPStatus> _createTx({
    required CryptoAmount amount,
    required ECWallet account,
    required Ed25519HDPublicKey receiver,
    required Ed25519HDPublicKey? reference,
  }) async {
    try {
      final dto = CreateDirectPaymentRequestDto(
        senderAccount: account.address,
        receiverAccount: receiver.toBase58(),
        referenceAccount: reference?.toBase58(),
        amount: amount.value,
        cluster: apiCluster,
      );
      final response = await _client.createDirectPayment(dto);
      final tx = await response
          .let((it) => it.transaction)
          .let(SignedTx.decode)
          .let((it) => it.resign(account));

      return ODPStatus.txCreated(tx, slot: response.slot);
    } on Exception {
      return const ODPStatus.txFailure(
        reason: TxFailureReason.creatingFailure,
      );
    }
  }

  void _subscribe(String paymentId) {
    _subscriptions[paymentId] = _repository
        .watch(paymentId)
        .asyncExpand<OutgoingDirectPayment?>((payment) {
      switch (payment.status) {
        case ODPStatusTxCreated():
          return _send(payment).asStream();
        case ODPStatusTxSent():
          return _wait(payment).asStream();
        case ODPStatusSuccess():
        case ODPStatusTxFailure():
          _subscriptions.remove(paymentId)?.cancel();

          return null;
      }
    }).listen((payment) => payment?.let(_repository.save));
  }

  Future<OutgoingDirectPayment> _send(OutgoingDirectPayment payment) async {
    final status = payment.status;
    if (status is! ODPStatusTxCreated) {
      return payment;
    }

    final tx = await _txSender.send(status.tx, minContextSlot: status.slot);

    final ODPStatus? newStatus = tx.map(
      sent: (_) => ODPStatus.txSent(
        status.tx,
        slot: status.slot,
      ),
      invalidBlockhash: (_) => const ODPStatus.txFailure(
        reason: TxFailureReason.invalidBlockhashSending,
      ),
      failure: (it) => ODPStatus.txFailure(reason: it.reason),
      networkError: (_) => null,
    );

    return newStatus == null ? payment : payment.copyWith(status: newStatus);
  }

  Future<OutgoingDirectPayment> _wait(OutgoingDirectPayment payment) async {
    final status = payment.status;
    if (status is! ODPStatusTxSent) {
      return payment;
    }

    final tx = await _txSender.wait(
      status.tx,
      minContextSlot: status.slot,
      txType: 'OutgoingDirectPayment',
    );

    final ODPStatus? newStatus = tx.map(
      success: (_) => ODPStatus.success(txId: status.tx.id),
      failure: (tx) => ODPStatus.txFailure(reason: tx.reason),
      networkError: (_) => null,
    );

    return newStatus == null ? payment : payment.copyWith(status: newStatus);
  }
}
