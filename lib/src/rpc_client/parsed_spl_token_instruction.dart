import 'package:freezed_annotation/freezed_annotation.dart';

part 'parsed_spl_token_instruction.freezed.dart';
part 'parsed_spl_token_instruction.g.dart';

/// An instruction of a [spl token] program
///
/// [spl token]: https://spl.solana.com/token
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

/// Information about a [spl token] transfer
///
/// [spl token]: https://spl.solana.com/token
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
