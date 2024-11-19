import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/back_button.dart';
import '../../../ui/colors.dart';
import '../../../ui/theme.dart';

class AmbassadorPage extends StatelessWidget {
  const AmbassadorPage({
    super.key,
    required this.name,
    required this.child,
  });

  final Widget child;
  final String name;

  @override
  Widget build(BuildContext context) => CpTheme.black(
        child: Scaffold(
          appBar: CpAppBar(
            scrolledUnderColor: _backgroundColor,
            leading: const CpBackButton(),
            title: Assets.images.logo.image(height: 35),
          ),
          backgroundColor: _backgroundColor,
          extendBodyBehindAppBar: true,
          body: Column(
            children: [
              const SizedBox(height: 24),
              Expanded(
                child: Center(
                  child: Assets.images.ambassador.svg(fit: BoxFit.fitWidth),
                ),
              ),
              Expanded(
                child: ColoredBox(
                  color: Colors.white,
                  child: Column(
                    children: [
                      _AmbassadorHeader(name: name),
                      Expanded(child: child),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}

class _AmbassadorHeader extends StatelessWidget {
  const _AmbassadorHeader({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 16.0, bottom: 4.0),
        child: Column(
          children: [
            Text(
              context.l10n.ambassador_title,
              style: const TextStyle(
                color: CpColors.darkBackgroundColor,
                fontSize: 15,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.23,
              ),
            ),
            if (name.isNotEmpty)
              Text(
                name,
                style: const TextStyle(
                  color: CpColors.darkBackgroundColor,
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                ),
              ),
          ],
        ),
      );
}

const _backgroundColor = CpColors.mediumSandColor;
