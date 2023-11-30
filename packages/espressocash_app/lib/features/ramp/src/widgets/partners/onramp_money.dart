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
  Future<void> launchOnRampMoneyOnRamp({
    required String address,
  }) async {
    Amount? amount;

    await router.push(
      RampAmountScreen.route(
        onSubmitted: (value) {
          router.pop();
          amount = value;
        },
        minAmount: Decimal.fromInt(10),
        currency: Currency.usdc,
        calculateEquivalent: null,
        type: RampType.onRamp,
      ),
    );

    final submittedAmount = amount;
    if (submittedAmount is! CryptoAmount) return;

    final blank = Uri.parse('about:blank');

    const bool orderWasCreated = false;
    bool hasLoaded = false;

    Future<void> handleLoaded(InAppWebViewController controller) async {
      if (!hasLoaded) {
        await controller.loadFile(
          assetFilePath: 'assets/html/onramp_money.html',
        );

        controller.addJavaScriptHandler(
          handlerName: 'init',
          callback: (args) => {
            // 'appId': '2', //TODO appId from config
            // 'network': 'SPL',
            // 'coinCode': 'USDC',
            'walletAddress': address,
            'flowType': 1,
            'coinAmount': submittedAmount.decimal.toBigInt().toInt(),
            'appId': '2',
            'network': 'MATIC20-TEST',
            'coinCode': 'usdt',
          },
        );

        hasLoaded = true;
      }

      controller.addJavaScriptHandler(
        handlerName: 'onramp',
        callback: (args) {
          print('$args');

          if (args.firstOrNull
              case <String, dynamic>{
                'type': 'ONRAMP_WIDGET_READY',
              }) {
            print('ready');
          }

          if (args.firstOrNull
              case <String, dynamic>{
                'type': 'ONRAMP_WIDGET_CLOSE_REQUEST_CONFIRMED',
              }) {
            router.pop();
          }
        },
      );
    }

    await router.push(WebViewScreen.route(url: blank, onLoaded: handleLoaded));
  }
}
