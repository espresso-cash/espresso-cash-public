import 'package:json_annotation/json_annotation.dart';

part 'instruction.g.dart';

/// An instruction in a transaction
@JsonSerializable(createFactory: true, includeIfNull: false)
class Instruction {
  const Instruction({
    required this.programIdIndex,
    required this.accounts,
    required this.data,
  });

  factory Instruction.fromJson(Map<String, dynamic> json) =>
      _$InstructionFromJson(json);

  Map<String, dynamic> toJson() => _$InstructionToJson(this);

  /// Index into the message.accountKeys array indicating the
  /// program account that executes this instruction.
  final int programIdIndex;

  /// List of ordered indices into the message.accountKeys array
  /// indicating which accounts to pass to the program.
  final List<int> accounts;

  /// The program input data encoded in a base-58 string.
  final String data;
}
