import 'package:flutter/material.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../ui/app_bar.dart';
import '../../../../ui/back_button.dart';
import '../../../../ui/theme.dart';

class PayPage extends StatelessWidget {
  const PayPage({
    super.key,
    this.headerIcon,
    required this.content,
    required this.title,
    required this.headerBackground,
  });

  final String title;
  final AssetGenImage? headerIcon;
  final AssetGenImage headerBackground;
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
                  child: Stack(
                    children: [
                      _Header(
                        icon: headerIcon,
                        background: headerBackground,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: viewportConstraints.maxHeight * 0.45,
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
        aspectRatio: 428 / 500,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            background.image(
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Column(
              children: [
                SizedBox(height: MediaQuery.paddingOf(context).top + 24),
                if (icon case final icon?)
                  Align(
                    alignment: Alignment.center,
                    child: Hero(
                      tag: 'header_icon',
                      child: icon.image(height: 160),
                    ),
                  ),
              ],
            ),
          ],
        ),
      );
}
