import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../../gen/assets.gen.dart';
import '../../../l10n/device_locale.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/button.dart';
import '../../../ui/colors.dart';
import '../../conversion_rates/widgets/extensions.dart';
import '../models/recovery_state.dart';
import '../service/recovery_service.dart';

class RecoverStellarScreen extends StatelessWidget {
  const RecoverStellarScreen({super.key, required this.onConfirmed});

  final VoidCallback onConfirmed;

  static void push(BuildContext context, {required VoidCallback onConfirmed}) =>
      Navigator.of(context).push<void>(
        MaterialPageRoute(builder: (context) => RecoverStellarScreen(onConfirmed: onConfirmed)),
      );

  void _handleRecoverPressed() {
    sl<StellarRecoveryService>().recover();
    onConfirmed();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: CpColors.lightSandColor,
    appBar: CpAppBar(
      scrolledUnderColor: CpColors.lightSandColor,
      title: Text(context.l10n.moneyRecoveryTitle),
    ),
    extendBodyBehindAppBar: true,
    extendBody: true,
    bottomNavigationBar: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: CpButton(onPressed: _handleRecoverPressed, text: context.l10n.moneyRecoveryBtn),
      ),
    ),
    body: Stack(
      children: [
        Center(child: Assets.images.dollarBg.image(fit: BoxFit.fitHeight, height: double.infinity)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Assets.icons.money.svg(height: 90, width: 90),
              const SizedBox(height: 24),
              Text(
                context.l10n.moneyRecoveryContent(
                  sl<StellarRecoveryService>().value.amount?.format(
                        context.locale,
                        maxDecimals: 2,
                      ) ??
                      '-',
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 32, height: 0.95),
              ),
              const SizedBox(height: 12),
              Text(
                context.l10n.moneyRecoverySubContent,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              ),
              const SizedBox(height: 6),
              Text(
                context.l10n.moneyRecoveryDisclaimer,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
