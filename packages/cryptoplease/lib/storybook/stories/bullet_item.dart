import 'package:storybook_flutter/storybook_flutter.dart';

import '../../ui/bullet_item.dart';

final cpBulletItem = Story(
  name: 'CpBulletItem',
  builder: (context) => const CpBulletItemWidget(
    text: 'Espresso Cash Bullet Item Widget',
  ),
);
