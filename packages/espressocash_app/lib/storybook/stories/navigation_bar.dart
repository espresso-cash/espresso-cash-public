import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import '../../gen/assets.gen.dart';
import '../../ui/navigation_bar/navigation_bar.dart';
import '../../ui/navigation_bar/navigation_button.dart';

final cpNavigationBar = Story(
  name: 'CpNavigationBar',
  builder:
      (context) => Scaffold(
        backgroundColor: Colors.white,
        extendBody: true,
        bottomNavigationBar: CPNavigationBar(
          items: [
            CpNavigationButton(icon: Assets.icons.home, active: true, onPressed: () {}),
            CpNavigationButton(icon: Assets.icons.wallet, active: false, onPressed: () {}),
            CpNavigationButton(icon: Assets.icons.notifications, active: false, onPressed: () {}),
          ],
        ),
      ),
);
