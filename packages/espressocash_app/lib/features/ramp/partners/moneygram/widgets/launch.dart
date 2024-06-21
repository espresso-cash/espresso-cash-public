import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../../../data/db/db.dart';
import '../../../../../di.dart';
import '../../../../../l10n/device_locale.dart';
import '../../../../../l10n/l10n.dart';
import '../../../../../ui/dialogs.dart';
import '../../../../../ui/loader.dart';
import '../../../../../ui/snackbar.dart';
import '../../../../../ui/theme.dart';
import '../../../../../ui/web_view_screen.dart';
import '../../../../currency/models/amount.dart';
import '../../../../currency/models/currency.dart';
import '../../../../ramp_partner/models/ramp_partner.dart';
import '../../../../stellar/models/stellar_wallet.dart';
import '../../../../stellar/service/stellar_client.dart';
import '../../../data/on_ramp_order_service.dart';
import '../../../models/ramp_type.dart';
import '../../../screens/off_ramp_order_screen.dart';
import '../../../screens/on_ramp_order_screen.dart';
import '../../../screens/ramp_amount_screen.dart';
import '../../../services/off_ramp_order_service.dart';
import '../data/dto.dart';
import '../data/moneygram_client.dart';

typedef MoneygramLink = ({String id, String url, String token});

extension BuildContextExt on BuildContext {
  Future<void> launchMoneygramOnRamp() async {
    Amount? amount;

    const partner = RampPartner.moneygram;

    await RampAmountScreen.push(
      this,
      partner: partner,
      onSubmitted: (Amount? value) {
        Navigator.pop(this);
        amount = value;
      },
      minAmount: partner.minimumAmountInDecimal,
      currency: Currency.usdc,
      type: RampType.onRamp,
      calculateEquivalent: (amount) =>
          _calculateMoneygramFee(amount: amount, type: RampType.onRamp),
    );

    final submittedAmount = amount;

    if (submittedAmount is! CryptoAmount) return;

    final response = await _generateDepositLink(
      amount: submittedAmount.decimal.toDouble(),
    );

    if (response == null) {
      showCpErrorSnackbar(this, message: l10n.tryAgainLater);

      return;
    }

    final link = response.url;
    final token = response.token;
    final orderId = response.id;

    final id = await sl<OnRampOrderService>()
        .createPendingMoneygram(
      orderId: orderId,
      partner: partner,
      submittedAmount: submittedAmount,
      authToken: token,
    )
        .then((order) {
      switch (order) {
        case Left<Exception, String>():
          return null;
        case Right<Exception, String>(:final value):
          return value;
      }
    });

    if (id == null) {
      showCpErrorSnackbar(this, message: l10n.tryAgainLater);

      return;
    }

    bool orderWasCreated = false;
    Future<void> handleLoaded(InAppWebViewController controller) async {
      controller.addJavaScriptHandler(
        handlerName: 'moneygram',
        callback: (args) async {
          if (orderWasCreated) return;

          final transaction = await _fetchTransactionStatus(
            id: orderId,
            token: token,
          );

          final transferAmount = Amount.fromDecimal(
            value: Decimal.parse(transaction.amountIn ?? '0'),
            currency: Currency.usd,
          ) as FiatAmount;

          final receiveAmount = Amount.fromDecimal(
            value: Decimal.parse(transaction.amountOut ?? '0'),
            currency: Currency.usdc,
          ) as CryptoAmount;

          await sl<OnRampOrderService>()
              .updateMoneygramOrder(
            id: id,
            receiveAmount: receiveAmount,
            transferExpiryDate: DateTime.now().add(const Duration(days: 1)),
            transferAmount: transferAmount,
            authToken: token,
            moreInfoUrl: transaction.moreInfoUrl ?? '',
          )
              .then((order) {
            switch (order) {
              case Left<Exception, void>():
                break;
              case Right<Exception, void>():
                OnRampOrderScreen.pushReplacement(this, id: id);
            }
          });

          orderWasCreated = true;
        },
      );
      await controller.evaluateJavascript(
        source: '''
window.addEventListener("message", (event) => {
  window.flutter_inappwebview.callHandler('moneygram', event.data);
}, false);
''',
      );
    }

    await WebViewScreen.push(
      this,
      url: Uri.parse(link),
      onLoaded: handleLoaded,
      title: l10n.ramp_titleCashIn,
      theme: const CpThemeData.light(),
    );
  }

  Future<void> launchMoneygramOffRamp() async {
    Amount? amount;

    const partner = RampPartner.moneygram;
    const type = RampType.offRamp;

    await RampAmountScreen.push(
      this,
      partner: partner,
      onSubmitted: (Amount? value) async {
        await showConfirmationDialog(
          this,
          title: 'Confirm Withdrawal',
          message:
              'We will be transferring the amount now. If you cancel after, you will be charged a fee. Are you sure you want to proceed?',
          onConfirm: () {
            Navigator.pop(this);
            amount = value;
          },
        );
      },
      minAmount: partner.minimumAmountInDecimal,
      currency: Currency.usdc,
      type: type,
      calculateEquivalent: (amount) =>
          _calculateMoneygramFee(amount: amount, type: type),
    );

    final submittedAmount = amount;

    if (submittedAmount is! CryptoAmount) return;

    final receiveAmount = await runWithLoader<Amount>(
      this,
      () async => _calculateFee(amount: submittedAmount, type: type),
    );

    await sl<OffRampOrderService>()
        .createMoneygramOrder(
      partner: partner,
      submittedAmount: submittedAmount,
      receiveAmount: receiveAmount as FiatAmount,
    )
        .then((order) {
      switch (order) {
        case Left<Exception, String>():
          showCpErrorSnackbar(this, message: l10n.tryAgainLater);

        case Right<Exception, String>(:final value):
          OffRampOrderScreen.push(this, id: value);
      }
    });
  }

  Future<void> openMoneygramWithdrawUrl(OffRampOrder order) async {
    String? withdrawUrl = order.withdrawUrl;

    if (withdrawUrl == null) {
      print(order.receiveAmount?.decimal.toDouble());

      final response = await _generateWithdrawLink(
        amount: 1.0,
      );

      if (response == null) {
        showCpErrorSnackbar(this, message: l10n.tryAgainLater);

        return;
      }

      withdrawUrl = response.url;

      await sl<OffRampOrderService>().updateMoneygramWithdrawUrl(
        id: order.id,
        withdrawUrl: withdrawUrl,
        authToken: response.token,
        orderId: response.id,
      );
    }

    bool orderWasCreated = false;
    Future<void> handleLoaded(InAppWebViewController controller) async {
      controller.addJavaScriptHandler(
        handlerName: 'moneygram',
        callback: (args) async {
          if (orderWasCreated) return;

          final transaction = await _fetchTransactionStatus(
            id: order.partnerOrderId,
            token: order.authToken ?? '',
          );

          final transferAmount = Amount.fromDecimal(
            value: Decimal.parse(transaction.amountIn ?? '0'),
            currency: Currency.usdc,
          ) as CryptoAmount;

          final receiveAmount = Amount.fromDecimal(
            value: Decimal.parse(transaction.amountOut ?? '0'),
            currency: Currency.usd,
          ) as FiatAmount;

          await sl<OffRampOrderService>().updateMoneygramOrder(
            id: order.id,
            receiveAmount: receiveAmount,
            withdrawAnchorAccount: transaction.withdrawAnchorAccount ?? '',
            withdrawMemo: transaction.withdrawMemo ?? '',
            moreInfoUrl: transaction.moreInfoUrl ?? '',
            status: OffRampOrderStatus.depositTxReady,
          );
          orderWasCreated = true;
        },
      );
      await controller.evaluateJavascript(
        source: '''
window.addEventListener("message", (event) => {
  window.flutter_inappwebview.callHandler('moneygram', event.data);
}, false);
''',
      );
    }

    await WebViewScreen.push(
      this,
      url: Uri.parse(withdrawUrl),
      onLoaded: handleLoaded,
      title: l10n.ramp_titleCashOut,
      theme: const CpThemeData.light(),
    );
  }

  // Todo(vsumin): finish refund
  Future<void> openMoneygramMoreInfoUrl(OffRampOrder order) async {
    Future<void> handleLoaded(InAppWebViewController controller) async {
      controller.addJavaScriptHandler(
        handlerName: 'moneygram',
        callback: (args) async {
          final transaction = await _fetchTransactionStatus(
            id: order.partnerOrderId,
            token: order.authToken ?? '',
          );

          final receiveAmount = Amount.fromDecimal(
            value: Decimal.parse(transaction.amountOut ?? '0'),
            currency: Currency.usd,
          ) as FiatAmount;

          await sl<OffRampOrderService>().updateMoneygramOrder(
            id: order.id,
            receiveAmount: receiveAmount,
            withdrawAnchorAccount: transaction.withdrawAnchorAccount ?? '',
            withdrawMemo: transaction.withdrawMemo ?? '',
            moreInfoUrl: transaction.moreInfoUrl ?? '',
            status: OffRampOrderStatus.processingRefund,
          );
        },
      );
      await controller.evaluateJavascript(
        source: '''
window.addEventListener("message", (event) => {
  window.flutter_inappwebview.callHandler('moneygram', event.data);
}, false);
''',
      );
    }

    await WebViewScreen.push(
      this,
      url: Uri.parse(order.moreInfoUrl ?? ''),
      onLoaded: handleLoaded,
      title: l10n.ramp_titleCashOut,
      theme: const CpThemeData.light(),
    );
  }

  Future<TransactionStatus> _fetchTransactionStatus({
    required String id,
    required String token,
  }) =>
      runWithLoader<TransactionStatus>(this, () async {
        final client = sl<MoneygramApiClient>();

        return client
            .fetchTransaction(
              id: id,
              authHeader: token.toAuthHeader(),
            )
            .then((e) => e.transaction);
      });

  Future<MoneygramLink?> _generateDepositLink({required double amount}) =>
      runWithLoader<MoneygramLink?>(this, () async {
        try {
          final wallet = sl<StellarWallet>();
          final stellarClient = sl<StellarClient>();

          final token = await stellarClient.fetchToken(wallet: wallet.keyPair);

          final client = sl<MoneygramApiClient>();

          final response = await client.generateDepositUrl(
            MgWithdrawRequestDto(
              assetCode: 'USDC',
              account: wallet.keyPair.accountId,
              lang: locale.languageCode,
              amount: amount.toString(),
            ),
            token.toAuthHeader(),
          );

          return (id: response.id, url: response.url, token: token);
        } on Exception {
          return null;
        }
      });

  Future<MoneygramLink?> _generateWithdrawLink({required double amount}) =>
      runWithLoader<MoneygramLink?>(this, () async {
        try {
          final wallet = sl<StellarWallet>();
          final stellarClient = sl<StellarClient>();

          final token = await stellarClient.fetchToken(wallet: wallet.keyPair);

          final client = sl<MoneygramApiClient>();

          final response = await client.generateWithdrawUrl(
            MgWithdrawRequestDto(
              assetCode: 'USDC',
              account: wallet.keyPair.accountId,
              lang: locale.languageCode,
              amount: amount.toString(),
            ),
            token.toAuthHeader(),
          );

          return (id: response.id, url: response.url, token: token);
        } on Exception {
          return null;
        }
      });

  Future<Amount> _calculateFee({
    required Amount amount,
    required RampType type,
  }) async {
    final client = sl<EspressoCashClient>();

    final fee = await client.calculateMoneygramFee(
      MoneygramFeeRequestDto(
        type:
            type == RampType.onRamp ? RampTypeDto.onRamp : RampTypeDto.offRamp,
        amount: amount.decimal.toString(),
      ),
    );

    return Amount.fromDecimal(
      value: Decimal.parse(fee.amount),
      currency: type == RampType.onRamp ? Currency.usdc : Currency.usd,
    );
  }

  Future<Either<Exception, ({Amount amount, String? rate})>>
      _calculateMoneygramFee({
    required Amount amount,
    required RampType type,
  }) async {
    final fee = await _calculateFee(
      amount: amount,
      type: type,
    );

    return Either.right((amount: fee, rate: null));
  }
}
