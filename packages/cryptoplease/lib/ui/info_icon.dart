import 'package:cryptoplease/gen/assets.gen.dart';
import 'package:cryptoplease/ui/colors.dart';
import 'package:flutter/material.dart';

class CpInfoIcon extends StatelessWidget {
  const CpInfoIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Assets.icons.info.svg(
        color: CpColors.backgroundAccentColor,
        height: 20,
      );
}
