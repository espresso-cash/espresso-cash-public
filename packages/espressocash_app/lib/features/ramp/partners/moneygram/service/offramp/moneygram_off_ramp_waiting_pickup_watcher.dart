import 'dart:async';

import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../data/db/db.dart';
import '../../../../../accounts/auth_scope.dart';
import '../../../../../ramp_partner/models/ramp_partner.dart';
import '../../../../../stellar/models/stellar_wallet.dart';
import '../../../../../stellar/service/stellar_client.dart';
import '../../data/moneygram_client.dart';

/// Watches for [OffRampOrderStatus.waitingPickup]
@Singleton(scope: authScope)
class MoneygramOffRampWaitingPickupWatcher {
  MoneygramOffRampWaitingPickupWatcher(
    this._db,
    this._apiClient,
    this._stellarClient,
    this._wallet,
  );

  final MyDatabase _db;
  final MoneygramApiClient _apiClient;
  final StellarClient _stellarClient;
  final StellarWallet _wallet;

  StreamSubscription<void>? _subscription;

  @PostConstruct()
  void init() {
    final processing = _db.select(_db.offRampOrderRows)
      ..where(
        (tbl) =>
            tbl.status.equalsValue(OffRampOrderStatus.waitingPickup) &
            tbl.partner.equalsValue(RampPartner.moneygram),
      );

    final orders = processing.watch();

    _subscription = orders.listen((orderList) {
      orderList.forEach(processOrder);
    });
  }

  Future<void> processOrder(OffRampOrderRow order) async {
    // todo this will complete order, need to know MG Status when user picked money;
  }

  void updateOrderStatus(String id) {}

  @disposeMethod
  void dispose() {
    _subscription?.cancel();
    _subscription = null;
  }
}
