import 'dart:async';

import 'package:drift/drift.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../data/db/db.dart';
import '../../data/my_database_ext.dart';
import '../../src/models/ramp_watcher.dart';
import '../data/orm_repository.dart';

@injectable
class OrmOffRampOrderWatcher implements RampWatcher {
  OrmOffRampOrderWatcher(this._db, this._client);

  final MyDatabase _db;
  final OrmRepository _client;

  StreamSubscription<void>? _subscription;

  @override
  void watch(String orderId) {
    _subscription = Stream<void>.periodic(const Duration(seconds: 10))
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

      final isCompleted = status == ScalexOrderStatus.completed; //TODO

      if (isCompleted) await _subscription?.cancel();

      await statement.write(
        OffRampOrderRowsCompanion(
          humanStatus: Value(status.name),
          machineStatus: Value(status.name),
          status: isCompleted
              ? const Value(OffRampOrderStatus.completed)
              : const Value(OffRampOrderStatus.waitingForPartner),
        ),
      );
    });
  }

  @override
  void close() {
    _subscription?.cancel();
  }
}
