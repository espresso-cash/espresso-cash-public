import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../../../di.dart';
import '../../../../../l10n/device_locale.dart';
import '../../../../../l10n/l10n.dart';
import '../../../../../ui/loader.dart';
import '../../../../../ui/snackbar.dart';
import '../../../../../ui/theme.dart';
import '../../../../../ui/web_view_screen.dart';
import '../../../../accounts/models/stellar_wallet.dart';
import '../../../../currency/models/amount.dart';
import '../../../../currency/models/currency.dart';
import '../../../../ramp_partner/models/ramp_partner.dart';
import '../../../../stellar/service/stellar_client.dart';
import '../../../models/ramp_type.dart';
import '../../../screens/ramp_amount_screen.dart';
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

    final client = sl<MoneygramApiClient>();

    bool orderWasCreated = false;
    Future<void> handleLoaded(InAppWebViewController controller) async {
      controller.addJavaScriptHandler(
        handlerName: 'moneygram',
        callback: (args) async {
          if (orderWasCreated) return;

          print('args: $args');

          final transaction = args.first as Map<String, dynamic>;

          final id = transaction['transaction']['id'] as String;

          print('id: $id');

          print('matches with orderId: ${id == orderId}');

          final response = await client.fetchTransaction(
            id: id,
            authHeader: token.toAuthHeader(),
          );

          print(response);

          // await sl<OnRampOrderService>()
          //     .createForManualTransfer(
          //   orderId: link,
          //   receiveAmount: amount,
          //   partner: partner,
          //   bankAccount: 'details.bankAccount',
          //   bankName: 'details.bankName',
          //   transferAmount: transferAmount,
          //   transferExpiryDate: DateTime.now().add(const Duration(days: 1)),
          // )
          //     .then((order) {
          //   switch (order) {
          //     case Left<Exception, String>():
          //       break;
          //     case Right<Exception, String>(:final value):
          //       OnRampOrderScreen.pushReplacement(this, id: value);
          //   }
          // });
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
}
