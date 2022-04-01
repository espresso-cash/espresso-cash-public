import 'package:freezed_annotation/freezed_annotation.dart';

part 'parsed_system_instruction.freezed.dart';
part 'parsed_system_instruction.g.dart';

/// An instruction that is part if a `ParsedInstruction`
@Freezed(unionKey: 'type', fallbackUnion: 'unsupported')
class ParsedSystemInstruction with _$ParsedSystemInstruction {
  /// Transfer instruction data for a transfer of `info.lamports` from
  /// `info.source` to `info.destination`.
  const factory ParsedSystemInstruction.transfer({
    required ParsedSystemTransferInformation info,
    required String type,
  }) = ParsedSystemTransferInstruction;

  /// Transfer instruction data for a transfer of `info.lamports` from
  /// `info.source` to `info.destination`.
  const factory ParsedSystemInstruction.transferChecked({
    required ParsedSystemTransferInformation info,
    required String type,
  }) = ParsedSystemTransferCheckedInstruction;

  /// Instructions that we haven't implemented yet.
  const factory ParsedSystemInstruction.unsupported({
    required String type,
  }) = ParsedSystemUnsupportedInstruction;

  factory ParsedSystemInstruction.fromJson(Map<String, dynamic> json) =>
      _$ParsedSystemInstructionFromJson(json);
}

/// Information about a transfer of [lamports] from [source] to [destination]
@freezed
class ParsedSystemTransferInformation with _$ParsedSystemTransferInformation {
  const factory ParsedSystemTransferInformation({
    required int lamports,
    required String source,
    required String destination,
  }) = _ParsedSystemTransferInformation;

  factory ParsedSystemTransferInformation.fromJson(Map<String, dynamic> json) =>
      _$ParsedSystemTransferInformationFromJson(json);
}
