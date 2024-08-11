import 'dart:async';

import 'package:dfunc/dfunc.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/solana.dart';
import 'package:uuid/uuid.dart';

import '../../accounts/auth_scope.dart';
import '../../accounts/models/ec_wallet.dart';
import '../../analytics/analytics_manager.dart';
import '../../balances/services/refresh_balance.dart';
import '../../currency/models/amount.dart';
import '../../payments/create_direct_payment.dart';
import '../../transactions/models/tx_results.dart';
import '../../transactions/services/resign_tx.dart';
import '../../transactions/services/tx_durable_sender.dart';
import '../data/repository.dart';
import '../models/outgoing_direct_payment.dart';

@Singleton(scope: authScope)
class ODPService {
  ODPService(
    this._repository,
    this._txDurableSender,
    this._analyticsManager,
    this._createDirectPayment,
    this._refreshBalance,
  );

  final ODPRepository _repository;
  final TxDurableSender _txDurableSender;
  final AnalyticsManager _analyticsManager;
  final CreateDirectPayment _createDirectPayment;
  final RefreshBalance _refreshBalance;

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
      final directPaymentResult = await _createDirectPayment(
        aReceiver: receiver,
        aSender: account.publicKey,
        aReference: reference,
        amount: amount.value,
        commitment: Commitment.confirmed,
      );
      final tx = await directPaymentResult.transaction.resign(account);

      return ODPStatus.txCreated(tx);
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

    final tx = await _txDurableSender.send(status.tx);

    final ODPStatus? newStatus = tx.map(
      sent: (it) => ODPStatus.txSent(
        status.tx,
        signature: it.signature ?? '',
      ),
      invalidBlockhash: (_) => null,
      failure: (it) =>
          const ODPStatus.txFailure(reason: TxFailureReason.creatingFailure),
      networkError: (_) => null,
    );

    return newStatus == null ? payment : payment.copyWith(status: newStatus);
  }

  Future<OutgoingDirectPayment> _wait(OutgoingDirectPayment payment) async {
    final status = payment.status;
    if (status is! ODPStatusTxSent) {
      return payment;
    }
    final tx = await _txDurableSender.wait(txId: status.signature);

    final ODPStatus? newStatus = tx?.map(
      success: (_) => ODPStatus.success(txId: status.tx.id),
      failure: (tx) => ODPStatus.txFailure(reason: tx.reason),
      networkError: (_) => null,
    );

    if (newStatus is ODPStatusSuccess) {
      _refreshBalance();
      _analyticsManager.directPaymentSent(amount: payment.amount.decimal);
    }

    return newStatus == null ? payment : payment.copyWith(status: newStatus);
  }
}
