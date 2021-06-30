import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc_client/account_key.dart';
import 'package:solana/src/rpc_client/parsed_instruction.dart';
import 'package:solana/src/rpc_client/parsed_message_header.dart';

part 'parsed_message.g.dart';

/// A parsed message that is part of a [Transaction] object.
@JsonSerializable(createToJson: false)
class ParsedMessage {
  ParsedMessage({
    this.header,
    required this.accountKeys,
    required this.recentBlockhash,
    required this.instructions,
  });

  factory ParsedMessage.fromJson(Map<String, dynamic> json) =>
      _$ParsedMessageFromJson(json);

  final List<AccountKey> accountKeys;
  final ParsedMessageHeader? header;
  final String recentBlockhash;
  final List<ParsedInstruction> instructions;
}
