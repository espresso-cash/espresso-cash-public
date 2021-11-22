import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc/dto/instruction.dart';

part 'inner_instruction.g.dart';

/// List of inner instructions or omitted if inner instruction
/// recording was not yet enabled during this transaction
@JsonSerializable(createFactory: true, includeIfNull: false)
class InnerInstruction {
  const InnerInstruction({
    required this.index,
    required this.instruction,
  });

  factory InnerInstruction.fromJson(Map<String, dynamic> json) =>
      _$InnerInstructionFromJson(json);

  Map<String, dynamic> toJson() => _$InnerInstructionToJson(this);

  /// Index of the transaction instruction from which the inner
  /// instruction(s) originated
  final int index;

  /// Ordered list of inner program instructions that were
  /// invoked during a single transaction instruction.
  final List<Instruction> instruction;
}
