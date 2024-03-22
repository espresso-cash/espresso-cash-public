import 'package:flutter/material.dart';

import '../../core/extensions.dart';
import '../../gen/assets.gen.dart';
import '../../l10n/l10n.dart';
import '../../ui/colors.dart';
import '../../ui/desktop_page.dart';
import '../../ui/qr_code.dart';
import '../../ui/step_circle.dart';

class EspressoDesktopView extends StatelessWidget {
  const EspressoDesktopView({
    super.key,
    required this.actionLink,
    required this.title,
    this.subtitle,
  });

  final Uri actionLink;
  final String title;
  final String? subtitle;

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
              color: EcLandingColors.blackTextColor,
              fontSize: 19,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.13,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            context.l10n.landingAlreadyInstalled,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: EcLandingColors.blackTextColor,
              fontSize: 13,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.19,
            ),
          ),
        ],
      ),
    );

    final second = _InstructionItem(
      step: 2,
      content: QrWidget(
        code: actionLink.toString(),
        size: 178,
      ),
      text: Text(
        context.l10n.landingScanQr,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: EcLandingColors.blackTextColor,
          fontSize: 19,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.13,
        ),
      ),
    );

    return LandingDesktopPage(
      title: title,
      subtitle: subtitle,
      content: Column(
        children: [
          const SizedBox(height: 100),
          if (width > 750)
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  first,
                  const VerticalDivider(
                    color: EcLandingColors.dividerColor,
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
                    color: EcLandingColors.dividerColor,
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
                  height: 240,
                  child: Column(
                    children: [
                      content,
                      const Spacer(),
                      SizedBox(
                        height: 50,
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
            child: Assets.images.playstore.image(height: 64),
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: context.launchAppStore,
            child: Assets.images.appstore.image(height: 64),
          ),
        ],
      );
}
