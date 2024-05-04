import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/arrow.dart';
import '../../../ui/back_button.dart';
import '../../../ui/button.dart';
import '../../../ui/colors.dart';
import '../../../ui/theme.dart';

enum PayTheme { dark, light }

class PayMainPage extends StatelessWidget {
  const PayMainPage({
    super.key,
    required this.title,
    required this.headerIcon,
    required this.headerBackground,
    required this.description,
    this.subtitle,
    required this.moreOptionsLabel,
    required this.onContinue,
    required this.onMoreOptions,
    required this.theme,
  });

  final String title;
  final AssetGenImage headerIcon;
  final AssetGenImage headerBackground;
  final String description;
  final String? subtitle;
  final PayTheme theme;
  final String moreOptionsLabel;
  final VoidCallback onContinue;
  final VoidCallback onMoreOptions;

  @override
  Widget build(BuildContext context) => CpTheme.black(
        child: Scaffold(
          appBar: CpAppBar(
            leading: const CpBackButton(),
            title: Text(title.toUpperCase()),
          ),
          extendBodyBehindAppBar: true,
          backgroundColor: theme == PayTheme.dark
              ? CpColors.darkOrangeBackgroundColor
              : CpColors.goldBackgroundColor,
          body: LayoutBuilder(
            builder: (context, viewportConstraints) => SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      _Header(
                        icon: headerIcon,
                        background: headerBackground,
                        theme: theme,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Column(
                            children: [
                              Text(
                                description,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 16),
                              CpButton(
                                text: context.l10n.ramp_btnContinue,
                                width: double.infinity,
                                size: CpButtonSize.big,
                                trailing: const Padding(
                                  padding: EdgeInsets.only(right: 8),
                                  child: Arrow(),
                                ),
                                onPressed: onContinue,
                              ),
                              const SizedBox(height: 16),
                              if (subtitle case final subtitle?) ...[
                                Text(
                                  subtitle,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                              const Spacer(),
                              _Footer(
                                moreOptionsLabel: moreOptionsLabel,
                                onMoreOptions: onMoreOptions,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
    this.icon,
    required this.background,
    required this.theme,
  });

  final AssetGenImage? icon;
  final AssetGenImage background;
  final PayTheme theme;

  @override
  Widget build(BuildContext context) => AspectRatio(
        aspectRatio: 420 / 480,
        child: Stack(
          alignment: Alignment.center,
          children: [
            background.image(
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 75,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: switch (theme) {
                      PayTheme.dark => [
                          const Color(0x00D06022),
                          CpColors.darkOrangeBackgroundColor,
                        ],
                      PayTheme.light => [
                          const Color(0x00C8B57D),
                          CpColors.goldBackgroundColor,
                        ],
                    },
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.paddingOf(context).top,
                ),
                if (icon case final icon?) icon.image(height: 160),
              ],
            ),
          ],
        ),
      );
}

class _Footer extends StatelessWidget {
  const _Footer({required this.onMoreOptions, required this.moreOptionsLabel});

  final VoidCallback onMoreOptions;
  final String moreOptionsLabel;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '$moreOptionsLabel ',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  text: context.l10n.continueHereBtn,
                  recognizer: TapGestureRecognizer()..onTap = onMoreOptions,
                  style: const TextStyle(
                    color: CpColors.yellowColor,
                  ),
                ),
              ],
            ),
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: MediaQuery.paddingOf(context).bottom + 16,
          ),
        ],
      );
}
