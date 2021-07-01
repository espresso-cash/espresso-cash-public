import 'package:json_annotation/json_annotation.dart';

part 'json_rpc_exception.g.dart';

@JsonSerializable(createToJson: false)
class JsonRpcException implements Exception {
  const JsonRpcException(this.message, this.code, this.data);

  factory JsonRpcException.fromJson(Map<String, dynamic> json) =>
      _$JsonRpcExceptionFromJson(json);

  final String message;
  final int code;

  // FIXME: data can be structured
  final dynamic data;

  @override
  String toString() {
    if (data != null) {
      return 'jsonrpc-2.0 error ($code): $message\n\t$data';
    } else {
      return 'jsonrpc-2.0 error ($code): $message';
    }
  }
}
