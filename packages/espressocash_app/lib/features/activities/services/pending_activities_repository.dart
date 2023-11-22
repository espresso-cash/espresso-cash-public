import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../core/tokens/token_list.dart';
import '../../../data/db/db.dart';
import '../../outgoing_direct_payments/data/repository.dart';
import '../../outgoing_link_payments/data/repository.dart';
import '../../payment_request/data/repository.dart';
import '../../ramp/data/on_ramp_order_service.dart';
import '../../ramp/services/kado_off_ramp_order_service.dart';
import '../../swap/data/swap_repository.dart';
import '../data/activity_builder.dart';
import '../models/activity.dart';

@injectable
class PendingActivitiesRepository {
  const PendingActivitiesRepository(
    this._db,
    this._tokens,
    this._onRampOrderService,
    this._offRampOrderService,
  );

  final MyDatabase _db;
  final TokenList _tokens;
  final OnRampOrderService _onRampOrderService;
  final KadoOffRampOrderService _offRampOrderService;

  Stream<IList<Activity>> watchAll() {
    final opr = _db.select(_db.paymentRequestRows)
      ..where(
        (tbl) => tbl.state.equalsValue(PaymentRequestStateDto.completed).not(),
      );
    final odp = _db.select(_db.oDPRows)
      ..where((tbl) => tbl.status.equalsValue(ODPStatusDto.success).not());
    final swap = _db.select(_db.swapRows)
      ..where((tbl) => tbl.status.equalsValue(SwapStatusDto.success).not());
    final olp = _db.select(_db.oLPRows)
      ..where((tbl) => tbl.status.equalsValue(OLPStatusDto.withdrawn).not())
      ..where((tbl) => tbl.status.equalsValue(OLPStatusDto.canceled).not());

    final oprStream =
        opr.watch().map((rows) => rows.map((r) => r.toActivity()));
    final odpStream =
        odp.watch().map((rows) => rows.map((r) => r.toActivity(_tokens)));
    final swapStream =
        swap.watch().map((rows) => rows.map((r) => r.toActivity(_tokens)));
    final olpStream =
        olp.watch().map((rows) => rows.map((r) => r.toActivity(_tokens)));

    final onRampStream = _onRampOrderService.watchPending().map(
          (rows) =>
              rows.map((it) => Activity.onRamp(id: it.id, created: it.created)),
        );

    final offRampStream = _offRampOrderService.watchPending().map(
          (rows) => rows
              .map((it) => Activity.offRamp(id: it.id, created: it.created)),
        );

    return Rx.combineLatest<Iterable<Activity>, IList<Activity>>(
      [
        oprStream,
        odpStream,
        swapStream,
        onRampStream,
        olpStream,
        offRampStream,
      ],
      (values) => values
          .expand(identity)
          .toIList()
          .sortOrdered((a, b) => b.created.compareTo(a.created)),
    );
  }
}
