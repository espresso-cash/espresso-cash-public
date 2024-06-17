import 'dart:async';

import 'package:decimal/decimal.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../data/db/db.dart';
import '../../../../../../di.dart';
import '../../../../../accounts/auth_scope.dart';
import '../../../../../currency/models/amount.dart';
import '../../../../../currency/models/currency.dart';
import '../../../../../ramp_partner/models/ramp_partner.dart';
import '../../../../../stellar/models/stellar_wallet.dart';
import '../../../../../stellar/service/stellar_client.dart';
import '../../../../data/on_ramp_order_service.dart';
import '../../data/dto.dart';
import '../../data/moneygram_client.dart';

/// Watches for [OnRampOrderStatus.pending] Moneygram orders. An order is left
/// with pending status when user doesn't click Ok on final screen or when
/// the transaction is not completed.
@Singleton(scope: authScope)
class MoneygramPendingWatcher {
  const MoneygramPendingWatcher(
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
    final pending = _db.select(_db.onRampOrderRows)
      ..where(
        (tbl) =>
            tbl.status.equalsValue(OnRampOrderStatus.pending) &
            tbl.partner.equalsValue(RampPartner.moneygram),
      );

    final pendingOrders = await pending.get();

    for (final order in pendingOrders) {
      unawaited(_subscribe(order));
    }
  }

  Future<void> _subscribe(OnRampOrderRow order) async {
    final id = order.id;

    final orderId = order.partnerOrderId;
    String? token = order.authToken;

    token ??= await _stellarClient.fetchToken(wallet: _wallet.keyPair);

    final transaction = await _apiClient
        .fetchTransaction(
          id: orderId,
          authHeader: token.toAuthHeader(),
        )
        .then((e) => e.transaction);

    final moreInfoUrl = transaction.moreInfoUrl;

    if (transaction.status == MgStatus.incomplete ||
        transaction.status == MgStatus.expired ||
        moreInfoUrl == null) {
      await (_db.delete(_db.onRampOrderRows)..where((p) => p.id.equals(id)))
          .go();

      return;
    }

    final transferAmount = Amount.fromDecimal(
      value: Decimal.parse(transaction.amountIn ?? '0'),
      currency: Currency.usd,
    ) as FiatAmount;

    final receiveAmount = Amount.fromDecimal(
      value: Decimal.parse(transaction.amountOut ?? '0'),
      currency: Currency.usdc,
    ) as CryptoAmount;

    await sl<OnRampOrderService>().updateMoneygramOrder(
      id: id,
      receiveAmount: receiveAmount,
      transferExpiryDate: DateTime.now().add(const Duration(days: 1)),
      transferAmount: transferAmount,
      authToken: token,
      moreInfoUrl: moreInfoUrl,
    );
  }
}
