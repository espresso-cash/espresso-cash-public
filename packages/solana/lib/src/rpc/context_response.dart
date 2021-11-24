import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc/rpc_response.dart';

part 'context_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ContextResponse<T> {
  const ContextResponse({
    required this.slot,
    required this.value,
  });

  factory ContextResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? data) fromJsonT,
  ) =>
      _$ContextResponseFromJson(json, fromJsonT);

  final RpcResponse<T> value;
  final Context slot;
}

@JsonSerializable()
class Context {
  const Context({
    required this.slot,
  });

  factory Context.fromJson(Map<String, dynamic> json) =>
      _$ContextFromJson(json);

  final int slot;
}
