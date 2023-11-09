import 'package:flutter/widgets.dart';

import '../../../gen/assets.gen.dart';
import '../extensions.dart';

class EspressoHeader extends StatelessWidget {
  const EspressoHeader({super.key});

  @override
  Widget build(BuildContext context) => Hero(
        tag: 'espresso_header',
        child: Column(
          children: [
            if (isMobile) ...[
              Assets.images.logoIcon.image(height: 120),
              const SizedBox(height: 60),
            ] else ...[
              const SizedBox(height: 32),
              Assets.images.logoDark.image(height: 62),
              const SizedBox(height: 32),
            ],
          ],
        ),
      );
}
