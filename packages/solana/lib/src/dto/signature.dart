import 'package:json_annotation/json_annotation.dart';

part 'signature.g.dart';

@JsonSerializable(createToJson: false)
class GetSignatureResponse {
  GetSignatureResponse({
    required this.jsonrpc,
    required this.result,
    required this.id,
  });

  factory GetSignatureResponse.fromJson(Map<String, dynamic> json) =>
      _$GetSignatureResponseFromJson(json);

  final String jsonrpc;
  final List<GetSignatureItem> result;
  final String id;
}

@JsonSerializable(createToJson: false)
class GetSignatureItem {
  GetSignatureItem({
    required this.signature,
    required this.slot,
    required this.blockTime,
  });

  factory GetSignatureItem.fromJson(Map<String, dynamic> json) =>
      _$GetSignatureItemFromJson(json);

  final String signature;
  final int slot;
  final int? blockTime;
}
