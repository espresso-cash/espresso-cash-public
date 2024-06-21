import 'dart:async';

import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../../data/db/db.dart';
import '../../../../../currency/models/amount.dart';
import '../../../../../currency/models/currency.dart';
import '../../../../../stellar/models/stellar_wallet.dart';
import '../../../../../stellar/service/stellar_client.dart';
import '../../../../data/my_database_ext.dart';
import '../../../../models/ramp_watcher.dart';

/// Watches for [OnRampOrderStatus.waitingForPartner] Moneygram orders. This will
/// check if Moneygram has sent the funds to the user's Stellar account after the user
/// has deposited. It will verify the amount and memo of the payment.
@injectable
class MoneygramOnRampOrderWatcher implements RampWatcher {
  MoneygramOnRampOrderWatcher(
    this._db,
    this._stellarClient,
    this._stellarWallet,
  );

  final MyDatabase _db;
  final StellarClient _stellarClient;
  final StellarWallet _stellarWallet;
  StreamSubscription<void>? _subscription;

  @override
  void watch(String orderId) {
    _subscription = Stream<void>.periodic(const Duration(seconds: 15))
        .startWith(null)
        .asyncMap((_) => _db.getWaitingForPartnerOnRampOrder(orderId))
        .whereNotNull()
        .listen((order) async {
      final statement = _db.update(_db.onRampOrderRows)
        ..where(
          (tbl) =>
              tbl.id.equals(orderId) &
              tbl.status.equals(OnRampOrderStatus.waitingForPartner.name),
        );

      final amount = CryptoAmount(
        value: order.amount,
        cryptoCurrency: Currency.usdc,
      );

      final usdcBalance =
          await _stellarClient.getUsdcBalance(_stellarWallet.address) ?? 0;

      if (usdcBalance == 0) {
        // Funds not received yet
        return;
      }

      if (usdcBalance < amount.decimal.toDouble()) {
        // Not enough funds
        return;
      }

      await statement.write(
        const OnRampOrderRowsCompanion(
          status: Value.absentIfNull(OnRampOrderStatus.postProcessing),
          isCompleted: Value(false),
        ),
      );
    });
  }

  @override
  void close() {
    _subscription?.cancel();
  }
}
