import 'dart:async';

class RPCTimeoutException extends TimeoutException {
  RPCTimeoutException(String? message) : super(message);

  RPCTimeoutException.withData(this.data)
      : super('Request timed out. Data: $data');

  /// Additional data passed to the exception for better debug experience.
  String? data;
}
