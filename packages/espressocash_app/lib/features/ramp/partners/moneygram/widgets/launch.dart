import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../../../di.dart';
import '../../../../../l10n/device_locale.dart';
import '../../../../../l10n/l10n.dart';
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
      calculateEquivalent: (amount) => _calculateMoneygramFee(amount: amount),
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

    await RampAmountScreen.push(
      this,
      partner: partner,
      onSubmitted: (Amount? value) {
        Navigator.pop(this);
        amount = value;
      },
      minAmount: partner.minimumAmountInDecimal,
      currency: Currency.usdc,
      type: RampType.offRamp,
      calculateEquivalent: (amount) => _calculateMoneygramFee(amount: amount),
    );

    final submittedAmount = amount;

    if (submittedAmount is! CryptoAmount) return;

    final response = await _generateWithdrawLink(
      amount: submittedAmount.decimal.toDouble(),
    );

    if (response == null) {
      showCpErrorSnackbar(this, message: l10n.tryAgainLater);

      return;
    }

    final link = response.url;
    final token = response.token;
    final orderId = response.id;

    final id = await sl<OffRampOrderService>()
        .createMoneygramOrder(
      orderId: orderId,
      partner: partner,
      submittedAmount: submittedAmount,
      authToken: token,
      // url store id db , and be able to open it in transaction screen
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

          await sl<OffRampOrderService>()
              .updateMoneygramOrder(
            id: id,
            receiveAmount: receiveAmount,
            transferAmount: transferAmount,
            depositAddress: transaction.withdrawAnchorAccount ?? '',
            withdrawMemo: transaction.withdrawMemo ?? '',
            withdrawUrl: link,
            moreInfoUrl: transaction.moreInfoUrl ?? '',         
          )
              .then((order) {
            switch (order) {
              case Left<Exception, void>():
                break;
              case Right<Exception, void>():
                OffRampOrderScreen.pushReplacement(this, id: id);
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

  Future<({String id, String url, String token})?> _generateDepositLink({
    required double amount,
  }) =>
      runWithLoader<({String id, String url, String token})?>(this, () async {
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

  Future<({String id, String url, String token})?> _generateWithdrawLink({
    required double amount,
  }) =>
      runWithLoader<({String id, String url, String token})?>(this, () async {
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

  Future<Either<Exception, ({Amount amount, String? rate})>>
      _calculateMoneygramFee({required Amount amount}) async {
    final client = sl<EspressoCashClient>();

    final fee = await client.calculateMoneygramFee(
      MoneygramFeeRequestDto(
        amount: amount.decimal.toString(),
      ),
    );

    return Either.right(
      (
        amount: Amount.fromDecimal(
          value: Decimal.parse(fee.amount),
          currency: Currency.usdc,
        ),
        rate: null
      ),
    );
  }
}
