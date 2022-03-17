import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final cpEmptyMessageWidget = Story(
  name: 'CpEmptyMessageWidget',
  builder: (context) => const CpEmptyMessageWidget(
    message: 'This is a message for empty lists',
  ),
);
