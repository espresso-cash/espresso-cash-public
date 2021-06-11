import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/types/transaction/account_key.dart';
import 'package:solana/src/types/transaction/instruction.dart';
import 'package:solana/src/types/transaction/message_header.dart';

part 'message.g.dart';

@JsonSerializable(createToJson: false)
class Message {
  Message({
    this.header,
    required this.accountKeys,
    required this.recentBlockhash,
    required this.instructions,
  });

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  final List<AccountKey> accountKeys;
  final MessageHeader? header;
  final String recentBlockhash;
  final List<Instruction> instructions;
}
