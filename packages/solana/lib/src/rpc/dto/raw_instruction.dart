import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc/dto/instruction.dart';

part 'raw_instruction.g.dart';

@JsonSerializable()
class RawInstruction implements Instruction {
  const RawInstruction({
    required this.programIdIndex,
    required this.accounts,
    required this.data,
  });

  factory RawInstruction.fromJson(Map<String, dynamic> json) =>
      _$RawInstructionFromJson(json);

  /// Index into the message.accountKeys array indicating the
  /// program account that executes this instruction.
  final int programIdIndex;

  /// List of ordered indices into the message.accountKeys array
  /// indicating which accounts to pass to the program.
  final List<int> accounts;

  /// The program input data encoded in a base-58 string.
  final String data;

  @override
  Map<String, dynamic> toJson() => _$RawInstructionToJson(this);
}
