import 'package:drift/drift.dart';

import '../../../data/db/db.dart';

extension MyDatabaseExt on MyDatabase {
  Future<OnRampOrderRow?> getNonCompletedOnRampOrder(String orderId) {
    final query = select(onRampOrderRows)
      ..where(
        (tbl) => tbl.id.equals(orderId) & tbl.isCompleted.equals(false),
      );

    return query.getSingleOrNull();
  }

  Future<OnRampOrderRow?> getWaitingForPartnerOnRampOrder(String orderId) {
    final query = select(onRampOrderRows)
      ..where(
        (tbl) =>
            tbl.id.equals(orderId) &
            tbl.status.equals(OffRampOrderStatus.waitingForPartner.name),
      );

    return query.getSingleOrNull();
  }

  Future<OffRampOrderRow?> getWaitingForPartnerOffRampOrder(String orderId) {
    final query = select(offRampOrderRows)
      ..where(
        (tbl) =>
            tbl.id.equals(orderId) &
            tbl.status.equals(OffRampOrderStatus.waitingForPartner.name),
      );

    return query.getSingleOrNull();
  }

  Future<OffRampOrderRow?> getOffRampOrderWithStatus(
    String orderId, {
    required OffRampOrderStatus status,
  }) {
    final query = select(offRampOrderRows)
      ..where(
        (tbl) => tbl.id.equals(orderId) & tbl.status.equals(status.name),
      );

    return query.getSingleOrNull();
  }
}
