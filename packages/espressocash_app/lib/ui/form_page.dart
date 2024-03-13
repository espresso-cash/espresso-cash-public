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
    required this.colorTheme,
    required this.title,
    required this.header,
    required this.child,
  });

  final Widget header;
  final Widget child;
  final FormPageColorTheme colorTheme;
  final Widget title;

  @override
  Widget build(BuildContext context) {
    final bgColor = switch (colorTheme) {
      FormPageColorTheme.orange => CpColors.darkOrangeBackgroundColor,
      FormPageColorTheme.gold => CpColors.goldBackgroundColor,
    };

    return CpTheme.black(
      child: Scaffold(
        appBar: CpAppBar(
          scrolledUnderColor: bgColor,
          leading: const CpBackButton(),
          title: title,
        ),
        backgroundColor: bgColor,
        extendBodyBehindAppBar: true,
        body: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    _Header(colorTheme: colorTheme, content: header),
                    _Content(child: child),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FormPageHeader extends StatelessWidget {
  const FormPageHeader({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });

  final AssetGenImage icon;
  final Widget title;
  final Widget description;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: icon.image(),
            ),
          ),
          const SizedBox(height: 25),
          DefaultTextStyle(
            style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
            child: title,
          ),
          const SizedBox(height: 16),
          DefaultTextStyle(
            style: const TextStyle(fontSize: 13),
            textAlign: TextAlign.center,
            child: description,
          ),
          const SizedBox(height: 70),
        ],
      );
}

class _Header extends StatelessWidget {
  const _Header({
    required this.colorTheme,
    required this.content,
  });

  final FormPageColorTheme colorTheme;
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
                  SizedBox(height: MediaQuery.paddingOf(context).top),
                  Expanded(child: content),
                ],
              ),
            ),
          ],
        ),
      );
}

class _Content extends StatelessWidget {
  const _Content({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) => Expanded(
        child: SafeArea(
          top: false,
          minimum: const EdgeInsets.only(bottom: 75, left: 40, right: 40),
          child: child,
        ),
      );
}
