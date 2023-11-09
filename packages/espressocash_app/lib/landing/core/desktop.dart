import 'package:flutter/material.dart';

import '../../gen/assets.gen.dart';
import '../../l10n/l10n.dart';
import 'extensions.dart';
import 'landing_widget.dart';
import 'presentation/header.dart';
import 'presentation/qr_code.dart';
import 'presentation/step_circle.dart';

class DesktopView extends StatelessWidget {
  const DesktopView({
    super.key,
    required this.actionLink,
    required this.title,
  });

  final Uri actionLink;
  final String title;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

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
          ),
        ],
      ),
    );

    final second = _InstructionItem(
      step: 2,
      content: QrWidget(qrLink: actionLink),
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

    return Scaffold(
      body: LandingScreenWidget(
        children: [
          const EspressoHeader(),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            context.l10n.landingInstruction,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 50),
          if (width > 750)
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  first,
                  const VerticalDivider(
                    color: Colors.white,
                    thickness: 1.5,
                    width: 32,
                  ),
                  second,
                  const Spacer(),
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
                  const Divider(
                    color: Colors.white,
                    thickness: 1.5,
                    height: 32,
                  ),
                  second,
                ],
              ),
            ),
        ],
      ),
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
        // TODO(KB): Check if needed
        // ignore: avoid-single-child-column-or-row
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
                SizedBox(
                  height: 225,
                  child: Column(
                    children: [
                      content,
                      const Spacer(),
                      SizedBox(
                        height: 40,
                        child: text,
                      ),
                    ],
                  ),
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
          InkWell(
            onTap: context.launchPlayStore,
            child: Assets.landing.playstore.image(height: 64),
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: context.launchAppStore,
            child: Assets.landing.appstore.image(height: 64),
          ),
        ],
      );
}
