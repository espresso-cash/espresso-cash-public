import 'dart:async';

import 'package:drift/drift.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:injectable/injectable.dart';

import '../../../../../data/db/db.dart';
import '../../../../accounts/auth_scope.dart';
import '../../../../currency/models/amount.dart';
import '../../../../currency/models/currency.dart';
import '../../../../ramp_partner/models/ramp_partner.dart';
import '../../../../stellar/models/stellar_wallet.dart';
import '../../../../stellar/service/stellar_client.dart';

@Singleton(scope: authScope)
class MoneygramProcessingWatcher {
  MoneygramProcessingWatcher(
    this._db,
    this._stellarClient,
    this._ecClient,
    this._wallet,
  );

  final MyDatabase _db;
  final EspressoCashClient _ecClient;
  final StellarClient _stellarClient;
  final StellarWallet _wallet;

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
    final accountId = _wallet.address;
    const minimumXlmBalance = 1.0; //TODO

    final cashInAmount = CryptoAmount(
      value: order.amount,
      cryptoCurrency: Currency.usdc,
    );

    final xlmBalance = await _stellarClient.getUsdcBalance(accountId) ?? 0;

    if (xlmBalance < minimumXlmBalance) {
      await _ecClient.fundXlmRequest(
        FundXlmRequestDto(
          accountId: accountId,
          type: FundType.init,
        ),
      );
    }

    final hasUsdcTrustline = await _stellarClient.hasUsdcTrustline(
      accountId,
      amount: cashInAmount.decimal.toDouble(),
    );

    if (!hasUsdcTrustline) {
      await _stellarClient.createUsdcTrustline(
        userKeyPair: _wallet.keyPair,
        limit: 1000,
      );
    }

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
