import 'dart:async';

import 'package:collection/collection.dart';
import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/solana.dart';

import '../../../core/tokens/token_list.dart';
import '../../../data/db/db.dart';
import '../../outgoing_direct_payments/db.dart';
import '../../outgoing_split_key_payments/db.dart';
import '../../outgoing_tip_payments/db.dart';
import '../../payment_request/db.dart';
import '../../swap/db.dart';
import '../models/transaction.dart';
import 'activity.dart';
import 'activity_builder.dart';
import 'updater/tx_updater_repository.dart';

@injectable
class TransactionRepository {
  TransactionRepository(this._db, this._tokens);

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

    return query.watchSingle().asyncMap((row) => _match(row.toModel()));
  }

  Future<Transaction> _match(TxCommon fetched) =>
      _matchActivity(fetched.tx.id).letAsync(
        (activity) =>
            activity != null ? Transaction.activity(activity) : fetched,
      );

  Future<Activity?> _matchActivity(TransactionId txId) async {
    final pr = await _db.paymentRequestRows.findActivityOrNull(
      where: (row) => row.transactionId.equals(txId),
      builder: (pr) => pr.toActivity(),
      ignoreWhen: (row) => row.state != PaymentRequestStateDto.completed,
    );
    if (pr != null) return pr;

    final odp = await _db.oDPRows.findActivityOrNull(
      where: (row) => row.txId.equals(txId),
      builder: (pr) => pr.toActivity(_tokens),
      ignoreWhen: (row) => row.status != ODPStatusDto.success,
    );
    if (odp != null) return odp;

    final swap = await _db.swapRows.findActivityOrNull(
      where: (row) => row.txId.equals(txId),
      builder: (swap) => swap.toActivity(_tokens),
      ignoreWhen: (row) => row.status != SwapStatusDto.success,
    );
    if (swap != null) return swap;

    final ot = await _db.oTRows.findActivityOrNull(
      where: (row) => row.txId.equals(txId),
      builder: (pr) => pr.toActivity(_tokens),
      ignoreWhen: (row) => const [
        OTStatusDto.success, // Legacy
        OTStatusDto.withdrawn,
        OTStatusDto.canceled
      ].contains(row.status).not(),
    );
    if (ot != null) return ot;

    final oskp = await _db.oSKPRows.findActivityOrNull(
      where: (row) => row.txId.equals(txId),
      builder: (pr) => pr.toActivity(_tokens),
      ignoreWhen: (row) => const [
        OSKPStatusDto.success,
        OSKPStatusDto.withdrawn,
        OSKPStatusDto.canceled
      ].contains(row.status).not(),
    );
    if (oskp != null) return oskp;

    return null;
  }
}

extension Q<Tbl extends HasResultSet, D> on ResultSetImplementation<Tbl, D> {
  Future<Activity?> findActivityOrNull({
    required Expression<bool> Function(Tbl tbl) where,
    required FutureOr<Activity> Function(D) builder,
    bool Function(D) ignoreWhen = T,
  }) async {
    final query = select()
      ..where(where)
      ..limit(1);
    final result = await query.getSingleOrNull();

    if (result != null && ignoreWhen(result)) throw const _Ignore();

    return result?.let(builder);
  }
}

class _Ignore implements Exception {
  const _Ignore();
}

extension on bool {
  bool not() => !this;
}
