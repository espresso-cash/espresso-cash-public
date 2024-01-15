import 'dart:async';

import 'package:collection/collection.dart';
import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:solana/encoder.dart';

import '../../../data/db/db.dart';
import '../../outgoing_direct_payments/data/repository.dart';
import '../../outgoing_dln_payments/data/repository.dart';
import '../../outgoing_link_payments/data/repository.dart';
import '../../payment_request/data/repository.dart';
import '../../swap/data/swap_repository.dart';
import '../../tokens/token_list.dart';
import '../models/activity.dart';
import '../models/transaction.dart';
import 'activity_builder.dart';
import 'tx_updater_repository.dart';

@injectable
class TransactionRepository {
  const TransactionRepository(this._db, this._tokens);

  final MyDatabase _db;
  final TokenList _tokens;

  Stream<IList<String>> watchAll() {
    final query = _db.select(_db.transactionRows)
      ..orderBy([(t) => OrderingTerm.desc(t.created)]);

    return query.map((row) => row.id).watch().map((event) => event.toIList());
  }

  Stream<IList<String>> watchCount(int count) {
    final query = _db.select(_db.transactionRows)
      ..limit(count)
      ..orderBy([(t) => OrderingTerm.desc(t.created)]);

    return query.map((row) => row.id).watch().map((event) => event.toIList());
  }

  Stream<Transaction> watch(String id) {
    final query = _db.select(_db.transactionRows)
      ..where((tbl) => tbl.id.equals(id));

    return query.watchSingle().asyncExpand((row) => _match(row.toModel()));
  }

  Stream<Transaction> _match(TxCommon fetched) => _matchActivity(fetched.tx)
      .map(Transaction.activity)
      .onErrorReturn(fetched);

  Stream<Activity> _matchActivity(SignedTx tx) {
    final txId = tx.id;

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

    final olp = _db.oLPRows.findActivityOrNull(
      where: (row) => row.txId.equals(txId),
      builder: (pr) => pr.toActivity(_tokens),
      ignoreWhen: (row) => const [OLPStatusDto.withdrawn, OLPStatusDto.canceled]
          .contains(row.status)
          .not(),
    );

    final onRamp = _db.onRampOrderRows.findActivityOrNull(
      where: (row) => row.txHash.equals(txId),
      builder: (pr) => Activity.onRamp(id: pr.id, created: pr.created),
      ignoreWhen: (row) => row.status != OnRampOrderStatus.completed,
    );

    final offRamp = _db.offRampOrderRows.findActivityOrNull(
      where: (row) => row.transaction.equals(tx.encode()),
      builder: (pr) => Activity.offRamp(id: pr.id, created: pr.created),
      ignoreWhen: (row) => const [
        OffRampOrderStatus.completed,
        OffRampOrderStatus.cancelled,
        OffRampOrderStatus.failure,
      ].contains(row.status).not(),
    );

    final oDlnP = _db.outgoingDlnPaymentRows.findActivityOrNull(
      where: (row) => row.txId.equals(txId),
      builder: (pr) => pr.toActivity(),
      ignoreWhen: (row) => const [
        ODLNPaymentStatusDto.fulfilled,
      ].contains(row.status).not(),
    );

    return Rx.combineLatest(
      [pr, odp, swap, olp, offRamp, onRamp, oDlnP]
          .map((it) => it.onErrorReturn(null)),
      (values) => values.whereNotNull().first,
    );
  }
}

extension Q<Tbl extends HasResultSet, D> on ResultSetImplementation<Tbl, D> {
  Stream<Activity?> findActivityOrNull({
    required Func1<Tbl, Expression<bool>> where,
    required Func1<D, FutureOr<Activity>> builder,
    Func1<D, bool> ignoreWhen = T,
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

// ignore: prefer-public-exception-classes, intentionally private
class _Ignore implements Exception {
  const _Ignore();
}

extension on bool {
  bool not() => !this;
}
