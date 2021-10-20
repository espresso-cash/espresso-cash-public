import 'package:freezed_annotation/freezed_annotation.dart';

part 'parsed_message_header.freezed.dart';
part 'parsed_message_header.g.dart';

/// The header of a [ParsedMessage]
@freezed
class ParsedMessageHeader with _$ParsedMessageHeader {
  const factory ParsedMessageHeader({
    required int numRequiredSignatures,
    required int numReadonlySignedAccounts,
    required int numReadonlyUnsignedAccounts,
  }) = _ParsedMessageHeader;

  factory ParsedMessageHeader.fromJson(Map<String, dynamic> json) =>
      _$ParsedMessageHeaderFromJson(json);
}
