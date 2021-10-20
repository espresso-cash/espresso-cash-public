import 'package:json_annotation/json_annotation.dart';

part 'rpc_response.g.dart';

@JsonSerializable(genericArgumentFactories: true, createToJson: false)
class RpcResponse<T> {
  const RpcResponse({required this.value});

  factory RpcResponse.fromJson(
    Map<String, dynamic> data,
    T Function(Object? json) fromJsonT,
  ) =>
      _$RpcResponseFromJson(data, fromJsonT);

  final T value;
}
