import 'package:flutter/material.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../l10n/l10n.dart';
import '../../../../ui/app_bar.dart';
import '../../../../ui/back_button.dart';
import '../../../../ui/colors.dart';
import '../../../../ui/theme.dart';
import '../../models/ramp_type.dart';

class RampPage extends StatelessWidget {
  const RampPage({
    super.key,
    required this.headerIcon,
    required this.headerContent,
    required this.content,
    required this.type,
  });

  final AssetGenImage headerIcon;
  final Widget headerContent;
  final Widget content;
  final RampType type;

  @override
  Widget build(BuildContext context) => CpTheme.black(
        child: Scaffold(
          appBar: CpAppBar(
            leading: const CpBackButton(),
            title: Text(
              switch (type) {
                RampType.onRamp => context.l10n.ramp_btnAddCash,
                RampType.offRamp => context.l10n.ramp_btnCashOut,
              }
                  .toUpperCase(),
            ),
          ),
          extendBodyBehindAppBar: true,
          body: CpTheme.black(
            child: LayoutBuilder(
              builder: (context, viewportConstraints) => SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        _Header(
                          type: type,
                          icon: headerIcon,
                          content: headerContent,
                        ),
                        Expanded(child: content),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}

class _Header extends StatelessWidget {
  const _Header({
    required this.type,
    required this.icon,
    required this.content,
  });

  final RampType type;
  final AssetGenImage icon;
  final Widget content;

  AssetGenImage get image => switch (type) {
        RampType.onRamp => Assets.images.cashInBg,
        RampType.offRamp => Assets.images.cashOutBg,
      };

  @override
  Widget build(BuildContext context) => AspectRatio(
        aspectRatio: 420 / 480,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            image.image(
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              height: 150,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: switch (type) {
                    RampType.onRamp => [
                        const Color(0x00D06022),
                        CpColors.darkOrangeBackgroundColor,
                      ],
                    RampType.offRamp => [
                        const Color(0x00C8B57D),
                        CpColors.goldBackgroundColor,
                      ],
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.paddingOf(context).top,
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: icon.image(),
                    ),
                  ),
                  const SizedBox(height: 18),
                  content,
                ],
              ),
            ),
          ],
        ),
      );
}
