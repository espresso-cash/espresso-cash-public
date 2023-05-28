import 'dart:async';

import 'package:collection/collection.dart';
import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:solana/solana.dart';

import '../../../core/tokens/token_list.dart';
import '../../../data/db/db.dart';
import '../../outgoing_direct_payments/db.dart';
import '../../outgoing_split_key_payments/db.dart';
import '../../payment_request/db.dart';
import '../../swap/db.dart';
import '../models/transaction.dart';
import 'activity.dart';
import 'activity_builder.dart';
import 'updater/tx_updater_repository.dart';

@injectable
class TransactionRepository {
  const TransactionRepository(this._db, this._tokens);

  final MyDatabase _db;
  final TokenList _tokens;

  Stream<IList<String>> watchAll() {
    final query = _db.select(_db.transactionRows)
      ..orderBy([(t) => OrderingTerm.desc(t.created)]);

    return query
        .map((row) => row.id)
        .watch()
        .map((event) => event.whereNotNull().toIList());
  }

  Stream<Transaction> watch(String id) {
    final query = _db.select(_db.transactionRows)
      ..where((tbl) => tbl.id.equals(id));

    return query.watchSingle().asyncExpand((row) => _match(row.toModel()));
  }

  Stream<Transaction> _match(TxCommon fetched) => _matchActivity(fetched.tx.id)
      .map(Transaction.activity)
      .onErrorReturn(fetched);

  Stream<Activity> _matchActivity(TransactionId txId) {
    final pr = _db.paymentRequestRows.findActivityOrNull(
      where: (row) => row.transactionId.equals(txId),
      builder: (pr) => pr.toActivity(),
      ignoreWhen: (row) => row.state != PaymentRequestStateDto.completed,
    );

    final odp = _db.oDPRows.findActivityOrNull(
      where: (row) => row.txId.equals(txId),
      builder: (pr) => pr.toActivity(_tokens),
      ignoreWhen: (row) => row.status != ODPStatusDto.success,
    );

    final swap = _db.swapRows.findActivityOrNull(
      where: (row) => row.txId.equals(txId),
      builder: (swap) => swap.toActivity(_tokens),
      ignoreWhen: (row) => row.status != SwapStatusDto.success,
    );

    final oskp = _db.oSKPRows.findActivityOrNull(
      where: (row) => row.txId.equals(txId),
      builder: (pr) => pr.toActivity(_tokens),
      ignoreWhen: (row) => const [
        OSKPStatusDto.success,
        OSKPStatusDto.withdrawn,
        OSKPStatusDto.canceled
      ].contains(row.status).not(),
    );

    return Rx.combineLatest(
      [pr, odp, swap, oskp].map((it) => it.onErrorReturn(null)),
      (values) => values.whereNotNull().first,
    );
  }
}

extension Q<Tbl extends HasResultSet, D> on ResultSetImplementation<Tbl, D> {
  Stream<Activity?> findActivityOrNull({
    required Expression<bool> Function(Tbl tbl) where,
    required FutureOr<Activity> Function(D data) builder,
    bool Function(D data) ignoreWhen = T,
  }) {
    final query = select()
      ..where(where)
      ..limit(1);

    return query
        .watchSingle()
        .map((it) => ignoreWhen(it) ? throw const _Ignore() : it)
        .asyncMap((it) => it.let(builder))
        .handleError(ignore, test: (e) => e is _Ignore);
  }
}

class _Ignore implements Exception {
  const _Ignore();
}

extension on bool {
  bool not() => !this;
}
