import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

import '../../../../core/analytics/analytics_manager.dart';
import '../../../../core/dynamic_links_notifier.dart';
import '../../../../core/tip_payments.dart';
import '../../../../di.dart';
import '../../../../ui/colors.dart';
import '../../../../ui/loader.dart';
import '../../../../ui/theme.dart';
import '../../module.dart';

class TipReadyScreen extends StatefulWidget {
  const TipReadyScreen({super.key, required this.onCancel});

  final VoidCallback onCancel;

  @override
  State<TipReadyScreen> createState() => _TipReadyScreenState();
}

class _TipReadyScreenState extends State<TipReadyScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.watch<DynamicLinksNotifier>().processLink((link) {
      final tip = TipPaymentData.tryParse(link);

      if (tip != null) {
        sl<AnalyticsManager>().tipLinkReceived();

        try {
          context.processIT(tip);
        } on Object {
          context.router.popForced();
        }

        return true;
      }

      return false;
    });
  }

  @override
  Widget build(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            extendBodyBehindAppBar: true,
            body: CpTheme.dark(
              child: Builder(
                builder: (context) => const DecoratedBox(
                  decoration: BoxDecoration(color: CpColors.primaryColor),
                  child: Center(
                    child: LoadingIndicator(),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}

Future<Wallet> walletFromKey({
  required String encodedKey,
}) async {
  final key = ByteArray.fromBase58(encodedKey).toList();

  return Wallet.fromPrivateKeyBytes(privateKey: key);
}
