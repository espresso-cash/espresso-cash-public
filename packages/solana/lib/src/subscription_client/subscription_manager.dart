import 'dart:async';

class SubscriptionManager<T> {
  SubscriptionManager({
    required void Function() onListen,
    required void Function(int) onCancel,
    bool singleShot = false,
  }) : isSingleShot = singleShot {
    _controller = StreamController<T>(
      onListen: onListen,
      onCancel: () {
        if (isSingleShot) return;
        final subscriptionId = this.subscriptionId;
        if (subscriptionId != null) {
          onCancel(subscriptionId);
        }
      },
    );
  }

  void add(T event) => _controller.add(event);

  void addError(Object error) => _controller.addError(error);

  Stream<T> get stream => _controller.stream;

  int? subscriptionId;

  late final StreamController<T> _controller;
  final bool isSingleShot;
}
