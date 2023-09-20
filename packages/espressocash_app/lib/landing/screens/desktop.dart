import 'package:flutter/material.dart';

import '../../gen/assets.gen.dart';
import '../../l10n/l10n.dart';
import '../widgets/extensions.dart';
import '../widgets/landing_widget.dart';
import '../widgets/qr_code.dart';
import '../widgets/step_circle.dart';

class DesktopView extends StatelessWidget {
  const DesktopView(this.uri, {super.key});

  final Uri uri;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final first = _InstructionItem(
      step: 1,
      content: const _AppStoreWidget(),
      text: Column(
        children: [
          Text(
            context.l10n.landingInstallApp,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF2D2B2C),
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            context.l10n.landingAlreadyInstalled,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF2D2B2C),
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );

    final second = _InstructionItem(
      step: 2,
      content: ShareQr(qrLink: uri),
      text: Text(
        context.l10n.landingScanQr,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Color(0xFF2D2B2C),
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );

    return LandingScreenWidget(
      children: [
        const SizedBox(height: 32),
        Assets.images.logoDark.image(height: 62),
        const SizedBox(height: 32),
        Text(
          context.l10n.landingTitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          context.l10n.landingSubtitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 50),
        if (width > 800)
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                first,
                const VerticalDivider(
                  color: Colors.white,
                  thickness: 1.5,
                  width: 32,
                ),
                second
              ],
            ),
          )
        else
          IntrinsicWidth(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                first,
                const Divider(color: Colors.white, thickness: 1.5, height: 32),
                second,
              ],
            ),
          )
      ],
    );
  }
}

class _InstructionItem extends StatelessWidget {
  const _InstructionItem({
    required this.step,
    required this.content,
    required this.text,
  });
  final int step;
  final Widget content;
  final Widget text;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StepCircle(step),
                const SizedBox(width: 16),
                Column(
                  children: [
                    content,
                    const SizedBox(height: 24),
                    text,
                  ],
                ),
              ],
            ),
          ],
        ),
      );
}

class _AppStoreWidget extends StatelessWidget {
  const _AppStoreWidget();

  @override
  Widget build(BuildContext context) => Column(
        children: [
          GestureDetector(
            onTap: context.launchPlayStore,
            child: Assets.landing.playstore.image(height: 64),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: context.launchAppStore,
            child: Assets.landing.appstore.image(height: 64),
          ),
        ],
      );
}
