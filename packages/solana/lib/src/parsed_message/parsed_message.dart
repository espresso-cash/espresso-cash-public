import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/dto/account_key.dart';
import 'package:solana/src/parsed_message/parsed_instruction.dart';
import 'package:solana/src/parsed_message/parsed_message_header.dart';

export 'parsed_instruction.dart';
export 'parsed_spl_token_instruction.dart';
export 'parsed_system_instruction.dart';

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
