import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/src/rpc/dto/instruction.dart';
import 'package:solana/src/rpc/dto/parsed_message/parsed_spl_token_instruction.dart';
import 'package:solana/src/rpc/dto/parsed_message/parsed_system_instruction.dart';

part 'parsed_instruction.freezed.dart';
part 'parsed_instruction.g.dart';

/// An instruction which is part of a `ParsedMessage`.
@Freezed(unionKey: 'program', fallbackUnion: 'unsupported')
class ParsedInstruction with _$ParsedInstruction implements Instruction {
  const factory ParsedInstruction.system({
    required String programId,
    required ParsedSystemInstruction parsed,
  }) = ParsedInstructionSystem;

  @FreezedUnionValue('spl-token')
  const factory ParsedInstruction.splToken({
    required ParsedSplTokenInstruction parsed,
  }) = ParsedInstructionSplToken;

  /// Instruction representing a memo with content [memo]
  @FreezedUnionValue('spl-memo')
  const factory ParsedInstruction.memo({
    // This ignore is needed until https://github.com/dart-lang/linter/issues/2778 is fixed
    // ignore: invalid_annotation_target
    @JsonKey(name: 'parsed') required String? memo,
  }) = ParsedInstructionMemo;

  /// Any instruction that we are not currently supporting.
  const factory ParsedInstruction.unsupported({
    String? program,
  }) = ParsedInstructionUnsupported;

  factory ParsedInstruction.fromJson(Map<String, dynamic> json) =>
      _$ParsedInstructionFromJson(json);
}
