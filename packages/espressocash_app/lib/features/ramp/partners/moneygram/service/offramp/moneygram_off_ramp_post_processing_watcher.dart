import 'dart:async';

import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../data/db/db.dart';
import '../../../../../accounts/auth_scope.dart';
import '../../../../../ramp_partner/models/ramp_partner.dart';
import '../../../../../stellar/models/stellar_wallet.dart';
import '../../../../../stellar/service/stellar_client.dart';
import '../../data/moneygram_client.dart';

@Singleton(scope: authScope)
class MoneygramOffRampPostProcessingWatcher {
  const MoneygramOffRampPostProcessingWatcher(
    this._db,
    this._apiClient,
    this._stellarClient,
    this._wallet,
  );

  final MyDatabase _db;
  final MoneygramApiClient _apiClient;
  final StellarClient _stellarClient;
  final StellarWallet _wallet;

  @PostConstruct()
  Future<void> init() async {
    final pending = _db.select(_db.offRampOrderRows)
      ..where(
        (tbl) =>
            tbl.status.equalsValue(OffRampOrderStatus.postProcessing) &
            tbl.partner.equalsValue(RampPartner.moneygram),
      );

    final pendingOrders = await pending.get();

    for (final order in pendingOrders) {
      _subscribe(order);
    }
  }

  void _subscribe(OffRampOrderRow order) {
    print(order.id);

    print('post processing start');
  }
}
