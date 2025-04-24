import 'dart:async';

import 'package:drift/drift.dart';
import 'package:ec_client_dart/ec_client_dart.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../../data/db/db.dart';
import '../../../../analytics/analytics_manager.dart';
import '../../../../ramp_partner/models/ramp_partner.dart';
import '../../../../ramp_partner/models/ramp_type.dart';
import '../../../data/my_database_ext.dart';
import '../../../models/ramp_watcher.dart';
import '../data/scalex_repository.dart';

@injectable
class ScalexOnRampOrderWatcher implements RampWatcher {
  ScalexOnRampOrderWatcher(this._db, this._client, this._analytics);

  final MyDatabase _db;
  final ScalexRepository _client;
  final AnalyticsManager _analytics;

  StreamSubscription<void>? _subscription;

  @override
  void watch(String orderId) {
    _subscription = Stream<void>.periodic(const Duration(seconds: 10))
        .startWith(null)
        .asyncMap((_) => _db.getNonCompletedOnRampOrder(orderId))
        .whereNotNull()
        .asyncMap((order) => _client.fetchStatus(order.partnerOrderId))
        .listen((data) async {
          final statement = _db.update(_db.onRampOrderRows)
            ..where((tbl) => tbl.id.equals(orderId) & tbl.isCompleted.equals(false));

          final isCompleted = data == ScalexOrderStatus.completed;
          final isExpired = data == ScalexOrderStatus.expired;

          if (isCompleted || isExpired) await _subscription?.cancel();

          final status =
              isCompleted
                  ? OnRampOrderStatus.completed
                  : isExpired
                  ? OnRampOrderStatus.depositExpired
                  : null;

          if (isCompleted) {
            _analytics.rampCompleted(
              partnerName: RampPartner.scalex.name,
              rampType: RampType.onRamp.name,
              id: orderId,
            );
          }

          await statement.write(
            OnRampOrderRowsCompanion(
              status: Value.ofNullable(status),
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
