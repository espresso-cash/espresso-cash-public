import 'dart:async';

class RpcTimeoutException extends TimeoutException {
  RpcTimeoutException(this.body) : super('Request timed out.');

  /// Request body.
  final dynamic body;
}
