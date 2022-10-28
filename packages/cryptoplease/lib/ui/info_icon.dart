import 'package:flutter/material.dart';

import '../gen/assets.gen.dart';
import 'colors.dart';

class CpInfoIcon extends StatelessWidget {
  const CpInfoIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Assets.icons.info.svg(
        color: CpColors.backgroundAccentColor,
        height: 20,
      );
}
