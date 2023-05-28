import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc/dto/account_key.dart';
import 'package:solana/src/rpc/dto/instruction.dart';

part 'simple_instruction.g.dart';

@JsonSerializable(createToJson: false)
class SimpleInstruction implements Instruction {
  const SimpleInstruction({
    required this.programId,
    required this.data,
    required this.accounts,
  });

  factory SimpleInstruction.fromJson(Map<String, dynamic> json) =>
      _$SimpleInstructionFromJson(json);

  final String programId;
  final String data;
  final List<AccountKey> accounts;
}
