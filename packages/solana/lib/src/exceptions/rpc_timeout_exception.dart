import 'dart:async';

class RpcTimeoutException extends TimeoutException {
  RpcTimeoutException(
    this.body, {
    Duration? timeout,
  }) : super('RPC call timed out.', timeout);

  /// Request body.
  final dynamic body;
}
