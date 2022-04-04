import 'package:solana/src/rpc/dto/instruction.dart';

class RawInstruction implements Instruction {
  const RawInstruction({
    required this.programIdIndex,
    required this.accounts,
    required this.data,
  });

  factory RawInstruction.fromJson(Map<String, dynamic> json) => RawInstruction(
        programIdIndex: json['programIdIndex'] as int,
        accounts: List<int>.from(
          json['accounts'] as List<dynamic>,
          growable: false,
        ),
        data: json['data'] as String,
      );

  /// Index into the message.accountKeys array indicating the
  /// program account that executes this instruction.
  final int programIdIndex;

  /// List of ordered indices into the message.accountKeys array
  /// indicating which accounts to pass to the program.
  final List<int> accounts;

  /// The program input data encoded in a base-58 string.
  final String data;
}
