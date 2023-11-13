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
              const SizedBox(height: 32),
              Assets.images.logo.image(height: 57),
              const SizedBox(height: 32),
            ] else ...[
              const SizedBox(height: 32),
              Assets.images.logo.image(height: 62),
              const SizedBox(height: 32),
            ],
          ],
        ),
      );
}
