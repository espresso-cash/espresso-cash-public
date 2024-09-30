import 'dart:async';

import 'package:drift/drift.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../../data/db/db.dart';
import '../../../../analytics/analytics_manager.dart';
import '../../../../kyc_sharing/models/kyc_order_status.dart';
import '../../../../kyc_sharing/services/kyc_service.dart';
import '../../../../ramp_partner/models/ramp_partner.dart';
import '../../../data/my_database_ext.dart';
import '../../../models/ramp_type.dart';
import '../../../models/ramp_watcher.dart';

@injectable
class KycOnRampOrderWatcher implements RampWatcher {
  KycOnRampOrderWatcher(this._db, this._service, this._analytics);

  final MyDatabase _db;
  final KycSharingService _service;
  final AnalyticsManager _analytics;

  StreamSubscription<void>? _subscription;

  @override
  void watch(String orderId) {
    _subscription = Stream<void>.periodic(const Duration(seconds: 10))
        .startWith(null)
        .asyncMap((_) => _db.getNonCompletedOnRampOrder(orderId))
        .whereNotNull()
        .asyncMap((order) => _service.fetchOrder(order.partnerOrderId))
        .listen((data) async {
      final statement = _db.update(_db.onRampOrderRows)
        ..where(
          (tbl) => tbl.id.equals(orderId) & tbl.isCompleted.equals(false),
        );

      final isCompleted = data.status == KycOrderStatus.completed.value;
      final isExpired = data.status == KycOrderStatus.completed.value;

      if (isCompleted || isExpired) await _subscription?.cancel();

      final status = isCompleted
          ? OnRampOrderStatus.completed
          : isExpired
              ? OnRampOrderStatus.depositExpired
              : null;

      if (isCompleted) {
        _analytics.rampCompleted(
          partner: RampPartner.kyc,
          rampType: RampType.onRamp.name,
          id: orderId,
        );
      }

      await statement.write(
        OnRampOrderRowsCompanion(
          status: Value.absentIfNull(status),
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
