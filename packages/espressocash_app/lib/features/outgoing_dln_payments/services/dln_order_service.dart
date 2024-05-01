import 'dart:async';

import 'package:dfunc/dfunc.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:solana/encoder.dart';
import 'package:uuid/uuid.dart';

import '../../accounts/auth_scope.dart';
import '../../accounts/models/ec_wallet.dart';
import '../../currency/models/amount.dart';
import '../../transactions/models/tx_results.dart';
import '../../transactions/services/resign_tx.dart';
import '../../transactions/services/tx_sender.dart';
import '../data/repository.dart';
import '../models/outgoing_payment.dart';
import '../models/payment_quote.dart';

@Singleton(scope: authScope)
class OutgoingDlnPaymentService implements Disposable {
  OutgoingDlnPaymentService(
    this._account,
    this._client,
    this._sender,
    this._repository,
  );

  final Map<String, StreamSubscription<void>> _subscriptions = {};
  final Map<String, StreamSubscription<void>> _watchers = {};

  final ECWallet _account;
  final EspressoCashClient _client;
  final TxSender _sender;
  final OutgoingDlnPaymentRepository _repository;

  @PostConstruct(preResolve: true)
  Future<void> init() async {
    final pendingPayments = await _repository.getAllPending();

    for (final payment in pendingPayments) {
      _subscribe(payment);
    }
  }

  Future<String> create(PaymentQuote quote) async {
    final totalAmount = (quote.payment.inputAmount + quote.fee) as CryptoAmount;

    final status = await _createTx(quote: quote);

    final payment = OutgoingDlnPayment(
      id: const Uuid().v4(),
      created: DateTime.now(),
      payment: quote.payment,
      amount: totalAmount,
      status: status,
    );

    await _repository.save(payment);
    _subscribe(payment.id);

    return payment.id;
  }

  Future<void> cancel(String orderId) async {
    final order = await _repository.load(orderId);

    if (order != null && order.status is OutgoingDlnPaymentStatusTxFailure) {
      await _repository.delete(orderId);
    }
  }

  void _subscribe(String orderId) {
    _subscriptions[orderId] = _repository
        .watch(orderId)
        .whereNotNull()
        .asyncExpand<OutgoingDlnPayment?>((order) {
      switch (order.status) {
        case OutgoingDlnPaymentStatusTxCreated():
          return _send(order).asStream();
        case OutgoingDlnPaymentStatusTxSent():
          return _wait(order).asStream();
        case OutgoingDlnPaymentStatusSuccess():
          _watcher(orderId);
          _subscriptions.remove(orderId)?.cancel();

          return null;
        case OutgoingDlnPaymentStatusTxFailure():
        case OutgoingDlnPaymentStatusFulfilled():
        case OutgoingDlnPaymentStatusUnFulfilled():
          _subscriptions.remove(orderId)?.cancel();

          return null;
      }
    }).listen((payment) => payment?.let(_repository.save));
  }

  void _watcher(String orderId) {
    _watchers[orderId] = Stream<void>.periodic(const Duration(seconds: 10))
        .startWith(null)
        .asyncMap((_) => _repository.load(orderId))
        .whereNotNull()
        .asyncMap(_checkOrderStatus)
        .listen((payment) => payment.let(_repository.save));
  }

  Future<OutgoingDlnPaymentStatus> _createTx({
    required PaymentQuote quote,
  }) async {
    try {
      final tx = await SignedTx.decode(quote.encodedTx).resign(_account);

      return OutgoingDlnPaymentStatus.txCreated(tx, slot: quote.slot);
    } on Exception {
      return const OutgoingDlnPaymentStatus.txFailure(
        reason: TxFailureReason.creatingFailure,
      );
    }
  }

  Future<OutgoingDlnPayment> _send(OutgoingDlnPayment payment) async {
    final status = payment.status;
    if (status is! OutgoingDlnPaymentStatusTxCreated) {
      return payment;
    }

    final tx = await _sender.send(status.tx, minContextSlot: status.slot);
    final OutgoingDlnPaymentStatus? newStatus = tx.map(
      sent: (_) => OutgoingDlnPaymentStatus.txSent(
        status.tx,
        slot: status.slot,
      ),
      invalidBlockhash: (_) => const OutgoingDlnPaymentStatus.txFailure(
        reason: TxFailureReason.invalidBlockhashSending,
      ),
      failure: (it) => OutgoingDlnPaymentStatus.txFailure(reason: it.reason),
      networkError: (_) => null,
    );

    return newStatus == null ? payment : payment.copyWith(status: newStatus);
  }

  Future<OutgoingDlnPayment> _wait(OutgoingDlnPayment payment) async {
    final status = payment.status;
    if (status is! OutgoingDlnPaymentStatusTxSent) {
      return payment;
    }

    final tx = await _sender.wait(
      status.tx,
      minContextSlot: status.slot,
      txType: 'OutgoingDlnPayment',
    );
    final OutgoingDlnPaymentStatus? newStatus = await tx.map(
      success: (_) => OutgoingDlnPaymentStatus.success(
        status.tx,
        orderId: null,
      ),
      failure: (tx) => OutgoingDlnPaymentStatus.txFailure(reason: tx.reason),
      networkError: (_) => null,
    );

    return newStatus == null ? payment : payment.copyWith(status: newStatus);
  }

  Future<OutgoingDlnPayment> _checkOrderStatus(OutgoingDlnPayment order) async {
    final status = order.status;

    if (status is! OutgoingDlnPaymentStatusSuccess) {
      return order;
    }

    String? orderId = status.orderId;
    if (orderId == null || orderId.isEmpty) {
      orderId = await _client
          .fetchDlnOrderId(OrderIdDlnRequestDto(txId: status.tx.id))
          .then((e) => e.orderId);
    }

    if (orderId == null) {
      return order;
    }

    final orderStatus = await _client
        .fetchDlnStatus(OrderStatusDlnRequestDto(orderId: orderId));
    final isFulfilled = orderStatus.status == DlnOrderStatus.fulfilled;

    if (isFulfilled) {
      return order.copyWith(
        status: OutgoingDlnPaymentStatus.fulfilled(
          status.tx,
          orderId: orderId,
        ),
      );
    }

    final isStale = DateTime.now().difference(order.created) > _orderExpiration;

    return isStale
        ? order.copyWith(
            status: OutgoingDlnPaymentStatus.unfulfilled(
              status.tx,
              orderId: orderId,
            ),
          )
        : order.copyWith(status: status.copyWith(orderId: orderId));
  }

  @override
  Future<void> onDispose() async {
    await Future.wait(_subscriptions.values.map((it) => it.cancel()));
  }
}

const _orderExpiration = Duration(minutes: 4);
