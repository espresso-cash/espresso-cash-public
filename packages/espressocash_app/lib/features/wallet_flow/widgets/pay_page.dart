import 'package:flutter/material.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../ui/app_bar.dart';
import '../../../../ui/back_button.dart';
import '../../../../ui/theme.dart';

class PayPage extends StatelessWidget {
  const PayPage({
    super.key,
    this.headerIcon,
    required this.headerContent,
    required this.content,
    required this.title,
    required this.headerBackground,
  });

  final String title;
  final AssetGenImage? headerIcon;
  final AssetGenImage headerBackground;
  final Widget headerContent;
  final Widget content;

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
                        content: headerContent,
                        background: headerBackground,
                      ),
                      Expanded(child: content),
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
    required this.content,
    required this.background,
  });

  final AssetGenImage? icon;
  final AssetGenImage background;
  final Widget content;

  @override
  Widget build(BuildContext context) => AspectRatio(
        aspectRatio: 428 / 453,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            background.image(
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
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
                  if (icon case final icon?)
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
