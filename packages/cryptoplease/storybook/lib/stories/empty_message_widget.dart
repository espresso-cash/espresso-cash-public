import 'package:cryptoplease/ui/empty_message_widget.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final cpEmptyMessageWidget = Story(
  name: 'CpEmptyMessageWidget',
  builder: (context) => const CpEmptyMessageWidget(
    message: 'This is a message for empty lists',
  ),
);
