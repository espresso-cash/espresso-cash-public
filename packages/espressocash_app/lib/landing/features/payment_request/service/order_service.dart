import 'dart:async';

import 'package:drift/drift.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/amount.dart';
import '../../../../core/currency.dart';
import '../../../data/db_landing.dart';
import '../../../data/extensions.dart';
import '../../../di.dart';
import '../models/request_model.dart';

typedef PaymentOrder = ({
  String id,
  DateTime created,
  PaymentStatus status,
  CryptoAmount fee,
  String txId,
  String? orderId,
  IncomingPaymentRequest request,
});

@Singleton(scope: landingScope)
class IncomingDlnPaymentService implements Disposable {
  IncomingDlnPaymentService(this._db, this._client);

  final LandingDatabase _db;
  final EspressoCashClient _client;

  final Map<String, StreamSubscription<void>> _watchers = {};

  Stream<PaymentOrder> watch(String orderId) {
    final query = _db.select(_db.incomingDlnPaymentRows)
      ..where((tbl) => tbl.id.equals(orderId));

    return query.watchSingle().map((row) {
      final amount = CryptoAmount(
        value: row.requestAmount,
        cryptoCurrency: Currency.usdc,
      );

      final fee = CryptoAmount(
        value: row.feeAmount,
        cryptoCurrency: Currency.usdc,
      );

      final request = IncomingPaymentRequest(
        requestAmount: amount,
        receiverAddress: row.receiverAddress,
        solanaReferenceAddress: row.receiverReference,
        receiverName: row.receiverName,
      );

      return (
        id: row.id,
        created: row.created,
        status: row.status,
        fee: fee,
        txId: row.txId,
        orderId: row.orderId,
        request: request,
      );
    });
  }

  Future<String> create({
    required IncomingPaymentRequest request,
    required UserWalletInfo sender,
    required String txId,
    required CryptoAmount fee,
  }) async {
    final order = IncomingDlnPaymentRow(
      id: const Uuid().v4(),
      created: DateTime.now(),
      senderAddress: sender.address,
      senderBlockchain: sender.blockchain.toDto(),
      receiverAddress: request.receiverAddress,
      receiverReference: request.solanaReferenceAddress,
      receiverName: request.receiverName,
      requestAmount: request.requestAmount.value,
      feeAmount: fee.value,
      status: PaymentStatus.txSent,
      txId: txId,
    );

    await _db.into(_db.incomingDlnPaymentRows).insert(order);
    _watcher(order.id);

    return order.id;
  }

  void _watcher(String orderId) {
    _watchers[orderId] = Stream<void>.periodic(_refreshDuration)
        .startWith(null)
        .asyncMap((_) async {
          final order = await (_db.select(_db.incomingDlnPaymentRows)
                ..where((tbl) => tbl.id.equals(orderId)))
              .getSingle();

          if (order.status != PaymentStatus.txSent) {
            await _watchers.remove(orderId)?.cancel();

            return null;
          }

          return order;
        })
        .whereNotNull()
        .asyncMap(_checkOrderStatus)
        .whereNotNull()
        .listen((event) async {
          // await _watchers.remove(orderId)?.cancel();

          await (_db.update(_db.incomingDlnPaymentRows)
                ..where((tbl) => tbl.id.equals(orderId)))
              .write(event);
        });
  }

  Future<IncomingDlnPaymentRow?> _checkOrderStatus(
    IncomingDlnPaymentRow order,
  ) async {
    String? orderId = order.orderId;
    if (orderId == null || orderId.isEmpty) {
      final txId = order.txId;

      orderId = await _client
          .fetchDlnOrderId(OrderIdDlnRequestDto(txId: txId))
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
        status: PaymentStatus.success,
        orderId: Value(orderId),
      );
    }

    final isStale = DateTime.now().difference(order.created) > _orderExpiration;

    return order.copyWith(
      status: isStale ? PaymentStatus.unfulfilled : PaymentStatus.txSent,
      orderId: Value(orderId),
    );
  }

  @override
  Future<void> onDispose() async {
    await Future.wait(_watchers.values.map((it) => it.cancel()));
  }
}

const _refreshDuration = Duration(seconds: 10);
const _orderExpiration = Duration(minutes: 4);
