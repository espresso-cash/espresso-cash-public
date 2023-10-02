import 'package:auto_route/auto_route.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../../../config.dart';
import '../../../../../core/amount.dart';
import '../../../../../core/currency.dart';
import '../../../../../di.dart';
import '../../../../../ui/web_view_screen.dart';
import '../../../data/on_ramp_order_service.dart';
import '../../models/profile_data.dart';
import '../../models/ramp_type.dart';
import '../../screens/ramp_amount_screen.dart';

extension BuildContextExt on BuildContext {
  Future<void> launchKadoOnRamp({
    required String address,
    required ProfileData profile,
  }) async {
    Amount? amount;

    await router.push(
      RampAmountScreen.route(
        onSubmitted: (value) {
          router.pop();
          amount = value;
        },
        minAmount: Decimal.fromInt(30),
        currency: Currency.usdc,
        calculateEquivalent: null,
        type: RampType.onRamp,
      ),
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
                .create(orderId: orderId, amount: submittedAmount);
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

    await router.push(WebViewScreen.route(url: uri, onLoaded: handleLoaded));
  }
}
