import 'dart:async';

import 'package:dfunc/dfunc.dart';
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
});

@Singleton(scope: authScope)
class OnRampOrderService implements Disposable {
  const OnRampOrderService(this._db, this._tokens);

  final MyDatabase _db;
  final TokenList _tokens;

  Future<void> create({
    required String orderId,
    required RampPartner partner,
    CryptoAmount? amount,
    CryptoAmount? receiveAmount,
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
            status: OnRampOrderStatus.waitingForPartner,
          ),
        );
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

  @override
  Future<void> onDispose() => _db.delete(_db.onRampOrderRows).go();
}
