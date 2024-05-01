import 'package:flutter/material.dart';

import '../../gen/assets.gen.dart';
import '../../ui/app_bar.dart';
import '../../ui/back_button.dart';
import '../../ui/theme.dart';

class PayDetailsPage extends StatelessWidget {
  const PayDetailsPage({
    super.key,
    this.headerIcon,
    required this.content,
    required this.title,
    required this.headerBackground,
    this.backgroundColor,
  });

  final String title;
  final AssetGenImage? headerIcon;
  final AssetGenImage headerBackground;
  final Widget content;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) => CpTheme.black(
        child: Scaffold(
          appBar: CpAppBar(
            leading: const CpBackButton(),
            title: Text(title.toUpperCase()),
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
                  child: Stack(
                    children: [
                      _Header(
                        icon: headerIcon,
                        background: headerBackground,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: viewportConstraints.maxHeight * 0.4,
                          ),
                          Expanded(child: content),
                        ],
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
        aspectRatio: 420 / 480,
        child: Stack(
          alignment: Alignment.center,
          children: [
            background.image(
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            if (icon case final icon?) icon.image(height: 160),
          ],
        ),
      );
}
