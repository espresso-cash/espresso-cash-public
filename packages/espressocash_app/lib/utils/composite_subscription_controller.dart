import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

mixin CompositeSubscriptionController<T extends StatefulWidget> on State<T> {
  final subscriptions = CompositeSubscription();

  @override
  void dispose() {
    subscriptions.clear();
    super.dispose();
  }
}
