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
import '../../../../conversion_rates/widgets/extensions.dart';
import '../../../../currency/models/amount.dart';
import '../../../../currency/models/currency.dart';
import '../../../../ramp_partner/models/ramp_partner.dart';
import '../../../../stellar/models/stellar_wallet.dart';
import '../../../../stellar/service/stellar_client.dart';
import '../../../models/ramp_type.dart';
import '../../../screens/on_ramp_order_screen.dart';
import '../../../screens/ramp_amount_screen.dart';
import '../data/dto.dart';
import '../data/moneygram_client.dart';
import '../service/moneygram_on_ramp_service.dart';
import 'style.dart';

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
      calculateEquivalent: (amount) => _calculateFees(
        amount: amount,
        type: RampType.onRamp,
      ),
      partnerFeeLabel: 'Fee taken during bridging',
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

    final id = await sl<MoneygramOnRampOrderService>()
        .createPendingMoneygram(
      orderId: orderId,
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
      await controller.evaluateJavascript(source: await loadMoneygramStyle());

      controller.addJavaScriptHandler(
        handlerName: 'moneygram',
        callback: (args) async {
          if (orderWasCreated) return;
          orderWasCreated = true;

          OnRampOrderScreen.pushReplacement(this, id: id);
          await sl<MoneygramOnRampOrderService>().updateMoneygramOrder(id: id);
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

    if (!orderWasCreated) {
      await sl<MoneygramOnRampOrderService>().updateMoneygramOrder(id: id);
    }
  }

  Future<MoneygramLink?> _generateDepositLink({required double amount}) =>
      runWithLoader<MoneygramLink?>(this, () async {
        try {
          final wallet = sl<StellarWallet>();
          final stellarClient = sl<StellarClient>();

          final token = await stellarClient.fetchToken();

          final client = sl<MoneygramApiClient>();

          final response = await client.generateDepositUrl(
            MgWithdrawRequestDto(
              assetCode: 'USDC',
              account: wallet.keyPair.accountId,
              lang: locale.languageCode,
              amount: amount.toString(),
            ),
            token,
          );

          final url = '${response.url}&callback=postmessage';

          return (id: response.id, url: url, token: token);
        } on Exception {
          return null;
        }
      });

  Future<Either<Exception, ({Amount amount, String? rate})>> _calculateFees({
    required Amount amount,
    required RampType type,
  }) async {
    final client = sl<EspressoCashClient>();

    final allbridgeFee = await client.calculateMoneygramFee(
      MoneygramFeeRequestDto(
        type:
            type == RampType.onRamp ? RampTypeDto.onRamp : RampTypeDto.offRamp,
        amount: amount.decimal.toString(),
      ),
    );

    final moneygramFee = _calculateMoneyGramFee(amount);

    return Either.right(
      (
        amount: Amount.fromDecimal(
          value: Decimal.parse(allbridgeFee.amount),
          currency: Currency.usdc,
        ),
        rate: 'You will pay ${moneygramFee.format(locale)} USDC'
      ),
    );
  }
}

// Based on fee table sent by MoneyGram
Amount _calculateMoneyGramFee(Amount input) {
  final amount = input.decimal.toDouble();

  double feeAmount;

  if (amount < 1) {
    throw ArgumentError('Invalid transaction amount');
  } else if (amount <= 99) {
    feeAmount = 2.0;
  } else if (amount <= 999) {
    feeAmount = 2.0 + 0.01 * amount;
  } else {
    feeAmount = 10.0 + 0.005 * amount;
  }

  final total = amount + feeAmount;

  return Amount.fromDecimal(
    value: Decimal.parse(total.toString()),
    currency: Currency.usd,
  );
}
