import 'dart:async';

import 'package:drift/drift.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../../data/db/db.dart';
import '../../../data/my_database_ext.dart';
import '../../../models/ramp_watcher.dart';
import '../data/scalex_repository.dart';

@injectable
class ScalexOffRampOrderWatcher implements RampWatcher {
  ScalexOffRampOrderWatcher(this._db, this._client);

  final MyDatabase _db;
  final ScalexRepository _client;

  StreamSubscription<void>? _subscription;

  @override
  void watch(String orderId) {
    _subscription = Stream<void>.periodic(const Duration(seconds: 10))
        .startWith(null)
        .asyncMap((_) => _db.getWaitingForPartnerOffRampOrder(orderId))
        .whereNotNull()
        .asyncMap((order) => _client.fetchStatus(order.partnerOrderId))
        .listen((status) async {
      final statement = _db.update(_db.offRampOrderRows)
        ..where(
          (tbl) =>
              tbl.id.equals(orderId) &
              tbl.status.equals(OffRampOrderStatus.waitingForPartner.name),
        );

      final orderStatus = switch (status) {
        ScalexOrderStatus.pending => OffRampOrderStatus.waitingForPartner,
        ScalexOrderStatus.completed => OffRampOrderStatus.completed,
        ScalexOrderStatus.expired ||
        ScalexOrderStatus.failed ||
        ScalexOrderStatus.unknown =>
          OffRampOrderStatus.failure,
      };

      if (orderStatus == OffRampOrderStatus.completed) {
        await _subscription?.cancel();
      }

      await statement.write(
        OffRampOrderRowsCompanion(
          humanStatus: Value(status.name),
          machineStatus: Value(status.name),
          status: Value(orderStatus),
        ),
      );
    });
  }

  @override
  void close() {
    _subscription?.cancel();
  }
}
