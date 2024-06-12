import 'dart:async';

import 'package:drift/drift.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:injectable/injectable.dart';

import '../../../../../data/db/db.dart';
import '../../../../../di.dart';
import '../../../../accounts/auth_scope.dart';
import '../../../../ramp_partner/models/ramp_partner.dart';
import '../../../../stellar/models/stellar_wallet.dart';
import '../../../../stellar/service/stellar_client.dart';
import '../data/moneygram_client.dart';

@Singleton(scope: authScope)
class MoneygramProcessingWatcher {
  MoneygramProcessingWatcher(
    this._db,
    this._apiClient,
    this._stellarClient,
    this._ecClient,
  );

  final MyDatabase _db;
  final EspressoCashClient _ecClient;
  final MoneygramApiClient _apiClient;
  final StellarClient _stellarClient;

  StreamSubscription<void>? _subscription;

  @PostConstruct()
  void init() {
    final processing = _db.select(_db.onRampOrderRows)
      ..where(
        (tbl) =>
            tbl.status.equalsValue(OnRampOrderStatus.processing) &
            tbl.partner.equalsValue(RampPartner.moneygram),
      );

    final orders = processing.watch();

    _subscription = orders.listen((orderList) {
      orderList.forEach(processOrder);
    });
  }

  Future<void> processOrder(OnRampOrderRow order) async {
    final wallet = sl<StellarWallet>();
    final accountId = wallet.address;
    final cashInAmount = order.amount;

    final xlmBalance = await _stellarClient.getUsdcBalance(accountId);

    final hasUsdcTrustline = await _stellarClient.hasUsdcTrustline(
      accountId,
      amount: 1,
    ); //TODO amount

    //TODO callback if xlmBalance is not enough

    print('xlmBalance: $xlmBalance');
    print('hasUsdcTrustline: $hasUsdcTrustline');

    // if (hasUsdcTrustline) {
    //   await _stellarClient.createUsdcTrustline(
    //     userKeyPair: _wallet.keyPair,
    //     limit: 1000,
    //   );
    // }

    updateOrderStatus(order.id);
  }

  void updateOrderStatus(String id) {
    _db.update(_db.onRampOrderRows)
      ..where((tbl) => tbl.id.equals(id))
      ..write(
        const OnRampOrderRowsCompanion(
          status: Value(OnRampOrderStatus.waitingForDeposit),
        ),
      );
  }

  @disposeMethod
  void dispose() {
    _subscription?.cancel();
    _subscription = null;
  }
}
