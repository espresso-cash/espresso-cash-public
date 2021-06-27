part of 'rpc_client.dart';

/// An instruction which is part of a [ParsedMessage]
@Freezed(unionKey: 'program', fallbackUnion: 'unsupported')
class ParsedInstruction with _$ParsedInstruction {
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
    @JsonKey(name: 'parsed') required String? memo,
  }) = ParsedInstructionMemo;

  /// Any instruction that we are not currencly supporting.
  const factory ParsedInstruction.unsupported({
    required String program,
  }) = ParsedInstructionUnsupported;

  factory ParsedInstruction.fromJson(Map<String, dynamic> json) =>
      _$ParsedInstructionFromJson(json);
}
