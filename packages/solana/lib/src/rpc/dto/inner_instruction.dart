import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc/dto/instruction.dart';

part 'inner_instruction.g.dart';

/// List of inner instructions or omitted if inner instruction
/// recording was not yet enabled during this transaction
@JsonSerializable()
class InnerInstruction {
  const InnerInstruction({
    required this.index,
    required this.instructions,
  });

  factory InnerInstruction.fromJson(Map<String, dynamic> json) =>
      _$InnerInstructionFromJson(json);

  /// Index of the transaction instruction from which the inner
  /// instruction(s) originated
  final int index;

  /// Ordered list of inner program instructions that were
  /// invoked during a single transaction instruction.
  final List<Instruction> instructions;

  Map<String, dynamic> toJson() => _$InnerInstructionToJson(this);
}
