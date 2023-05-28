import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../core/tokens/token_list.dart';
import '../../../data/db/db.dart';
import '../../outgoing_direct_payments/db.dart';
import '../../outgoing_split_key_payments/db.dart';
import '../../payment_request/db.dart';
import '../../swap/db.dart';
import 'activity.dart';
import 'activity_builder.dart';

@injectable
class PendingActivitiesRepository {
  const PendingActivitiesRepository(this._db, this._tokens);

  final MyDatabase _db;
  final TokenList _tokens;

  Stream<IList<Activity>> watchAll() {
    final opr = _db.select(_db.paymentRequestRows)
      ..where(
        (tbl) => tbl.state.equalsValue(PaymentRequestStateDto.completed).not(),
      );
    final odp = _db.select(_db.oDPRows)
      ..where((tbl) => tbl.status.equalsValue(ODPStatusDto.success).not());
    final oskp = _db.select(_db.oSKPRows)
      ..where((tbl) => tbl.status.equalsValue(OSKPStatusDto.withdrawn).not())
      ..where((tbl) => tbl.status.equalsValue(OSKPStatusDto.canceled).not());
    final swap = _db.select(_db.swapRows)
      ..where((tbl) => tbl.status.equalsValue(SwapStatusDto.success).not());

    final oprStream =
        opr.watch().map((rows) => rows.map((r) => r.toActivity()));
    final odpStream =
        odp.watch().map((rows) => rows.map((r) => r.toActivity(_tokens)));
    final oskpStream = oskp
        .watch()
        .map((rows) => rows.map((r) => r.toActivity(_tokens)))
        .asyncMap(Future.wait);
    final swapStream =
        swap.watch().map((rows) => rows.map((r) => r.toActivity(_tokens)));

    return Rx.combineLatest<Iterable<Activity>, IList<Activity>>(
      [
        oprStream,
        odpStream,
        oskpStream,
        swapStream,
      ],
      (values) => values
          .expand(identity)
          .toIList()
          .sortOrdered((a, b) => b.created.compareTo(a.created)),
    );
  }
}
