import 'package:auto_route/auto_route.dart';
import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../../../core/amount.dart';
import '../../../../../core/currency.dart';
import '../../../../../di.dart';
import '../../../../../l10n/l10n.dart';
import '../../../../../ui/loader.dart';
import '../../../../../ui/snackbar.dart';
import '../../../../../ui/web_view_screen.dart';
import '../../../data/on_ramp_order_service.dart';
import '../../../models/ramp_partner.dart';
import '../../../screens/off_ramp_order_screen.dart';
import '../../../services/off_ramp_order_service.dart';
import '../../models/profile_data.dart';
import '../../models/ramp_type.dart';

extension BuildContextExt on BuildContext {
  Future<void> launchScalexRamp({
    required String address,
    required ProfileData profile,
    required RampType type,
  }) async {
    final link = await _generateRampLink(
      address: address,
      profile: profile,
      type: type,
    );

    if (link == null) {
      showCpErrorSnackbar(
        this,
        message: l10n.tryAgainLater,
      );

      return;
    }

    bool orderWasCreated = false;
    Future<void> handleLoaded(InAppWebViewController controller) async {
      controller.addJavaScriptHandler(
        handlerName: 'scalex',
        callback: (args) async {
          if (orderWasCreated) return;

          if (type == RampType.onRamp) {
            if (args.firstOrNull
                case <String, dynamic>{
                  'reference': final String reference,
                  'to_amount': final num toAmount,
                }) {
              final decimal = Decimal.parse(toAmount.toString());
              final amount =
                  Amount.fromDecimal(value: decimal, currency: Currency.usdc)
                      as CryptoAmount;

              await sl<OnRampOrderService>().create(
                orderId: reference,
                receiveAmount: amount,
                partner: RampPartner.scalex,
              );
              orderWasCreated = true;
            }
          }

          if (type == RampType.offRamp) {
            if (args.firstOrNull
                case <String, dynamic>{
                  'reference': final String reference,
                  'from_amount': final num fromAmount,
                  // ignore: avoid-missing-interpolation, similar names
                  'address': final String address,
                }) {
              final decimal = Decimal.parse(fromAmount.toString());
              final amount =
                  Amount.fromDecimal(value: decimal, currency: Currency.usdc)
                      as CryptoAmount;

              await sl<OffRampOrderService>()
                  .create(
                partnerOrderId: reference,
                amount: amount,
                partner: RampPartner.scalex,
                depositAddress: address,
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
          }
        },
      );
      await controller.evaluateJavascript(
        source: '''
window.addEventListener("message", (event) => {
  window.flutter_inappwebview.callHandler('scalex', event.data);
}, false);
''',
      );
    }

    await router.push(
      WebViewScreen.route(
        url: Uri.parse(link),
        onLoaded: handleLoaded,
      ),
    );
  }

  Future<String?> _generateRampLink({
    required String address,
    required ProfileData profile,
    required RampType type,
  }) =>
      runWithLoader<String?>(this, () async {
        try {
          final client = sl<ScalexApiClient>();

          return await client
              .generateIFrameUrl(
                GenerateIFrameBodyDto(
                  type: type == RampType.onRamp ? 'onramp' : 'offramp',
                  address: address,
                  email: profile.email,
                  token: 'USDC',
                  network: 'SOLANA',
                ),
              )
              .letAsync((p) => p.data.link);
        } on Exception {
          return null;
        }
      });
}
