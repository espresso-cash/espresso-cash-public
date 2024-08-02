import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../../../config.dart';
import '../../../../../di.dart';
import '../../../../../l10n/l10n.dart';
import '../../../../../ui/web_view_screen.dart';
import '../../../../currency/models/amount.dart';
import '../../../../currency/models/currency.dart';
import '../../../../ramp_partner/models/ramp_partner.dart';
import '../../../models/profile_data.dart';
import '../../../models/ramp_type.dart';
import '../../../screens/off_ramp_order_screen.dart';
import '../../../screens/on_ramp_order_screen.dart';
import '../../../screens/ramp_amount_screen.dart';
import '../../../services/off_ramp_order_service.dart';
import '../../../services/on_ramp_order_service.dart';
import '../data/kado_api_client.dart';

extension BuildContextExt on BuildContext {
  Future<void> launchKadoOnRamp({
    required String address,
    required ProfileData profile,
  }) async {
    Amount? amount;

    await RampAmountScreen.push(
      this,
      partner: RampPartner.kado,
      onSubmitted: (Amount? value) {
        Navigator.pop(this);
        amount = value;
      },
      minAmount: Decimal.fromInt(10),
      currency: Currency.usdc,
      type: RampType.onRamp,
    );

    final submittedAmount = amount;
    if (submittedAmount is! CryptoAmount) return;

    final uri = Uri.parse(kadoBaseUrl).replace(
      queryParameters: {
        'apiKey': kadoApiKey,
        'cryptoList': ['USDC'],
        'networkList': ['SOLANA'],
        'network': 'SOLANA',
        'onRevCurrency': 'USDC',
        'theme': 'light',
        'productList': ['BUY'],
        'mode': 'minimal',
        'onToAddress': address,
        'onPayCurrency': 'USD',
        'onPayAmount': '${submittedAmount.decimal}',
        'email': profile.email,
      },
    );

    bool orderWasCreated = false;
    Future<void> handleLoaded(InAppWebViewController controller) async {
      controller.addJavaScriptHandler(
        handlerName: 'kado',
        callback: (args) {
          if (orderWasCreated) return;

          if (args.firstOrNull
              case <String, dynamic>{
                'type': 'RAMP_ORDER_ID',
                'payload': {'orderId': final String orderId}
              }) {
            sl<OnRampOrderService>()
                .create(
              orderId: orderId,
              submittedAmount: submittedAmount,
              partner: RampPartner.kado,
            )
                .then((order) {
              switch (order) {
                case Left<Exception, String>():
                  break;
                case Right<Exception, String>(:final value):
                  OnRampOrderScreen.pushReplacement(this, id: value);
              }
            });
            orderWasCreated = true;
          }
        },
      );
      await controller.evaluateJavascript(
        source: '''
window.addEventListener("message", (event) => {
  window.flutter_inappwebview.callHandler('kado', event.data);
}, false);
''',
      );
    }

    await WebViewScreen.push(
      this,
      url: uri,
      onLoaded: handleLoaded,
      title: l10n.ramp_titleCashIn.toUpperCase(),
      theme: null,
    );
  }

  Future<void> launchKadoOffRamp({
    required String address,
    required ProfileData profile,
  }) async {
    Amount? amount;

    await RampAmountScreen.push(
      this,
      partner: RampPartner.kado,
      onSubmitted: (Amount? value) {
        Navigator.pop(this);
        amount = value;
      },
      minAmount: Decimal.fromInt(10),
      currency: Currency.usdc,
      type: RampType.onRamp,
    );

    final submittedAmount = amount;
    if (submittedAmount is! CryptoAmount) return;

    final uri = Uri.parse(kadoBaseUrl).replace(
      queryParameters: {
        'apiKey': kadoApiKey,
        'cryptoList': ['USDC'],
        'networkList': ['SOLANA'],
        'network': 'SOLANA',
        'offRevCurrency': 'USD',
        'theme': 'light',
        'product': 'SELL',
        'productList': ['SELL'],
        'mode': 'minimal',
        'offFromAddress': address,
        'offPayCurrency': 'USDC',
        'offPayAmount': '${submittedAmount.decimal}',
        'email': profile.email,
      },
    );

    bool orderWasCreated = false;
    Future<void> handleLoaded(InAppWebViewController controller) async {
      controller.addJavaScriptHandler(
        handlerName: 'kado',
        callback: (args) async {
          if (orderWasCreated) return;

          if (args.firstOrNull
              case <String, dynamic>{
                'type': 'RAMP_ORDER_ID',
                'payload': {'orderId': final String orderId}
              }) {
            final partnerOrder =
                await sl<KadoApiClient>().getOrderStatus(orderId);
            final depositAddress = partnerOrder.data?.depositAddress;

            if (depositAddress == null) return;

            await sl<OffRampOrderService>()
                .create(
              partnerOrderId: orderId,
              amount: submittedAmount,
              partner: RampPartner.kado,
              depositAddress: depositAddress,
            )
                .then((order) {
              switch (order) {
                case Left<Exception, String>():
                  break;
                case Right<Exception, String>(:final value):
                  OffRampOrderScreen.pushReplacement(this, id: value);
              }
            });
            orderWasCreated = true;
          }
        },
      );
      await controller.evaluateJavascript(
        source: '''
window.addEventListener("message", (event) => {
  window.flutter_inappwebview.callHandler('kado', event.data);
}, false);
''',
      );
    }

    await WebViewScreen.push(
      this,
      url: uri,
      onLoaded: handleLoaded,
      title: l10n.ramp_btnCashOut,
      theme: null,
    );
  }
}
