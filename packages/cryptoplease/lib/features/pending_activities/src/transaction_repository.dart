import 'dart:async';

import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/solana.dart';

import '../../../core/tokens/token_list.dart';
import '../../../data/db/db.dart';
import 'activity.dart';
import 'activity_builder.dart';
import 'bl/transaction_fetched.dart';
import 'transaction.dart';

@injectable
class TransactionRepository {
  TransactionRepository(this._db, this._tokens);

  final MyDatabase _db;
  final TokenList _tokens;

  Future<Transaction> match(TransactionFetched fetched) =>
      _matchActivity(fetched.id).letAsync(
        (activity) => activity != null
            ? Transaction.activity(activity)
            : Transaction.common(fetched),
      );

  Future<Activity?> _matchActivity(TransactionId txId) async {
    final pr = await _db.paymentRequestRows.findActivityOrNull(
      (row) => row.transactionId.equals(txId),
      (pr) => pr.toActivity(),
    );
    if (pr != null) return pr;

    final odp = await _db.oDPRows.findActivityOrNull(
      (row) => row.txId.equals(txId),
      (pr) => pr.toActivity(_tokens),
    );
    if (odp != null) return odp;

    final oskp = await _db.oSKPRows.findActivityOrNull(
      (row) => row.txId.equals(txId),
      (pr) => pr.toActivity(_tokens),
    );
    if (oskp != null) return oskp;

    return null;
  }
}

extension Q<T extends HasResultSet, D> on ResultSetImplementation<T, D> {
  Future<Activity?> findActivityOrNull(
    Expression<bool?> Function(T tbl) where,
    FutureOr<Activity> Function(D) builder,
  ) async {
    final query = select()
      ..where(where)
      ..limit(1);
    final result = await query.getSingleOrNull();

    return result?.let(builder);
  }
}
