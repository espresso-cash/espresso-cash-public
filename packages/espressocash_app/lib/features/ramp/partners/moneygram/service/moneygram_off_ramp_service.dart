import 'dart:async';
import 'dart:ui';

import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';
import 'package:stellar_flutter_sdk/stellar_flutter_sdk.dart' hide Currency;
import 'package:uuid/uuid.dart';

import '../../../../../data/db/db.dart';
import '../../../../accounts/auth_scope.dart';
import '../../../../accounts/models/ec_wallet.dart';
import '../../../../balances/services/refresh_balance.dart';
import '../../../../conversion_rates/widgets/extensions.dart';
import '../../../../currency/models/amount.dart';
import '../../../../currency/models/currency.dart';
import '../../../../ramp_partner/models/ramp_partner.dart';
import '../../../../stellar/models/stellar_wallet.dart';
import '../../../../stellar/service/stellar_client.dart';
import '../../../../tokens/token.dart';
import '../../../../transactions/models/tx_results.dart';
import '../../../../transactions/services/resign_tx.dart';
import '../../../../transactions/services/tx_confirm.dart';
import '../../../../transactions/services/tx_sender.dart';
import '../../../data/my_database_ext.dart';
import '../../../models/ramp_type.dart';
import '../data/allbridge_client.dart';
import '../data/allbridge_dto.dart' hide TransactionStatus;
import '../data/dto.dart';
import '../data/moneygram_client.dart';

@Singleton(scope: authScope)
class MoneygramOffRampOrderService implements Disposable {
  MoneygramOffRampOrderService(
    this._ecWallet,
    this._ecClient,
    this._sender,
    this._db,
    this._stellarWallet,
    this._stellarClient,
    this._moneygramClient,
    this._allbridgeApiClient,
    this._solanaClient,
    this._txConfirm,
    this._refreshBalance,
  );

  final MyDatabase _db;
  final TxSender _sender;
  final TxConfirm _txConfirm;
  final RefreshBalance _refreshBalance;

  final ECWallet _ecWallet;
  final StellarWallet _stellarWallet;

  final StellarClient _stellarClient;
  final SolanaClient _solanaClient;

  final EspressoCashClient _ecClient;
  final MoneygramApiClient _moneygramClient;
  final AllbridgeApiClient _allbridgeApiClient;

  final Map<String, StreamSubscription<void>> _subscriptions = {};
  final Map<String, StreamSubscription<void>> _watchers = {};

  @PostConstruct(preResolve: true)
  Future<void> init() async {
    final query = _db.select(_db.offRampOrderRows)
      ..where(
        (tbl) =>
            tbl.status.isNotInValues([
              OffRampOrderStatus.completed,
              OffRampOrderStatus.cancelled,
              OffRampOrderStatus.refunded,
            ]) &
            tbl.partner.equalsValue(RampPartner.moneygram),
      );

    final orders = await query.get();

    for (final order in orders) {
      if (order.partner != RampPartner.moneygram) {
        continue;
      }

      _subscribe(order.id);
    }
  }

  void _subscribe(String orderId) {
    final query = _db.select(_db.offRampOrderRows)
      ..where((tbl) => tbl.id.equals(orderId));

    _subscriptions[orderId] = query
        .watchSingle()
        .asyncExpand<OffRampOrderRowsCompanion?>((order) {
          print('id: $orderId, status: ${order.status}');

          switch (order.status) {
            case OffRampOrderStatus.preProcessing:
              return Stream.fromFuture(_preProcessOrder(order));

            case OffRampOrderStatus.postProcessing:
              _postProcessingWatcher(order);

              return const Stream.empty();

            case OffRampOrderStatus.ready:
              return Stream.fromFuture(_readyProcess(order));

            case OffRampOrderStatus.creatingDepositTx:
              return Stream.fromFuture(_createDeposit(order));

            case OffRampOrderStatus.sendingDepositTx:
              return Stream.fromFuture(_sendPayment(order));

            case OffRampOrderStatus.waitingForPartner:
              _waitingForPartnerWatcher(order);

              return const Stream.empty();

            case OffRampOrderStatus.processingRefund:
              return Stream.fromFuture(_processRefund(order));

            case OffRampOrderStatus.waitingForRefundBridge:
              _watchRefundBridge(order);

              return const Stream.empty();

            case OffRampOrderStatus.completed:
            case OffRampOrderStatus.cancelled:
            case OffRampOrderStatus.refunded:
              _subscriptions.remove(orderId)?.cancel();

              _watchers[orderId]?.cancel();
              _watchers.remove(orderId);

              return const Stream.empty();

            // not used statuses
            case OffRampOrderStatus.depositTxRequired:
            case OffRampOrderStatus.depositError:
            case OffRampOrderStatus.depositTxConfirmError:
            case OffRampOrderStatus.insufficientFunds:
            case OffRampOrderStatus.depositTxReady:
            case OffRampOrderStatus.failure:
              return const Stream.empty();
          }
        })
        .whereNotNull()
        .listen(
          (event) => (_db.update(_db.offRampOrderRows)
                ..where((tbl) => tbl.id.equals(orderId)))
              .write(event),
        );
  }

  AsyncResult<String> createMoneygramOrder({
    required CryptoAmount submittedAmount,
    required FiatAmount? receiveAmount,
  }) =>
      tryEitherAsync((_) async {
        {
          final order = OffRampOrderRow(
            id: const Uuid().v4(),
            partnerOrderId: '',
            amount: submittedAmount.value,
            token: Token.usdc.address,
            receiveAmount: receiveAmount?.value,
            fiatSymbol: receiveAmount?.fiatCurrency.symbol,
            created: DateTime.now(),
            humanStatus: '',
            machineStatus: '',
            partner: RampPartner.moneygram,
            status: OffRampOrderStatus.preProcessing,
            transaction: '',
            depositAddress: '',
            slot: BigInt.zero,
          );

          await _db.into(_db.offRampOrderRows).insert(order);
          _subscribe(order.id);

          return order.id;
        }
      });

  Future<void> updateMoneygramWithdrawUrl({
    required String id,
    required String withdrawUrl,
    required String authToken,
    required String orderId,
  }) async {
    final updateQuery = _db.update(_db.offRampOrderRows)
      ..where((tbl) => tbl.id.equals(id));

    await updateQuery.write(
      OffRampOrderRowsCompanion(
        partnerOrderId: Value(orderId),
        withdrawUrl: Value(withdrawUrl),
        authToken: Value(authToken),
      ),
    );
  }

  AsyncResult<void> updateMoneygramOrder({required String id}) =>
      tryEitherAsync((_) async {
        final updateQuery = _db.update(_db.offRampOrderRows)
          ..where((tbl) => tbl.id.equals(id));

        await updateQuery.write(
          const OffRampOrderRowsCompanion(
            status: Value(OffRampOrderStatus.creatingDepositTx),
          ),
        );
      });

  AsyncResult<void> processRefund(String id) => tryEitherAsync((_) async {
        final order = await _fetchOrder(id);

        final transaction = await _fetchTransactionStatus(
          id: order.partnerOrderId,
          token: order.authToken ?? '',
        );

        if (transaction.status != MgStatus.refunded) {
          return;
        }

        final updateQuery = _db.update(_db.offRampOrderRows)
          ..where((tbl) => tbl.id.equals(id));

        await updateQuery.write(
          const OffRampOrderRowsCompanion(
            status: Value(OffRampOrderStatus.processingRefund),
          ),
        );
      });

  Future<OffRampOrderRowsCompanion> _preProcessOrder(
    OffRampOrderRow order,
  ) async {
    final accountId = _stellarWallet.address;

    final cashOutAmount = CryptoAmount(
      value: order.amount,
      cryptoCurrency: Currency.usdc,
    );

    final xlmBalance = await _stellarClient.getXlmBalance(accountId);

    if (xlmBalance <= _minimumInitBalance) {
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

    final latestBlockhash = await _solanaClient.rpcClient.getLatestBlockhash(
      commitment: Commitment.confirmed,
    );

    final slot = latestBlockhash.context.slot;

    // `TODO`: commented to mock bridging

    final send = await _sender.send(tx, minContextSlot: slot);

    if (send != const TxSendSent()) {
      return const OffRampOrderRowsCompanion(
        status: Value(OffRampOrderStatus.preProcessing),
      );
    }

    final wait = await _sender.wait(
      tx,
      minContextSlot: slot,
      txType: 'AllBridgeTx',
    );

    if (wait != const TxWaitSuccess()) {
      return const OffRampOrderRowsCompanion(
        status: Value(OffRampOrderStatus.preProcessing),
      );
    }

    _refreshBalance();

    return OffRampOrderRowsCompanion(
      status: const Value(OffRampOrderStatus.postProcessing),
      solanaBridgeTx: Value(tx.id),
      transaction: Value(bridgeTx),
    );
  }

  Future<OffRampOrderRowsCompanion?> _readyProcess(
    OffRampOrderRow order,
  ) async {
    if (order.partnerOrderId.isEmpty) {
      return null;
    }

    final isReady = order.status == OffRampOrderStatus.ready;

    final transaction = await _fetchTransactionStatus(
      id: order.partnerOrderId,
      token: order.authToken ?? '',
    );

    if (isReady && transaction.status == MgStatus.pendingUserTransferStart) {
      return const OffRampOrderRowsCompanion(
        status: Value(OffRampOrderStatus.creatingDepositTx),
      );
    }

    if (isReady && transaction.status == MgStatus.refunded) {
      return const OffRampOrderRowsCompanion(
        status: Value(OffRampOrderStatus.processingRefund),
      );
    }
  }

  Future<OffRampOrderRowsCompanion?> _createDeposit(
    OffRampOrderRow order,
  ) async {
    final id = order.id;

    final transaction = await _fetchTransactionStatus(
      id: order.partnerOrderId,
      token: order.authToken ?? '',
    );

    final receiveAmount = Amount.fromDecimal(
      value: Decimal.parse(transaction.amountOut ?? '0'),
      currency: Currency.usd,
    ) as FiatAmount;

    final fee = Amount.fromDecimal(
      value: Decimal.parse(transaction.amountFee ?? '0'),
      currency: Currency.usdc,
    ) as CryptoAmount;

    final withdrawAnchorAccount = transaction.withdrawAnchorAccount;
    final withdrawMemo = transaction.withdrawMemo;
    final moreInfoUrl = transaction.moreInfoUrl;

    final updateQuery = _db.update(_db.offRampOrderRows)
      ..where((tbl) => tbl.id.equals(id));

    await updateQuery.write(
      OffRampOrderRowsCompanion(
        receiveAmount: Value(receiveAmount.value),
        fiatSymbol: Value(receiveAmount.fiatCurrency.symbol),
        withdrawAnchorAccount: Value(withdrawAnchorAccount),
        withdrawMemo: Value(withdrawMemo),
        moreInfoUrl: Value(moreInfoUrl),
        feeAmount: Value(fee.value),
        feeToken: Value(fee.token.address),
        status: const Value(OffRampOrderStatus.sendingDepositTx),
      ),
    );
  }

  void _postProcessingWatcher(OffRampOrderRow order) {
    final id = order.id;

    if (_watchers.containsKey(id)) {
      return;
    }

    _watchers[id] = Stream<void>.periodic(const Duration(seconds: 30))
        .startWith(null)
        .asyncMap(
          (_) => _db.getOffRampOrderWithStatus(
            id,
            status: OffRampOrderStatus.postProcessing,
          ),
        )
        .whereNotNull()
        .listen((order) async {
      final statement = _db.update(_db.offRampOrderRows)
        ..where(
          (tbl) =>
              tbl.id.equals(id) &
              tbl.status.equals(OnRampOrderStatus.postProcessing.name),
        );

      final hash = order.solanaBridgeTx;

      if (hash == null) {
        return;
      }

      final response = await _allbridgeApiClient
          .fetchBridgeStatus(
            BridgeStatusRequestDto(chain: Chain.solana, txId: hash),
          )
          .catchError((_) => null);

      final destination = response?.receive;

      if (destination == null) {
        return;
      }

      final payment = await _stellarClient.getPaymentByTxId(destination.txId);

      if (payment == null) {
        return;
      }

      //TODO: MOCK only
      // await Future<void>.delayed(const Duration(seconds: 1));

      await statement.write(
        const OffRampOrderRowsCompanion(
          status: Value(OffRampOrderStatus.ready),
        ),
      );

      _removeWatcher(id);
    });
  }

  void _waitingForPartnerWatcher(OffRampOrderRow order) {
    final id = order.id;

    if (_watchers.containsKey(id)) {
      return;
    }

    _watchers[id] = Stream<void>.periodic(const Duration(seconds: 60))
        .startWith(null)
        .asyncMap((_) => _db.getWaitingForPartnerOffRampOrder(id))
        .whereNotNull()
        .listen((order) async {
      final statement = _db.update(_db.offRampOrderRows)
        ..where(
          (tbl) => tbl.id.equals(id),
        );
      final String token = order.authToken ?? '';
      final transaction = await _moneygramClient
          .fetchTransaction(
            id: order.partnerOrderId,
            authHeader: token.toAuthHeader(),
            rampType: RampType.offRamp,
          )
          .then((e) => e.transaction);

      final isCompleted = transaction.status == MgStatus.completed;

      if (!isCompleted) return;

      _removeWatcher(id);

      await statement.write(
        const OffRampOrderRowsCompanion(
          status: Value(OffRampOrderStatus.completed),
        ),
      );
    });
  }

  Future<OffRampOrderRowsCompanion?> _sendPayment(OffRampOrderRow order) async {
    final accountId = _stellarWallet.address;

    final amount = CryptoAmount(
      value: order.amount,
      cryptoCurrency: Currency.usdc,
    );

    final String formattedAmount =
        amount.format(const Locale('en'), skipSymbol: true);

    final transactionSucceed = await _stellarClient.sendUsdc(
      accountId,
      destinationAddress: order.withdrawAnchorAccount ?? '',
      memo: order.withdrawMemo ?? '',
      amount: formattedAmount,
    );

    return transactionSucceed
        ? const OffRampOrderRowsCompanion(
            status: Value(OffRampOrderStatus.waitingForPartner),
          )
        : null;
  }

  Future<OffRampOrderRowsCompanion?> _processRefund(
    OffRampOrderRow order,
  ) async {
    final existingHash = order.stellarTxHash;

    if (existingHash != null) {
      return const OffRampOrderRowsCompanion(
        status: Value(OffRampOrderStatus.waitingForRefundBridge),
      );
    }

    final response = await _allbridgeApiClient
        .fetchBridgeStatus(
          BridgeStatusRequestDto(
            chain: Chain.solana,
            txId: order.solanaBridgeTx ?? '',
          ),
        )
        .then((e) => e?.receive)
        .catchError((_) => null);

    if (response == null) {
      return const OffRampOrderRowsCompanion(
        status: Value(OffRampOrderStatus.processingRefund),
      );
    }

    final amount = int.parse(response.amount) ~/ 10;

    final solanaAddress = _ecWallet.address;

    final bridgeTx = await _ecClient
        .swapToSolana(
          SwapToSolanaRequestDto(
            amount: amount.toStringAsFixed(0),
            stellarSenderAddress: _stellarWallet.address,
            solanaReceiverAddress: solanaAddress,
          ),
        )
        .then((e) => e.encodedTx);

    final hash = await _stellarClient.submitTransactionFromXdrString(
      bridgeTx,
      userKeyPair: _stellarWallet.keyPair,
    );

    if (hash == null) {
      return const OffRampOrderRowsCompanion(
        status: Value(OffRampOrderStatus.processingRefund),
      );
    }

    final result = await _stellarClient.pollStatus(hash);

    if (result?.status != GetTransactionResponse.STATUS_SUCCESS) {
      return null;
    }

    return result?.status != GetTransactionResponse.STATUS_SUCCESS
        ? const OffRampOrderRowsCompanion(
            status: Value(OffRampOrderStatus.processingRefund),
          )
        : OffRampOrderRowsCompanion(
            stellarTxHash: Value(hash),
            status: const Value(OffRampOrderStatus.waitingForRefundBridge),
          );
  }

  void _watchRefundBridge(OffRampOrderRow order) {
    final id = order.id;

    if (_watchers.containsKey(id)) {
      return;
    }

    _watchers[id] =
        Stream<void>.periodic(const Duration(seconds: 60)).listen((_) async {
      final statement = _db.update(_db.offRampOrderRows)
        ..where(
          (tbl) => tbl.id.equals(id),
        );

      final hash = order.stellarTxHash;

      if (hash == null) {
        await statement.write(
          const OffRampOrderRowsCompanion(
            status: Value(OffRampOrderStatus.processingRefund),
          ),
        );

        _removeWatcher(id);

        return;
      }

      final response = await _allbridgeApiClient.fetchBridgeStatus(
        BridgeStatusRequestDto(
          chain: Chain.stellar,
          txId: hash,
        ),
      );

      final status = response?.receive;

      if (status == null) {
        return;
      }

      final solanaTxId = status.txId;

      final waitResult = await _txConfirm(txId: solanaTxId);
      if (waitResult != const TxWaitSuccess()) {
        return;
      }

      _refreshBalance();

      await statement.write(
        const OffRampOrderRowsCompanion(
          status: Value(OffRampOrderStatus.refunded),
        ),
      );

      _removeWatcher(id);
    });
  }

  Future<OffRampOrderRow> _fetchOrder(String id) {
    final query = _db.select(_db.offRampOrderRows)
      ..where((tbl) => tbl.id.equals(id));

    return query.getSingle();
  }

  Future<TransactionStatus> _fetchTransactionStatus({
    required String id,
    required String token,
  }) =>
      _moneygramClient
          .fetchTransaction(
            id: id,
            authHeader: token.toAuthHeader(),
            rampType: RampType.offRamp,
          )
          .then((e) => e.transaction);

  void _removeWatcher(String id) {
    _watchers.remove(id)?.cancel();
  }

  @override
  Future<void> onDispose() async {
    await Future.wait(_subscriptions.values.map((it) => it.cancel()));
    _watchers.values.map((it) => it.cancel());
  }
}

const _minimumInitBalance = 1.5; // 1.5 XLM