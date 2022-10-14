import 'package:cryptoplease/data/db/db.dart';
import 'package:cryptoplease/features/outgoing_direct_payments/data/repository.dart';
import 'package:cryptoplease/features/outgoing_split_key_payments/data/repository.dart';
import 'package:cryptoplease/features/pending_activities/pending_activity.dart';
import 'package:drift/drift.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:rxdart/rxdart.dart';

typedef _L = Iterable<PendingActivity>;

class PendingActivitiesRepository {
  PendingActivitiesRepository(this._db);

  final MyDatabase _db;

  Stream<IList<PendingActivity>> watchAll() {
    final opr = _db.select(_db.paymentRequestRows)
      ..where(
        (tbl) => tbl.state.equalsValue(PaymentRequestStateDto.completed).not(),
      );
    final odp = _db.select(_db.oDPRows)
      ..where((tbl) => tbl.status.equalsValue(ODPStatusDto.success).not());
    final oskp = _db.select(_db.oSKPRows)
      ..where((tbl) => tbl.status.equalsValue(OSKPStatusDto.success).not());

    final oprStream = opr.watch().map((rows) => rows.map((r) => r.toModel()));
    final odpStream = odp.watch().map((rows) => rows.map((r) => r.toModel()));
    final oskpStream = oskp.watch().map((rows) => rows.map((r) => r.toModel()));

    return Rx.zip3<_L, _L, _L, IList<PendingActivity>>(
      oprStream,
      odpStream,
      oskpStream,
      (a, b, c) => [...a, ...b, ...c]
          .toIList()
          .sortOrdered((a, b) => b.created.compareTo(a.created)),
    );
  }
}

extension on PaymentRequestRow {
  PendingActivity toModel() => PendingActivity.outgoingPaymentRequest(
        id: id,
        created: created,
      );
}

extension on ODPRow {
  PendingActivity toModel() => PendingActivity.outgoingDirectPayment(
        id: id,
        created: created,
      );
}

extension on OSKPRow {
  PendingActivity toModel() => PendingActivity.outgoingSplitKeyPayment(
        id: id,
        created: created,
      );
}
