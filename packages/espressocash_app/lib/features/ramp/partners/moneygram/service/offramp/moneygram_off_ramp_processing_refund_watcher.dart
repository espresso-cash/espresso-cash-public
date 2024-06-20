import 'dart:async';

import 'package:drift/drift.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:injectable/injectable.dart';
import 'package:solana/solana.dart';
import 'package:stellar_flutter_sdk/stellar_flutter_sdk.dart' hide Currency;

import '../../../../../../data/db/db.dart';
import '../../../../../accounts/auth_scope.dart';
import '../../../../../accounts/models/ec_wallet.dart';
import '../../../../../currency/models/amount.dart';
import '../../../../../currency/models/currency.dart';
import '../../../../../ramp_partner/models/ramp_partner.dart';
import '../../../../../stellar/models/stellar_wallet.dart';
import '../../../../../stellar/service/stellar_client.dart';
import '../../../../../transactions/models/tx_results.dart';
import '../../../../../transactions/services/tx_confirm.dart';
import '../../data/allbridge_client.dart';
import '../../data/allbridge_dto.dart';

/// Watches for [OffRampOrderStatus.processingRefund] Moneygram orders.
/// bridge the USDC received from Moneygram refund on Stellar to Solana. 
/// It will also check if the user has enough XLM to pay for the transaction.
///
/// Cancels the order when amount is received in Solana.
@Singleton(scope: authScope)
class MoneygramOffRampProcessingRefundWatcher {
  MoneygramOffRampProcessingRefundWatcher(
    this._db,
    this._stellarClient,
    this._ecClient,
    this._stellarWallet,
    this._allbridgeApiClient,
    this._txConfirm,
    ECWallet ecWallet,
  ) : _solanaAddress = ecWallet.publicKey;

  final MyDatabase _db;
  final EspressoCashClient _ecClient;
  final StellarClient _stellarClient;
  final AllbridgeApiClient _allbridgeApiClient;
  final StellarWallet _stellarWallet;
  final Ed25519HDPublicKey _solanaAddress;
  final TxConfirm _txConfirm;

  StreamSubscription<void>? _subscription;

  @PostConstruct()
  void init() {
    final processing = _db.select(_db.offRampOrderRows)
      ..where(
        (tbl) =>
            tbl.status.equalsValue(OffRampOrderStatus.processingRefund) &
            tbl.partner.equalsValue(RampPartner.moneygram),
      );

    final orders = processing.watch();

    _subscription = orders.listen((orderList) {
      orderList.forEach(processOrder);
    });
  }

  Future<void> processOrder(OffRampOrderRow order) async {
    final existingHash = order.stellarTxHash;
    final id = order.id;

    if (existingHash != null) {
      await _pollBridgeStatus(
        orderId: id,
        stellarHash: existingHash,
      );

      return;
    }

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

    final hash = await _stellarClient.submitTransactionFromXdrString(
      bridgeTx,
      userKeyPair: _stellarWallet.keyPair,
    );

    if (hash == null) {
      return;
    }

    final result = await _stellarClient.pollStatus(hash);

    if (result?.status != GetTransactionResponse.STATUS_SUCCESS) {
      return;
    }

    _updateStellarTxHash(id, hash: hash);
  }

  Future<void> _pollBridgeStatus({
    required String orderId,
    required String stellarHash,
  }) async {
    TransactionStatus? status;

    do {
      final response = await _allbridgeApiClient.fetchBridgeStatus(
        BridgeStatusRequestDto(
          chain: Chain.stellar,
          txId: stellarHash,
        ),
      );

      status = response.receive;

      if (status == null) {
        await Future<void>.delayed(const Duration(seconds: 15));
      }
    } while (status == null);

    final solanaTxId = status.txId;
    final receiveAmount = int.tryParse(status.amount);

    final waitResult = await _txConfirm(txId: solanaTxId);
    if (waitResult != const TxWaitSuccess()) {
      return;
    }

    _completeOrder(orderId, txId: solanaTxId, receiveAmount: receiveAmount);
  }

  void _completeOrder(
    String id, {
    required String txId,
    required int? receiveAmount,
  }) {
    _db.update(_db.offRampOrderRows)
      ..where((tbl) => tbl.id.equals(id))
      ..write(
        OffRampOrderRowsCompanion(
          status: const Value(OffRampOrderStatus.cancelled),
          receiveAmount: Value.absentIfNull(receiveAmount),
        ),
      );
  }

  void _updateStellarTxHash(String id, {required String hash}) {
    _db.update(_db.onRampOrderRows)
      ..where((tbl) => tbl.id.equals(id))
      ..write(
        OnRampOrderRowsCompanion(stellarTxHash: Value(hash)),
      );
  }

  @disposeMethod
  void dispose() {
    _subscription?.cancel();
    _subscription = null;
  }
}

const _minimumXlmBalance = 2.5; // 2.5 XLM