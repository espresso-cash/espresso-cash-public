import 'dart:async';

import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../data/db/db.dart';
import '../../src/models/ramp_watcher.dart';
import '../data/scalex_api_client.dart';

@injectable
class ScalexOnRampOrderWatcher implements RampWatcher {
  ScalexOnRampOrderWatcher(this._db, this._client);

  final MyDatabase _db;
  final ScalexApiClient _client;

  StreamSubscription<void>? _subscription;

  @override
  void watch(String orderId) {
    _subscription = Stream<void>.periodic(const Duration(seconds: 10))
        .asyncMap(
          (_) {
            final query = _db.select(_db.onRampOrderRows)
              ..where(
                (tbl) => tbl.id.equals(orderId) & tbl.isCompleted.equals(false),
              );

            return query.getSingleOrNull();
          },
        )
        .whereNotNull()
        .asyncMap((order) => _client.getTransaction(order.partnerOrderId))
        .listen((event) async {
          // ignore: prefer-early-return, cannot use
          if (event.data case final data) {
            final statement = _db.update(_db.onRampOrderRows)
              ..where(
                (tbl) => tbl.id.equals(orderId) & tbl.isCompleted.equals(false),
              );

            final isCompleted = data.status == OrderStatus.completed;

            if (isCompleted) await _subscription?.cancel();

            await statement.write(
              OnRampOrderRowsCompanion(
                humanStatus: Value(data.status.name),
                machineStatus: Value(data.status.name),
                isCompleted: Value(isCompleted),
              ),
            );
          }
        });
  }

  @override
  void close() {
    _subscription?.cancel();
  }
}
