import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/currency.dart';
import 'package:cryptoplease/core/tokens/token_list.dart';
import 'package:cryptoplease/data/db/db.dart';
import 'package:cryptoplease/features/transaction/transaction_activity.dart';
import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

typedef _L = Iterable<TransactionActivity>;

typedef TABuilder<D> = TransactionActivity Function(D, TransactionRetrievedRow);

@injectable
class TransactionActivityRepository {
  TransactionActivityRepository(this._db, this._tokens);

  final MyDatabase _db;
  final TokenList _tokens;

  Future<List<TransactionActivity>> _query<T extends HasResultSet, D>({
    required ResultSetImplementation<T, D> table,
    required GeneratedColumn<String?> txIdColumn,
    required TABuilder<D> builder,
  }) async {
    final query = _db.select(_db.transactionRetrievedRows).join([
      innerJoin(
        table as Table,
        txIdColumn.equalsExp(_db.transactionRetrievedRows.id),
      ),
    ]);

    return query
        .map(
          (row) => builder(
            row.readTable(table),
            row.readTable(_db.transactionRetrievedRows),
          ),
        )
        .get();
  }

  Future<List<TransactionActivity>> readAll() async {
    final opr = _query<$PaymentRequestRowsTable, PaymentRequestRow>(
      table: _db.paymentRequestRows,
      txIdColumn: _db.paymentRequestRows.transactionId,
      builder: (opr, _) => opr.toActivity(),
    );

    final odp = _query<$ODPRowsTable, ODPRow>(
      table: _db.oDPRows,
      txIdColumn: _db.oDPRows.txId,
      // builder: (p0, p1) => ,
    );

    // final
    // final
    // query.where(todos.content.like(entryFilter));

    // final x = await query.get();

    // final opr = _db.select(_db.paymentRequestRows)
    //   ..where((tbl) => tbl.state.equalsValue(PaymentRequestStateDto.completed));
    // final odp = _db.select(_db.oDPRows)
    //   ..where((tbl) => tbl.status.equalsValue(ODPStatusDto.success));
    // final oskp = _db.select(_db.oSKPRows)
    //   ..where((tbl) => tbl.status.equalsValue(OSKPStatusDto.success));

    // final oprStream =
    //     opr.watch().map((rows) => rows.map((r) => r.toTransactionActivity()));
    // final odpStream = odp
    //     .watch()
    //     .map((rows) => rows.map((r) => r.toTransactionActivity(_tokens)));
    // final oskpStream = oskp
    //     .watch()
    //     .map((rows) => rows.map((r) => r.toTransactionActivity(_tokens)))
    //     .asyncMap(Future.wait);

    // return Rx.combineLatest3<_L, _L, _L, IList<TransactionActivity>>(
    //   oprStream,
    //   odpStream,
    //   oskpStream,
    //   (a, b, c) => [...a, ...b, ...c]
    //       .toIList()
    //       .sortOrdered((a, b) => b.created.compareTo(a.created)),
    // );
  }
}

Amount? _buildAmount(
  String? value,
  String? tokenAddress,
  TokenList tokenList,
) =>
    value?.let(Decimal.parse).let(
          (decimal) => tokenAddress?.let(tokenList.findTokenByMint).let(
                (foundToken) => foundToken?.let(
                  (token) => Amount.fromDecimal(
                    value: decimal,
                    currency: CryptoCurrency(token: token),
                  ),
                ),
              ),
        );

extension on PaymentRequestRow {
  TransactionActivity toActivity() =>
      TransactionActivity.outgoingPaymentRequest(
        id: id,
        created: created,
        payerName: payerName,
      );
}

// final oprQuery = _db.select(_db.transactionRetrievedRows).join([
//       innerJoin(
//         _db.paymentRequestRows,
//         _db.paymentRequestRows.transactionId
//             .equalsExp(_db.transactionRetrievedRows.id),
//       ),
//     ]);
//     final opr = await oprQuery
//         .map(
//           (row) => row
//               .readTable(_db.paymentRequestRows)
//               .toActivity(row.readTable(_db.transactionRetrievedRows)),
//         )
//         .get();
