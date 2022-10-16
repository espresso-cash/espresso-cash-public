import 'package:cryptoplease/app/ui/colors.dart';
import 'package:cryptoplease/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class InfoIcon extends StatelessWidget {
  const InfoIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Assets.icons.info.svg(
        color: CpColors.backgroundAccentColor,
        height: 20,
      );
}
