import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import '../../ui/content_padding.dart';
import '../../ui/tab_bar.dart';
import '../utils.dart';

final cpTabBar = Story(
  name: 'CpTabBar',
  builder: (context) => DefaultTabController(
    length: 2,
    child: Column(
      children: [
        CpContentPadding(
          child: CpTabBar(
            variant: context.knobs.options(
              label: 'Variant',
              initial: CpTabBarVariant.dark,
              options: CpTabBarVariant.values.toOptions(),
            ),
            tabs: const [
              Tab(text: 'Tab 1'),
              Tab(text: 'Tab 2'),
            ],
          ),
        ),
        const Expanded(
          child: TabBarView(
            children: [
              Center(child: Text('Tab 1')),
              Center(child: Text('Tab 2')),
            ],
          ),
        ),
      ],
    ),
  ),
);
