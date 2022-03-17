import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final cpUserAvatar = Story(
  name: 'CpUserAvatar',
  builder: (context) => CpUserAvatar(
    userName: context.knobs.text(label: 'Name', initial: 'Test'),
    radius: 48,
    image: context.knobs.boolean(label: 'Image', initial: false)
        ? const NetworkImage(
            'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
          )
        : null,
  ),
);
