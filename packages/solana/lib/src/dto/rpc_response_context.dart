import 'package:json_annotation/json_annotation.dart';

part 'rpc_response_context.g.dart';

@JsonSerializable(createToJson: false)
class RpcResponseContext {
  const RpcResponseContext({required this.slot});

  factory RpcResponseContext.fromJson(Map<String, dynamic> data) =>
      _$RpcResponseContextFromJson(data);

  final int slot;
}
