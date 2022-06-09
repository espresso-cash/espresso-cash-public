import 'dart:async';

class RpcTimeoutException extends TimeoutException {
  RpcTimeoutException({
    required String method,
    required this.body,
    Duration? timeout,
  }) : super('RPC call $method timed out.', timeout);

  /// Request body.
  final dynamic body;
}
