import 'package:solana/src/rpc/dto/parsed_message/parsed_instruction.dart';
import 'package:solana/src/rpc/dto/raw_instruction.dart';

/// An instruction in a transaction
abstract class Instruction {
  factory Instruction.fromJson(Map<String, dynamic> json) {
    if (json["parsed"] != null) {
      return ParsedInstruction.fromJson(json);
    } else {
      return RawInstruction.fromJson(json);
    }
  }
}
