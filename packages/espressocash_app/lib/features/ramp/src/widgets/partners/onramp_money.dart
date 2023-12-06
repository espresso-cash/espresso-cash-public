import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';

import '../../../../../config.dart';
import '../../../../../core/amount.dart';
import '../../../../../core/currency.dart';
import '../../../../../di.dart';
import '../../../../../l10n/l10n.dart';
import '../../../../../ui/loader.dart';
import '../../../../../ui/snackbar.dart';
import '../../../../../ui/web_view_screen.dart';
import '../../../../accounts/models/account.dart';
import '../../../data/on_ramp_order_service.dart';
import '../../../models/ramp_partner.dart';
import '../../../onramp_money/data/orm_repository.dart';
import '../../../screens/off_ramp_order_screen.dart';
import '../../../services/off_ramp_order_service.dart';
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
            // 'appId': onrampMoneyAppId,
            // 'network': 'SPL',
            // 'coinCode': 'USDC',
            // 'walletAddress': address,
            'flowType': 1,
            'coinAmount': submittedAmount.decimal.toDouble(),
            //dev mode below
            'appId': '2',
            'network': 'MATIC20-TEST',
            'coinCode': 'usdt',
            'walletAddress': '0x028b06Bc8A1E6717BDe9AADB39F027a386977856',
            'todo_remove_me': address, //TODO
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

  Future<void> launchOnRampMoneyOffRamp({
    required String address,
  }) async {
    // final res = await _generateToken(address: address, quantity: 100);

    // print(res);

    // return;

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

    final token = await _generateToken(
      address: address,
      quantity: submittedAmount.decimal.toDouble().toString(),
    );

    if (token == null) {
      showCpErrorSnackbar(
        this,
        message: l10n.tryAgainLater,
      );

      return;
    }

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
            // 'appId': onrampMoneyAppId,
            // 'network': 'SPL',
            // 'coinCode': 'USDC',
            // 'walletAddress': address,
            'flowType': 2,
            'authToken': token,
            'coinAmount': submittedAmount.decimal.toDouble(),
            //dev mode below
            'appId': '2',
            'network': 'MATIC20-TEST',
            'coinCode': 'usdt',
            'walletAddress': '0x028b06Bc8A1E6717BDe9AADB39F027a386977856',
            'todo_remove_me': address, //TODO
          },
        );

        hasLoaded = true;
      }

      controller.addJavaScriptHandler(
        handlerName: 'onramp',
        callback: (args) async {
          if (args.firstOrNull
              case <String, dynamic>{
                'type': 'ONRAMP_WIDGET_TX_FINDING', //TODO
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

            await sl<OffRampOrderService>()
                .create(
              partnerOrderId: orderId.toString(),
              amount: amount, //TODO reconfirm
              // receiveAmount: amount,
              depositAddress: 'address', //TODO
              partner: RampPartner.onrampMoney,
            )
                .then((order) {
              switch (order) {
                case Left<Exception, String>():
                  break;
                case Right<Exception, String>(:final value):
                  router.replace(OffRampOrderScreen.route(orderId: value));
              }
            });

            orderWasCreated = true;
          }

          if (args.firstOrNull
              case <String, dynamic>{
                'type': 'ONRAMP_WIDGET_CLOSE_REQUEST_CONFIRMED',
              }) {
            await router.pop();
          }
        },
      );
    }

    await router.push(WebViewScreen.route(url: blank, onLoaded: handleLoaded));
  }

  Future<String?> _generateToken({
    required String address,
    required String quantity,
  }) =>
      runWithLoader<String?>(this, () async {
        try {
          final client = sl<OrmRepository>();

          final date = DateTime.now();
          final message =
              'This is my address $address. I am signing it at ${date.millisecondsSinceEpoch}';

          final wallet = read<MyAccount>().wallet;

          final signedMessage = await wallet.sign([utf8.encode(message)]).then(
            (it) => base64Encode(it.first.bytes),
          );

          return await client.generateAuthToken(
            message: message,
            signedMessage: signedMessage,
            walletAddress: address,
            timestamp: date,
            quantity: quantity,
            appId: onrampMoneyAppId,
          );
        } on Exception {
          return null;
        }
      });
}
