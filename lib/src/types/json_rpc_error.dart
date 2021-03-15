import 'package:meta/meta.dart';

class JsonRpcError implements Exception {
  JsonRpcError({
    @required this.message,
    @required this.code,
    this.data,
  });

  factory JsonRpcError.fromJson(Map<String, dynamic> value) => JsonRpcError(
        message: value['message'] as String,
        code: value['code'] as int,
        data: value['data'],
      );

  factory JsonRpcError.fromString(String value) => JsonRpcError(
        message: value,
        code: -1,
        data: null,
      );

  @override
  String toString() => 'jsonrpc-2.0 error ($code): $message\n\t$data';

  final String message;
  final int code;
  // FIXME: data can be structured
  dynamic data;
}
