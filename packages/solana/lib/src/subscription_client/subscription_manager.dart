import 'dart:async';

class SubscriptionManager<T> {
  SubscriptionManager(this._controller);

  void add(T event) => _controller.add(event);

  void addError(Object error) => _controller.addError(error);

  Stream<T> get stream => _controller.stream;

  int? subscriptionId;
  final StreamController<T> _controller;
}
