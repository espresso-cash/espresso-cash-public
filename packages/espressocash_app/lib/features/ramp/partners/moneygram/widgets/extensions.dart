import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../../../di.dart';
import '../../../../../l10n/device_locale.dart';
import '../../../../../l10n/l10n.dart';
import '../../../../../ui/loader.dart';
import '../../../../../ui/snackbar.dart';
import '../../../../../ui/theme.dart';
import '../../../../../ui/web_view_screen.dart';
import '../../../services/off_ramp_order_service.dart';
import '../service/moneygram_off_ramp_service.dart';

extension BuildContextExt on BuildContext {
  Future<void> openMoneygramWithdrawUrl(OffRampOrder order) async {
    final withdrawUrl = await runWithLoader<String?>(
      this,
      () async => sl<MoneygramOffRampOrderService>()
          .getWithdrawUrl(order: order, languageCode: locale.languageCode),
    );

    if (withdrawUrl == null) {
      showCpErrorSnackbar(this, message: l10n.tryAgainLater);

      return;
    }

    bool orderWasCreated = false;
    Future<void> handleLoaded(InAppWebViewController controller) async {
      controller.addJavaScriptHandler(
        handlerName: 'moneygram',
        callback: (args) async {
          if (orderWasCreated) return;

          orderWasCreated = true;

          Navigator.pop(this);
          await sl<MoneygramOffRampOrderService>().updateMoneygramOrder(
            id: order.id,
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
      url: Uri.parse(withdrawUrl),
      onLoaded: handleLoaded,
      title: l10n.offRampWithdrawTitle.toUpperCase(),
      theme: const CpThemeData.light(),
    );

    if (!orderWasCreated) {
      await sl<MoneygramOffRampOrderService>().updateMoneygramOrder(
        id: order.id,
      );
    }
  }

  Future<void> openMoneygramMoreInfoUrl(OffRampOrder order) async {
    await WebViewScreen.push(
      this,
      url: Uri.parse(order.moreInfoUrl ?? ''),
      title: l10n.offRampWithdrawTitle.toUpperCase(),
      theme: const CpThemeData.light(),
    );

    await sl<MoneygramOffRampOrderService>().processRefund(order.id);
  }
}
