import 'dart:async';

import 'package:drift/drift.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../data/db/db.dart';
import '../../data/my_database_ext.dart';
import '../../src/models/ramp_watcher.dart';
import '../data/scalex_repository.dart';

@injectable
class ScalexOnRampOrderWatcher implements RampWatcher {
  ScalexOnRampOrderWatcher(this._db, this._client);

  final MyDatabase _db;
  final ScalexRepository _client;

  StreamSubscription<void>? _subscription;

  @override
  void watch(String orderId) {
    _subscription = Stream<void>.periodic(const Duration(seconds: 10))
        .asyncMap((_) => _db.getNonCompletedOnRampOrder(orderId))
        .whereNotNull()
        .asyncMap((order) => _client.fetchStatus(order.partnerOrderId))
        .listen((status) async {
      final statement = _db.update(_db.onRampOrderRows)
        ..where(
          (tbl) => tbl.id.equals(orderId) & tbl.isCompleted.equals(false),
        );

      final isCompleted = status == ScalexOrderStatus.completed;

      if (isCompleted) await _subscription?.cancel();

      await statement.write(
        OnRampOrderRowsCompanion(
          humanStatus: Value(status.name),
          machineStatus: Value(status.name),
          isCompleted: Value(isCompleted),
        ),
      );
    });
  }

  @override
  void close() {
    _subscription?.cancel();
  }
}
