import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/src/rpc/dto/parsed_message/spl_token_transfer_checked_info.dart';
import 'package:solana/src/rpc/dto/parsed_message/spl_token_transfer_info.dart';

part 'parsed_spl_token_instruction.freezed.dart';
part 'parsed_spl_token_instruction.g.dart';

/// An instruction of a [spl token] program
///
/// [spl token]: https://spl.solana.com/token
@Freezed(unionKey: 'type', fallbackUnion: 'generic')
class ParsedSplTokenInstruction with _$ParsedSplTokenInstruction {
  const factory ParsedSplTokenInstruction.transfer({
    required SplTokenTransferInfo info,
    required String type,
  }) = ParsedSplTokenTransferInstruction;

  const factory ParsedSplTokenInstruction.transferChecked({
    required SplTokenTransferCheckedInfo info,
    required String type,
  }) = ParsedSplTokenTransferCheckedInstruction;

  const factory ParsedSplTokenInstruction.generic({
    required dynamic info,
    required String type,
  }) = ParsedSplTokenGenericInstruction;

  factory ParsedSplTokenInstruction.fromJson(Map<String, dynamic> json) =>
      _$ParsedSplTokenInstructionFromJson(json);
}
