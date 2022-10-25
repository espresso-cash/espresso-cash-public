import 'package:cryptoplease/core/tokens/token_list.dart';
import 'package:cryptoplease/data/db/db.dart';
import 'package:cryptoplease/features/outgoing_direct_payments/bl/repository.dart';
import 'package:cryptoplease/features/outgoing_split_key_payments/bl/repository.dart';
import 'package:cryptoplease/features/transaction/transaction_activity.dart';
import 'package:drift/drift.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

typedef _L = Iterable<TransactionActivity>;

typedef TABuilder<D> = Future<TransactionActivity> Function(D);

@injectable
class TransactionActivityRepository {
  TransactionActivityRepository(this._db, this._tokens);

  final MyDatabase _db;
  final TokenList _tokens;

  Stream<List<TransactionActivity>> _query<T extends HasResultSet, D>({
    required ResultSetImplementation<T, D> table,
    required GeneratedColumn<String?> txIdColumn,
    required TABuilder<D> builder,
  }) {
    final query = _db.select(_db.transactionRetrievedRows).join([
      leftOuterJoin(
        table as Table,
        txIdColumn.equalsExp(_db.transactionRetrievedRows.id),
      ),
    ]);

    return query
        .watch()
        .map((results) => results.map((e) => builder(e.readTable(table))))
        .asyncMap(Future.wait);
  }

  Stream<IList<TransactionActivity>> readAll() {
    final oprStream = _query<$PaymentRequestRowsTable, PaymentRequestRow>(
      table: _db.paymentRequestRows,
      txIdColumn: _db.paymentRequestRows.transactionId,
      builder: (opr) => Future.value(opr.toActivity()),
    );

    final odpStream = _query<$ODPRowsTable, ODPRow>(
      table: _db.oDPRows,
      txIdColumn: _db.oDPRows.txId,
      builder: (odp) => Future.value(odp.toActivity(_tokens)),
    );

    final oskpStream = _query<$OSKPRowsTable, OSKPRow>(
      table: _db.oSKPRows,
      txIdColumn: _db.oSKPRows.txId,
      builder: (oskp) => oskp.toActivity(_tokens),
    );

    return Rx.combineLatest3<_L, _L, _L, IList<TransactionActivity>>(
      oprStream,
      odpStream,
      oskpStream,
      (a, b, c) => [...a, ...b, ...c]
          .toIList()
          .sortOrdered((a, b) => b.created.compareTo(a.created)),
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

extension on PaymentRequestRow {
  TransactionActivity toActivity() =>
      TransactionActivity.outgoingPaymentRequest(
        id: id,
        created: created,
        payerName: payerName,
      );
}

extension on ODPRow {
  TransactionActivity toActivity(TokenList tokens) =>
      TransactionActivity.outgoingDirectPayment(
        id: id,
        created: created,
        data: toModel(tokens),
      );
}

extension on OSKPRow {
  Future<TransactionActivity> toActivity(TokenList tokens) async =>
      TransactionActivity.outgoingSplitKeyPayment(
        id: id,
        created: created,
        data: await toModel(tokens),
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
