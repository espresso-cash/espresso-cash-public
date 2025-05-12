import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:ec_client_dart/ec_client_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:sealed_countries/sealed_countries.dart' as country;

import '../../../../../di.dart';
import '../../../../../l10n/device_locale.dart';
import '../../../../../l10n/l10n.dart';
import '../../../../../ui/dialogs.dart';
import '../../../../../ui/loader.dart';
import '../../../../../ui/snackbar.dart';
import '../../../../../ui/theme.dart';
import '../../../../../ui/web_view_screen.dart';
import '../../../../../utils/errors.dart';
import '../../../../currency/models/amount.dart';
import '../../../../currency/models/currency.dart';
import '../../../../ramp_partner/models/ramp_partner.dart';
import '../../../../ramp_partner/models/ramp_type.dart';
import '../../../../stellar/models/stellar_wallet.dart';
import '../../../../stellar/service/stellar_client.dart';
import '../../../models/profile_data.dart';
import '../../../screens/off_ramp_order_screen.dart';
import '../../../screens/on_ramp_order_screen.dart';
import '../../../screens/ramp_amount_screen.dart';
import '../data/dto.dart';
import '../data/moneygram_client.dart';
import '../service/moneygram_fees_service.dart';
import '../service/moneygram_off_ramp_service.dart';
import '../service/moneygram_on_ramp_service.dart';
import 'style.dart';

typedef MoneygramLink = ({String id, String url, String token});

extension BuildContextExt on BuildContext {
  Future<void> launchMoneygramOnRamp({required ProfileData profile}) async {
    CryptoAmount? amount;

    const partner = RampPartner.moneygram;
    const type = RampType.onRamp;

    const inputCurrency = Currency.usdc;
    final receiveCurrency = _fromCountryCode(profile.country.code);

    final rate = await _getExchangeRate(to: receiveCurrency);
    if (rate == null) {
      showCpErrorSnackbar(this, message: l10n.tryAgainLater);

      return;
    }
    final isEstimatedRate = receiveCurrency.symbol != Currency.usd.symbol;

    await RampAmountScreen.push(
      this,
      partner: partner,
      onSubmitted: (Amount? value) {
        Navigator.pop(this);
        // ignore: avoid-type-casts, controlled type
        amount = value as CryptoAmount?;
      },
      minAmount: partner.minimumAmountInDecimal,
      currency: inputCurrency,
      receiveCurrency: receiveCurrency,
      type: type,
      calculateEquivalent:
          (amount) => _calculateReceiveAmount(
            amount: amount,
            type: type,
            currency: receiveCurrency,
            rate: rate,
          ),
      calculateFee:
          (amount) =>
              _calculateFees(amount: amount, type: type, currency: receiveCurrency, rate: rate),
      exchangeRate: _formatExchangeRate(from: inputCurrency, to: receiveCurrency, rate: rate),
      isEstimatedRate: isEstimatedRate,
    );

    final submittedAmount = amount;

    if (submittedAmount == null) return;

    final submittedAmountInUsdc = CryptoAmount(
      value: inputCurrency.decimalToInt(submittedAmount.decimal),
      cryptoCurrency: inputCurrency,
    );

    final fees = await runWithLoader<MoneygramFees>(
      this,
      () => sl<MoneygramFeesService>().fetchFees(amount: submittedAmount, type: type),
    );

    // ignore: avoid-type-casts, controlled type
    final depositAmount = fees.receiveAmount.convert(rate: rate, to: receiveCurrency) as FiatAmount;

    final bridgeAmountInUsdc = submittedAmountInUsdc + fees.bridgeFee;

    final response = await _generateDepositLink(amount: bridgeAmountInUsdc.decimal.toDouble());

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
          submittedAmount: depositAmount,
          authToken: token,
          receiveAmount: submittedAmount,
          countryCode: profile.country.code,
          // ignore: avoid-type-casts, controlled type
          bridgeAmount: bridgeAmountInUsdc as CryptoAmount,
        )
        .then(
          (order) => switch (order) {
            Left<Exception, String>() => null,
            Right<Exception, String>(:final value) => value,
          },
        );

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
      title: l10n.ramp_titleCashIn.toUpperCase(),
      theme: const CpThemeData.light(),
    );

    if (!orderWasCreated) {
      await sl<MoneygramOnRampOrderService>().updateMoneygramOrder(id: id);
    }
  }

  Future<void> launchMoneygramOffRamp({required ProfileData profile}) async {
    Amount? amount;

    const partner = RampPartner.moneygram;
    const type = RampType.offRamp;

    const inputCurrency = Currency.usdc;
    final receiveCurrency = _fromCountryCode(profile.country.code);

    final rate = await _getExchangeRate(to: receiveCurrency);
    if (rate == null) {
      showCpErrorSnackbar(this, message: l10n.tryAgainLater);

      return;
    }
    final isEstimatedRate = receiveCurrency.symbol != Currency.usd.symbol;

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
      currency: inputCurrency,
      receiveCurrency: receiveCurrency,
      type: type,
      calculateEquivalent:
          (amount) => _calculateReceiveAmount(
            amount: amount,
            type: type,
            currency: receiveCurrency,
            rate: rate,
          ),
      calculateFee:
          (amount) =>
              _calculateFees(amount: amount, type: type, currency: receiveCurrency, rate: rate),
      exchangeRate: _formatExchangeRate(from: inputCurrency, to: receiveCurrency, rate: rate),
      isEstimatedRate: isEstimatedRate,
    );

    final submittedAmount = amount;

    if (submittedAmount is! CryptoAmount) return;

    final fees = await runWithLoader<MoneygramFees>(
      this,
      () => sl<MoneygramFeesService>().fetchFees(amount: submittedAmount, type: type),
    );

    final priorityFee = fees.priorityFee;
    if (priorityFee == null) {
      showCpErrorSnackbar(this, message: l10n.tryAgainLater);

      return;
    }

    final receiveAmount = fees.receiveAmount.convert(rate: rate, to: receiveCurrency);

    await sl<MoneygramOffRampOrderService>()
        .createMoneygramOrder(
          submittedAmount: submittedAmount,
          // ignore: avoid-type-casts, controlled type
          receiveAmount: receiveAmount as FiatAmount,
          countryCode: profile.country.code,
          priorityFee: priorityFee,
          // ignore: avoid-type-casts, controlled type
          gasFee: fees.gasFeeInUsdc as CryptoAmount,
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
        } on Exception catch (error) {
          reportError(error);

          return null;
        }
      });

  Future<Either<Exception, Amount>> _calculateReceiveAmount({
    required Amount amount,
    required RampType type,
    required Currency currency,
    required Decimal rate,
  }) async {
    final fees = await sl<MoneygramFeesService>().fetchFees(amount: amount, type: type);

    final receiveAmount = fees.receiveAmount;

    return Either.right(
      receiveAmount.currency != currency
          ? receiveAmount.convert(rate: rate, to: currency)
          : receiveAmount,
    );
  }

  Future<Either<Exception, RampFees>> _calculateFees({
    required Amount amount,
    required RampType type,
    required Currency currency,
    required Decimal rate,
  }) async {
    final fees = await sl<MoneygramFeesService>().fetchFees(amount: amount, type: type);

    final totalFees = switch (type) {
      RampType.onRamp => fees.bridgeFee + fees.moneygramFee,
      RampType.offRamp => fees.moneygramFee + fees.bridgeFee + fees.gasFeeInUsdc,
    };

    final convertedTotalFees =
        totalFees.currency != currency ? totalFees.convert(rate: rate, to: currency) : totalFees;

    return Either.right((
      ourFee: null,
      partnerFee: null,
      extraFee: null,
      totalFee: convertedTotalFees,
    ));
  }

  Future<Decimal?> _getExchangeRate({required Currency to}) =>
      runWithLoader<Decimal?>(this, () async {
        try {
          final rates = await sl<EspressoCashClient>()
              .fetchFiatRate(FiatRateRequestDto(base: Currency.usd.symbol, target: to.symbol))
              .then((rates) => rates.rate);

          return Decimal.parse(rates.toString());
        } on Exception catch (error) {
          reportError(error);

          return null;
        }
      });

  String _formatExchangeRate({
    required Currency from,
    required Currency to,
    required Decimal rate,
  }) {
    final symbol = to.symbol == Currency.usd.symbol ? '=' : '≈';

    return '1 ${from.symbol} $symbol ${rate.toStringAsFixed(2)} ${to.symbol}';
  }

  FiatCurrency _fromCountryCode(String code) {
    final currency = country.WorldCountry.fromCodeShort(code).currencies?.firstOrNull;

    return currency.toFiatCurrency.copyWith(countryCode: code);
  }
}
