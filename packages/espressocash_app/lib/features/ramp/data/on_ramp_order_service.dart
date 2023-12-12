import 'dart:async';

import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

import '../../../core/amount.dart';
import '../../../core/currency.dart';
import '../../../core/tokens/token.dart';
import '../../../core/tokens/token_list.dart';
import '../../../data/db/db.dart';
import '../../authenticated/auth_scope.dart';
import '../models/ramp_partner.dart';

typedef OnRampOrder = ({
  String id,
  DateTime created,
  CryptoAmount? amount,
  CryptoAmount? receiveAmount,
  RampPartner partner,
  OnRampOrderStatus status,
  String partnerOrderId,
  String? bankAccount,
  String? bankName,
});

@Singleton(scope: authScope)
class OnRampOrderService implements Disposable {
  OnRampOrderService(this._db, this._tokens);

  final Map<String, StreamSubscription<void>> _subscriptions = {};

  final MyDatabase _db;
  final TokenList _tokens;

  Future<void> create({
    required String orderId,
    required RampPartner partner,
    CryptoAmount? amount,
    CryptoAmount? receiveAmount,
    OnRampOrderStatus status = OnRampOrderStatus.waitingForPartner,
    String? bankAccount,
    String? bankName,
    DateTime? transferExpiryDate,
  }) async {
    await _db.into(_db.onRampOrderRows).insert(
          OnRampOrderRow(
            id: const Uuid().v4(),
            partnerOrderId: orderId,
            amount: amount?.value ?? 0,
            token: Token.usdc.address,
            humanStatus: '',
            machineStatus: '',
            isCompleted: false,
            created: DateTime.now(),
            txHash: '',
            partner: partner,
            receiveAmount: receiveAmount?.value,
            status: status,
            bankAccount: bankAccount,
            bankName: bankName,
            bankTransferExpiry: transferExpiryDate,
          ),
        );
  }

  Future<void> createForManualTransfer({
    required String orderId,
    required RampPartner partner,
    CryptoAmount? amount,
    CryptoAmount? receiveAmount,
    required String bankAccount,
    required String bankName,
    required DateTime transferExpiryDate,
  }) =>
      create(
        orderId: orderId,
        partner: partner,
        amount: amount,
        receiveAmount: receiveAmount,
        bankAccount: bankAccount,
        bankName: bankName,
        transferExpiryDate: transferExpiryDate,
        status: OnRampOrderStatus.waitingForDeposit,
      );

  Future<void> deposit(String orderId) async {
    final query = _db.select(_db.onRampOrderRows)
      ..where((tbl) => tbl.id.equals(orderId));
    final order = await query.getSingle();

    final updateQuery = _db.update(_db.onRampOrderRows)
      ..where((tbl) => tbl.id.equals(orderId));

    switch (order.status) {
      case OnRampOrderStatus.waitingForDeposit:
        await updateQuery.write(
          const OnRampOrderRowsCompanion(
            status: Value(OnRampOrderStatus.waitingForPartner),
          ),
        );
      case OnRampOrderStatus.depositExpired:
      case OnRampOrderStatus.waitingForPartner:
      case OnRampOrderStatus.failure:
      case OnRampOrderStatus.completed:
        break;
    }
  }

  Stream<OnRampOrder> watch(String id) {
    final query = _db.select(_db.onRampOrderRows)
      ..where((tbl) => tbl.id.equals(id));

    return query.watchSingle().map(
          (row) => (
            id: row.id,
            created: row.created,
            amount: CryptoAmount(
              value: row.amount,
              cryptoCurrency: CryptoCurrency(
                token: _tokens.requireTokenByMint(row.token),
              ),
            ),
            receiveAmount: row.receiveAmount?.let(
              (amount) => CryptoAmount(
                value: amount,
                cryptoCurrency: CryptoCurrency(
                  token: _tokens.requireTokenByMint(row.token),
                ),
              ),
            ),
            partner: row.partner,
            status: row.status,
            partnerOrderId: row.partnerOrderId,
            bankAccount: row.bankAccount,
            bankName: row.bankName,
          ),
        );
  }

  Stream<IList<({String id, DateTime created})>> watchPending() {
    final query = _db.select(_db.onRampOrderRows)
      ..where((tbl) => tbl.isCompleted.equals(false));

    return query
        .watch()
        .map((rows) => rows.map((r) => (id: r.id, created: r.created)))
        .map((rows) => rows.toIList());
  }

  void _subscribe(String orderId) {
    //TODO upd
    _subscriptions[orderId] = (_db.select(_db.onRampOrderRows)
          ..where((tbl) => tbl.id.equals(orderId)))
        .watchSingle()
        .asyncExpand<OnRampOrderRowsCompanion>((order) {
      switch (order.status) {
        case OnRampOrderStatus.waitingForDeposit:
          final expiry = order.bankTransferExpiry;
          if (expiry != null && expiry.isAfter(DateTime.now())) {
            return Stream.value(
              const OnRampOrderRowsCompanion(
                status: Value(OnRampOrderStatus.depositExpired),
              ),
            );
          }
        case OnRampOrderStatus.completed:
        case OnRampOrderStatus.depositExpired:
        case OnRampOrderStatus.failure:
        case OnRampOrderStatus.waitingForPartner:
          return const Stream.empty();
      }
    }).listen(
      (event) => (_db.update(_db.onRampOrderRows)
            ..where((tbl) => tbl.id.equals(orderId)))
          .write(event),
    );
  }

  @override
  Future<void> onDispose() async {
    await Future.wait(_subscriptions.values.map((it) => it.cancel()));
    await _db.delete(_db.onRampOrderRows).go();
  }
}
