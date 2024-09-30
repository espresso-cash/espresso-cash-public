import 'dart:async';

import 'package:drift/drift.dart';
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


// TODO 
// 1) This watcher will be only init when u go to activities
// 2) KycOrderStatus.accepted => OnRampOrderStatus.waitingForDeposit might return step back (check this)
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

      final status = switch (KycOrderStatus.fromString(data.status)) {
        KycOrderStatus.completed => OnRampOrderStatus.completed,
        KycOrderStatus.unknown ||
        KycOrderStatus.rejected ||
        KycOrderStatus.failed =>
          OnRampOrderStatus.failure,
        KycOrderStatus.pending => OnRampOrderStatus.waitingVerification,
        KycOrderStatus.accepted => OnRampOrderStatus.waitingForDeposit,
      };

      final isCompleted = status == OnRampOrderStatus.completed;

      if (isCompleted) {
        await _subscription?.cancel();

        _analytics.rampCompleted(
          partner: RampPartner.kyc,
          rampType: RampType.onRamp.name,
          id: orderId,
        );
      }

      await statement.write(
        OnRampOrderRowsCompanion(
          status: Value(status),
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
