import 'package:auto_route/auto_route.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../../../core/amount.dart';
import '../../../../../core/currency.dart';
import '../../../../../di.dart';
import '../../../../../ui/web_view_screen.dart';
import '../../../data/on_ramp_order_service.dart';
import '../../../models/ramp_partner.dart';
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

    bool orderWasCreated = false;
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
            // 'walletAddress': address,
            'todo_remove_me': address,
            'flowType': 1,
            'coinAmount': submittedAmount.decimal.toDouble(),
            //dev mode below
            'appId': '2',
            'network': 'MATIC20-TEST',
            'coinCode': 'usdt',
            'walletAddress': '0x028b06Bc8A1E6717BDe9AADB39F027a386977856',
          },
        );

        hasLoaded = true;
      }

      controller.addJavaScriptHandler(
        handlerName: 'onramp',
        callback: (args) {
          if (args.firstOrNull
              case <String, dynamic>{
                'type': 'ONRAMP_WIDGET_TX_FINDING',
                'data': {
                  'orderId': final int orderId,
                  'cryptoAmount': final num cryptoAmount,
                }
              }) {
            if (orderWasCreated) return;

            final value = Decimal.parse(cryptoAmount.toString());

            final amount = submittedAmount.copyWith(
              value: submittedAmount.currency.decimalToInt(value),
            );

            sl<OnRampOrderService>().create(
              orderId: orderId.toString(),
              receiveAmount: amount,
              partner: RampPartner.onrampMoney,
            );
            orderWasCreated = true;
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
