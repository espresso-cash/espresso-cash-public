import 'package:storybook_flutter/storybook_flutter.dart';

extension EnumsToOptions<T extends Enum> on List<T> {
  List<Option<T>> toOptions() =>
      map((e) => Option(label: e.name, value: e)).toList();
}
