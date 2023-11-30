import 'dart:async';

import 'package:drift/drift.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../data/db/db.dart';
import '../../src/models/ramp_watcher.dart';
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
        .asyncMap(
          (_) {
            final query = _db.select(_db.offRampOrderRows)
              ..where(
                (tbl) =>
                    tbl.id.equals(orderId) &
                    tbl.status
                        .equals(OffRampOrderStatus.waitingForPartner.name),
              );

            return query.getSingleOrNull();
          },
        )
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
