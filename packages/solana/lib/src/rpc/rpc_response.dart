import 'package:json_annotation/json_annotation.dart';

part 'rpc_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class RpcResponse<T> {
  const RpcResponse({
    required this.result,
  });

  factory RpcResponse.fromJson(Map<String, dynamic> json,
      T Function(Object? data) fromJsonT,) =>
      _$RpcResponseFromJson(json, fromJsonT);

  final T result;
}
