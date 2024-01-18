import 'package:flutter/material.dart';

import '../../gen/assets.gen.dart';
import '../../l10n/l10n.dart';
import 'extensions.dart';
import 'landing_widget.dart';
import 'presentation/qr_code.dart';
import 'presentation/step_circle.dart';

class EspressoDesktopView extends StatelessWidget {
  const EspressoDesktopView({
    super.key,
    required this.actionLink,
    required this.header,
  });

  final Uri actionLink;
  final Widget header;

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
              color: Color(0xFF2D2B2C),
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
          color: Color(0xFF2D2B2C),
          fontSize: 19,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.13,
        ),
      ),
    );

    return Scaffold(
      body: LandingDesktopWidget(
        header: header,
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
                      color: Color(0xFFE4E4E4),
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
                      color: Color(0xFFE4E4E4),
                      thickness: 1.5,
                      height: 32,
                    ),
                    second,
                  ],
                ),
              ),
          ],
        ),
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
