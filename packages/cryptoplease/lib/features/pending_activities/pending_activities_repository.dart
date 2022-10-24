import 'package:cryptoplease/core/tokens/token_list.dart';
import 'package:cryptoplease/data/db/db.dart';
import 'package:cryptoplease/features/outgoing_direct_payments/bl/repository.dart';
import 'package:cryptoplease/features/outgoing_split_key_payments/bl/repository.dart';
import 'package:cryptoplease/features/payment_request/bl/repository.dart';
import 'package:cryptoplease/features/pending_activities/pending_activity.dart';
import 'package:drift/drift.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

typedef _L = Iterable<PendingActivity>;

@injectable
class PendingActivitiesRepository {
  PendingActivitiesRepository(this._db, this._tokens);

  final MyDatabase _db;
  final TokenList _tokens;

  Stream<IList<PendingActivity>> watchAll() {
    final opr = _db.select(_db.paymentRequestRows)
      ..where(
        (tbl) => tbl.state.equalsValue(PaymentRequestStateDto.completed).not(),
      );
    final odp = _db.select(_db.oDPRows)
      ..where((tbl) => tbl.status.equalsValue(ODPStatusDto.success).not());
    final oskp = _db.select(_db.oSKPRows)
      ..where((tbl) => tbl.status.equalsValue(OSKPStatusDto.success).not());

    final oprStream =
        opr.watch().map((rows) => rows.map((r) => r.toPendingActivity()));
    final odpStream = odp
        .watch()
        .map((rows) => rows.map((r) => r.toPendingActivity(_tokens)));
    final oskpStream = oskp
        .watch()
        .map((rows) => rows.map((r) => r.toPendingActivity(_tokens)))
        .asyncMap(Future.wait);

    return Rx.combineLatest3<_L, _L, _L, IList<PendingActivity>>(
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
  PendingActivity toPendingActivity() => PendingActivity.outgoingPaymentRequest(
        id: id,
        created: created,
      );
}

extension on ODPRow {
  PendingActivity toPendingActivity(TokenList tokens) =>
      PendingActivity.outgoingDirectPayment(
        id: id,
        created: created,
        data: toModel(tokens),
      );
}

extension on OSKPRow {
  Future<PendingActivity> toPendingActivity(TokenList tokens) async =>
      PendingActivity.outgoingSplitKeyPayment(
        id: id,
        created: created,
        data: await toModel(tokens),
      );
}
