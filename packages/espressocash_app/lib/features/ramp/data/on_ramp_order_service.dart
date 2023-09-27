import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

import '../../../core/amount.dart';
import '../../../core/currency.dart';
import '../../../core/tokens/token_list.dart';
import '../../../data/db/db.dart';

typedef OnRampOrder = ({
  String orderId,
  String humanStatus,
  DateTime created,
  CryptoAmount? amount,
  CryptoAmount? receiveAmount,
  bool isCompleted,
});

@injectable
class OnRampOrderService {
  const OnRampOrderService(this._db, this._tokens);

  final MyDatabase _db;
  final TokenList _tokens;

  Future<void> create({
    required String orderId,
    required CryptoAmount amount,
  }) async {
    await _db.into(_db.onRampOrderRows).insert(
          OnRampOrderRow(
            id: const Uuid().v4(),
            partnerOrderId: orderId,
            amount: amount.value,
            token: amount.token.address,
            humanStatus: '',
            machineStatus: '',
            isCompleted: false,
            created: DateTime.now(),
          ),
        );
  }

  Stream<OnRampOrder> watch(String id) {
    final query = _db.select(_db.onRampOrderRows)
      ..where((tbl) => tbl.id.equals(id));

    return query.watchSingle().map(
          (row) => (
            orderId: row.id,
            humanStatus: row.humanStatus,
            created: row.created,
            isCompleted: row.isCompleted,
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
}
