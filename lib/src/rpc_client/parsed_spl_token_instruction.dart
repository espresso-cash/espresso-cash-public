part of 'rpc_client.dart';

@Freezed(unionKey: 'type', fallbackUnion: 'unsupported')
class ParsedSplTokenInstruction with _$ParsedSplTokenInstruction {
  const factory ParsedSplTokenInstruction.transfer({
    required ParsedSplTokenTransferInformation info,
    required String type,
  }) = ParsedSplTokenTransferInstruction;

  const factory ParsedSplTokenInstruction.unsupported({
    required String type,
  }) = ParsedSplTokenUnsupportedInstruction;

  factory ParsedSplTokenInstruction.fromJson(Map<String, dynamic> json) =>
      _$ParsedSplTokenInstructionFromJson(json);
}

@freezed
class ParsedSplTokenTransferInformation
    with _$ParsedSplTokenTransferInformation {
  const factory ParsedSplTokenTransferInformation({
    required String amount,
    required String authority,
    required String source,
    required String destination,
  }) = _ParsedSplTokenTransferInformation;

  factory ParsedSplTokenTransferInformation.fromJson(
          Map<String, dynamic> json) =>
      _$ParsedSplTokenTransferInformationFromJson(json);
}
