part of 'rpc_client.dart';

class JsonRpcResponse<T> {
  JsonRpcResponse({required this.result});

  final T result;
}

@JsonSerializable(genericArgumentFactories: true, createToJson: false)
class ValueResponse<T> {
  ValueResponse({required this.value});

  factory ValueResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$ValueResponseFromJson(json, fromJsonT);

  final T value;
}
