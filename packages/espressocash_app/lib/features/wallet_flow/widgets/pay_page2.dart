import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/back_button.dart';
import '../../../ui/button.dart';
import '../../../ui/colors.dart';
import '../../../ui/theme.dart';

class InitialPayPage extends StatelessWidget {
  const InitialPayPage({
    super.key,
    required this.title,
    required this.headerIcon,
    required this.headerBackground,
    required this.backgroundColor,
    required this.description,
    this.subtitle,
    required this.moreOptionsLabel,
    required this.onContinue,
    required this.onMoreOptions,
  });

  final String title;
  final AssetGenImage headerIcon;
  final AssetGenImage headerBackground;
  final Color backgroundColor;
  final String description;
  final String? subtitle;
  final String moreOptionsLabel;
  final VoidCallback onContinue;
  final VoidCallback onMoreOptions;

  @override
  Widget build(BuildContext context) => CpTheme.black(
        child: Scaffold(
          appBar: CpAppBar(
            leading: const CpBackButton(),
            title: Text(
              title.toUpperCase(),
            ),
          ),
          extendBodyBehindAppBar: true,
          backgroundColor: backgroundColor,
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
                              const SizedBox(height: 24),
                              CpButton(
                                text: 'Continue',
                                width: double.infinity,
                                size: CpButtonSize.big,
                                trailing: const Padding(
                                  padding: EdgeInsets.only(right: 8),
                                  child: _Arrow(),
                                ),
                                onPressed: onContinue,
                              ),
                              const SizedBox(height: 24),
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
  });

  final AssetGenImage? icon;
  final AssetGenImage background;

  @override
  Widget build(BuildContext context) => AspectRatio(
        aspectRatio: 428 / 453,
        child: Stack(
          alignment: Alignment.center,
          children: [
            background.image(
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Align(
              //TODO
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 75,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0x00D06022),
                      Color(0xFFD86322),
                    ],
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
                if (icon case final icon?)
                  Hero(
                    tag: 'header_icon',
                    child: icon.image(height: 160),
                  ),
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

class _Arrow extends StatelessWidget {
  const _Arrow();

  @override
  Widget build(BuildContext context) => RotatedBox(
        quarterTurns: 2,
        child: Assets.icons.arrow.svg(
          height: 14,
          color: const Color(0xFF2D2B2C),
        ),
      );
}
