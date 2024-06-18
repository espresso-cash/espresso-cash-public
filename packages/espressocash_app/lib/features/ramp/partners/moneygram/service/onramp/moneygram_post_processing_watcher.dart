import 'dart:async';

import 'package:drift/drift.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/solana.dart';

import '../../../../../../data/db/db.dart';
import '../../../../../accounts/auth_scope.dart';
import '../../../../../accounts/models/ec_wallet.dart';
import '../../../../../currency/models/amount.dart';
import '../../../../../currency/models/currency.dart';
import '../../../../../ramp_partner/models/ramp_partner.dart';
import '../../../../../stellar/models/stellar_wallet.dart';
import '../../../../../stellar/service/stellar_client.dart';

/// Watches for [OnRampOrderStatus.postProcessing] Moneygram orders. This will
/// bridge the USDC on Stellar to Solana. It will also check if the user has
/// enough XLM to pay for the transaction.
///
/// Completes the order when amount is received in Solana.
@Singleton(scope: authScope)
class MoneygramPostProcessingWatcher {
  MoneygramPostProcessingWatcher(
    this._db,
    this._stellarClient,
    this._ecClient,
    this._stellarWallet,
    this._solanaClient,
    ECWallet ecWallet,
  ) : _solanaAddress = ecWallet.publicKey;

  final MyDatabase _db;
  final EspressoCashClient _ecClient;
  final StellarClient _stellarClient;
  final StellarWallet _stellarWallet;
  final SolanaClient _solanaClient;
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

    final accountId = _stellarWallet.address;
    final xlmBalance = await _stellarClient.getXlmBalance(accountId);

    if (xlmBalance <= _minimumXlmBalance) {
      await _ecClient.fundXlmRequest(
        FundXlmRequestDto(
          accountId: accountId,
          type: FundType.bridge,
        ),
      );
    }

    // final hash = await _stellarClient.submitTransactionFromXdrString(
    //   bridgeTx,
    //   userKeyPair: _stellarWallet.keyPair,
    // );

    // if (hash == null) {
    //   return;
    // }

    // updateHash(
    //   order.id,
    //   hash: 'hash',
    // );
    //TODO verify, this may recall the function

    // final result = await _stellarClient.pollStatus(hash);

    // print('hash: $hash');

    // TODOcheck if amount is receievd in solana wallet, it should take a few mins

    // updateOrderStatus(order.id);
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

  void updateHash(String id, {required String hash}) {
    _db.update(_db.onRampOrderRows)
      ..where((tbl) => tbl.id.equals(id))
      ..write(
        OnRampOrderRowsCompanion(
          stellarTxHash: Value(hash),
        ),
      );
  }

  @disposeMethod
  void dispose() {
    _subscription?.cancel();
    _subscription = null;
  }
}

const _minimumXlmBalance = 2.5; // 1.5 XLM
