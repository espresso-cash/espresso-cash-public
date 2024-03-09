import 'package:flutter/material.dart';

import '../gen/assets.gen.dart';
import 'app_bar.dart';
import 'back_button.dart';
import 'colors.dart';
import 'theme.dart';

enum FormPageColorTheme { orange, gold }

class FormPage extends StatelessWidget {
  const FormPage({
    super.key,
    required this.headerIcon,
    required this.headerContent,
    required this.content,
    required this.colorTheme,
    required this.title,
  });

  final AssetGenImage headerIcon;
  final Widget headerContent;
  final Widget content;
  final FormPageColorTheme colorTheme;
  final Widget title;

  @override
  Widget build(BuildContext context) => CpTheme.black(
        child: Scaffold(
          appBar: CpAppBar(
            scrolledUnderColor: switch (colorTheme) {
              FormPageColorTheme.orange => CpColors.darkOrangeBackgroundColor,
              FormPageColorTheme.gold => CpColors.goldBackgroundColor,
            },
            leading: const CpBackButton(),
            title: title,
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
                          colorTheme: colorTheme,
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
    required this.colorTheme,
    required this.icon,
    required this.content,
  });

  final FormPageColorTheme colorTheme;
  final AssetGenImage icon;
  final Widget content;

  AssetGenImage get image => switch (colorTheme) {
        FormPageColorTheme.orange => Assets.images.formPageOrangeBg,
        FormPageColorTheme.gold => Assets.images.formPageGoldBg,
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
                  colors: switch (colorTheme) {
                    FormPageColorTheme.orange => [
                        const Color(0x00D06022),
                        CpColors.darkOrangeBackgroundColor,
                      ],
                    FormPageColorTheme.gold => [
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
