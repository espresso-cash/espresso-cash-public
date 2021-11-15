part of 'dto.dart';

@JsonSerializable(genericArgumentFactories: true, createToJson: false)
class RpcResponse<T> {
  RpcResponse({required this.context, required this.value});

  factory RpcResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$RpcResponseFromJson(json, fromJsonT);

  final RpcResponseContext context;
  final T value;
}

@JsonSerializable(createToJson: false)
class RpcResponseContext {
  RpcResponseContext({required this.slot});

  factory RpcResponseContext.fromJson(Map<String, dynamic> json) =>
      _$RpcResponseContextFromJson(json);

  final int slot;
}
