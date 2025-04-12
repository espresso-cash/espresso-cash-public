import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import '../../ui/content_padding.dart';
import '../../ui/info_widget.dart';
import '../utils.dart';

final cpInfoWidget = Story(
  name: 'CpInfoWidget',
  builder:
      (context) => CpContentPadding(
        child: CpInfoWidget(
          variant: context.knobs.options(
            label: 'Variant',
            initial: CpInfoVariant.light,
            options: CpInfoVariant.values.toOptions(),
          ),
          message: Text(context.knobs.text(label: 'Message', initial: 'Info message!')),
        ),
      ),
);
