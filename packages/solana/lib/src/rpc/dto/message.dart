import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc/dto/account_key.dart';
import 'package:solana/src/rpc/dto/instruction.dart';

part 'message.g.dart';

/// A parsed message that is part of a [Transaction] object.
@JsonSerializable(createToJson: false)
class Message {
  Message({
    required this.accountKeys,
    required this.recentBlockhash,
    required this.instructions,
    this.header,
  });

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  final List<AccountKey> accountKeys;
  final List<int>? header;
  final String recentBlockhash;
  final List<Instruction> instructions;
}
