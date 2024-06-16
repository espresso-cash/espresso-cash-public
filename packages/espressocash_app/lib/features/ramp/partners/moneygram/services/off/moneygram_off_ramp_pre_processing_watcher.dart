import 'dart:async';

import 'package:drift/drift.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../data/db/db.dart';
import '../../../../../accounts/auth_scope.dart';
import '../../../../../currency/models/amount.dart';
import '../../../../../currency/models/currency.dart';
import '../../../../../ramp_partner/models/ramp_partner.dart';
import '../../../../../stellar/models/stellar_wallet.dart';
import '../../../../../stellar/service/stellar_client.dart';

/// Watches for [OffRampOrderStatus.preProcessing] Moneygram orders. This will
/// check if the user has enough XLM balance and USDC trustline, bridge solana USDC
/// to stellar in order to proceed withdraw process.
@Singleton(scope: authScope)
class MoneygramOffRampPreProcessingWatcher {
   MoneygramOffRampPreProcessingWatcher(
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
    final processing = _db.select(_db.offRampOrderRows)
      ..where(
        (tbl) =>
            tbl.status.equalsValue(OffRampOrderStatus.preProcessing) &
            tbl.partner.equalsValue(RampPartner.moneygram),
      );

    final orders = processing.watch();

    _subscription = orders.listen((orderList) {
      orderList.forEach(processOrder);
    });
  }

  Future<void> processOrder(OffRampOrderRow order) async {
    final accountId = _wallet.address;

    final cashInAmount = CryptoAmount(
      value: order.amount,
      cryptoCurrency: Currency.usdc,
    );

    final xlmBalance = await _stellarClient.getXlmBalance(accountId);

    if (xlmBalance <= _minimumXlmBalance) {
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
        limit: 10000,
      );
    }

    // Todo implement bridge here

    updateOrderStatus(order.id);
  }

  void updateOrderStatus(String id) {
    _db.update(_db.offRampOrderRows)
      ..where((tbl) => tbl.id.equals(id))
      ..write(
        const OffRampOrderRowsCompanion(
          status: Value(OffRampOrderStatus.postProcessing),
        ),
      );
  }

  @disposeMethod
  void dispose() {
    _subscription?.cancel();
    _subscription = null;
  }
}

const _minimumXlmBalance = 1.5; // 1.5 XLM
