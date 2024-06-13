import 'dart:async';

import 'package:drift/drift.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/solana.dart';

import '../../../../../data/db/db.dart';
import '../../../../accounts/auth_scope.dart';
import '../../../../accounts/models/ec_wallet.dart';
import '../../../../currency/models/amount.dart';
import '../../../../currency/models/currency.dart';
import '../../../../ramp_partner/models/ramp_partner.dart';
import '../../../../stellar/models/stellar_wallet.dart';
import '../../../../stellar/service/stellar_client.dart';

/// Watches for [OnRampOrderStatus.postProcessing] Moneygram orders. This will
/// bridge the USDC on Stellar to Solana. It will also check if the user has
/// enough XLM to pay for the transaction.
@Singleton(scope: authScope)
class MoneygramPostProcessingWatcher {
  MoneygramPostProcessingWatcher(
    this._db,
    this._stellarClient,
    this._ecClient,
    this._stellarWallet,
    ECWallet ecWallet,
  ) : _solanaAddress = ecWallet.publicKey;

  final MyDatabase _db;
  final EspressoCashClient _ecClient;
  final StellarClient _stellarClient;
  final StellarWallet _stellarWallet;
  final Ed25519HDPublicKey _solanaAddress;

  StreamSubscription<void>? _subscription;

  @PostConstruct()
  void init() {
    final processing = _db.select(_db.onRampOrderRows)
      ..where(
        (tbl) =>
            tbl.status.equalsValue(OnRampOrderStatus.postProcessing) &
            tbl.partner.equalsValue(RampPartner.moneygram),
      );

    final orders = processing.watch();

    _subscription = orders.listen((orderList) {
      orderList.forEach(processOrder);
    });
  }

  Future<void> processOrder(OnRampOrderRow order) async {
    final amount = CryptoAmount(
      value: order.amount,
      cryptoCurrency: Currency.usdc,
    );

    final bridgeTx = await _ecClient
        .swapToSolana(
          SwapToSolanaRequestDto(
            amount: amount.value.toString(),
            stellarSenderAddress: _stellarWallet.address,
            solanaReceiverAddress: _solanaAddress.toBase58(),
          ),
        )
        .then((e) => e.encodedTx);

    // print('bridgeTx: $bridgeTx');

    final hash = await _stellarClient.submitTransactionFromXdrString(
      bridgeTx,
      userKeyPair: _stellarWallet.keyPair,
    );

    print('hash: $hash');

    updateOrderStatus(order.id);
  }

  void updateOrderStatus(String id) {
    _db.update(_db.onRampOrderRows)
      ..where((tbl) => tbl.id.equals(id))
      ..write(
        const OnRampOrderRowsCompanion(
          status: Value(OnRampOrderStatus.completed),
          isCompleted: Value(true),
        ),
      );
  }

  @disposeMethod
  void dispose() {
    _subscription?.cancel();
    _subscription = null;
  }
}
