import 'package:json_annotation/json_annotation.dart';

part 'parsed_message_header.g.dart';

/// The header of a [ParsedMessage]
@JsonSerializable()
class ParsedMessageHeader {
  ParsedMessageHeader({
    required this.numRequiredSignatures,
    required this.numReadonlySignedAccounts,
    required this.numReadonlyUnsignedAccounts,
  });

  factory ParsedMessageHeader.fromJson(Map<String, dynamic> json) =>
      _$ParsedMessageHeaderFromJson(json);

  Map<String, dynamic> toJson() => _$ParsedMessageHeaderToJson(this);

  final int numRequiredSignatures;
  final int numReadonlySignedAccounts;
  final int numReadonlyUnsignedAccounts;
}
