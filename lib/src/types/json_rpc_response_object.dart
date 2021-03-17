import 'package:json_annotation/json_annotation.dart';

part 'json_rpc_response_object.g.dart';

class JsonRpcResponse<T> {
  JsonRpcResponse({this.result});

  final T result;
}

@JsonSerializable(genericArgumentFactories: true, createToJson: false)
class ValueResponse<T> {
  ValueResponse({this.value});

  factory ValueResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object json) fromJsonT,
  ) =>
      _$ValueResponseFromJson(json, fromJsonT);

  final T value;
}
