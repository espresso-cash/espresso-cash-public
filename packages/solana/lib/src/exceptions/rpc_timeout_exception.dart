import 'dart:async';

class RpcTimeoutException extends TimeoutException {
  RpcTimeoutException(
    this.body, {
    Duration? timeout,
  }) : super(null, timeout);

  /// Request body.
  final dynamic body;
}
