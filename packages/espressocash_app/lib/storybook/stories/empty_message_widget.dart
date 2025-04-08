import 'package:storybook_flutter/storybook_flutter.dart';

import '../../ui/empty_message_widget.dart';

final cpEmptyMessageWidget = Story(
  name: 'CpEmptyMessageWidget',
  builder: (context) => const CpEmptyMessageWidget(message: 'This is a message for empty lists'),
);
