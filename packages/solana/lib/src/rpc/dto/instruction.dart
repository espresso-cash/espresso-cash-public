import 'package:solana/src/rpc/dto/parsed_message/parsed_instruction.dart';

/// An instruction in a transaction
abstract class Instruction {
  factory Instruction.fromJson(Map<String, dynamic> json) {
    if (json["parsed"] != null) {
      return ParsedInstruction.fromJson(json);
    } else {
      return BasicInstruction(
        programIdIndex: json["programIdIndex"],
        accounts: json["accounts"],
        data: json["data"],
      );
    }
  }
}

class BasicInstruction implements Instruction {
  const BasicInstruction({
    required this.programIdIndex,
    required this.accounts,
    required this.data,
  });

  /// Index into the message.accountKeys array indicating the
  /// program account that executes this instruction.
  final int programIdIndex;

  /// List of ordered indices into the message.accountKeys array
  /// indicating which accounts to pass to the program.
  final List<int> accounts;

  /// The program input data encoded in a base-58 string.
  final String data;
}
