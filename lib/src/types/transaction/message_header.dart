import 'package:json_annotation/json_annotation.dart';

part 'message_header.g.dart';

@JsonSerializable(createToJson: false)
class MessageHeader {
  MessageHeader({
    required this.numRequiredSignatures,
    required this.numReadonlySignedAccounts,
    required this.numReadonlyUnsignedAccounts,
  });

  factory MessageHeader.fromJson(Map<String, dynamic> json) =>
      _$MessageHeaderFromJson(json);

  final int numRequiredSignatures;
  final int numReadonlySignedAccounts;
  final int numReadonlyUnsignedAccounts;
}
