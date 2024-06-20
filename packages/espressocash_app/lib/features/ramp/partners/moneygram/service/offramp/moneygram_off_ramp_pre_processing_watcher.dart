import 'dart:async';

import 'package:drift/drift.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/encoder.dart';

import '../../../../../../data/db/db.dart';
import '../../../../../accounts/auth_scope.dart';
import '../../../../../accounts/models/ec_wallet.dart';
import '../../../../../currency/models/amount.dart';
import '../../../../../currency/models/currency.dart';
import '../../../../../ramp_partner/models/ramp_partner.dart';
import '../../../../../stellar/models/stellar_wallet.dart';
import '../../../../../stellar/service/stellar_client.dart';
import '../../../../../transactions/services/resign_tx.dart';
import '../../../../../transactions/services/tx_sender.dart';

/// Watches for [OffRampOrderStatus.preProcessing] Moneygram orders. This will
/// check if the user has enough XLM balance and USDC trustline, bridge solana USDC
/// to stellar in order to proceed withdraw process.
@Singleton(scope: authScope)
class MoneygramOffRampPreProcessingWatcher {
  MoneygramOffRampPreProcessingWatcher(
    this._db,
    this._stellarClient,
    this._ecWallet,
    this._ecClient,
    this._stellarWallet,
    this._txSender,
  );

  final MyDatabase _db;
  final EspressoCashClient _ecClient;
  final ECWallet _ecWallet;
  final StellarClient _stellarClient;
  final StellarWallet _stellarWallet;
  final TxSender _txSender;

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
    final accountId = _stellarWallet.address;

    final cashOutAmount = CryptoAmount(
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
      amount: cashOutAmount.decimal.toDouble(),
    );

    if (!hasUsdcTrustline) {
      await _stellarClient.createUsdcTrustline(
        userKeyPair: _stellarWallet.keyPair,
        limit: 10000,
      );
    }

    final bridgeTx = await _ecClient
        .swapToStellar(
          SwapToStellarRequestDto(
            amount: cashOutAmount.value.toString(),
            solanaSenderAddress: _ecWallet.address,
            stellarReceiverAddress: accountId,
          ),
        )
        .then((e) => e.encodedTx);

    final tx = await SignedTx.decode(bridgeTx).resign(_ecWallet);

    await _txSender.send(tx, minContextSlot: BigInt.zero);

    //TODO finish logic

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
