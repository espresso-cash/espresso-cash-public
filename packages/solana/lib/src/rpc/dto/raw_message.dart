import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc/dto/account_key.dart';
import 'package:solana/src/rpc/dto/instruction.dart';
import 'package:solana/src/rpc/dto/message.dart';
import 'package:solana/src/rpc/dto/parsed_message/header.dart';

part 'raw_message.g.dart';

@JsonSerializable(createToJson: false)
class RawMessage implements Message {
  const RawMessage({
    required this.accountKeys,
    required this.header,
    required this.recentBlockhash,
    required this.instructions,
  });

  factory RawMessage.fromJson(Map<String, dynamic> json) =>
      _$RawMessageFromJson(json);

  @override
  final List<AccountKey> accountKeys;

  @override
  final Header? header;

  @override
  final String recentBlockhash;

  @override
  final List<Instruction> instructions;
}
