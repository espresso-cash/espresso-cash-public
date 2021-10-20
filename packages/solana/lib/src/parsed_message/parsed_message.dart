import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:solana/src/dto/account_key.dart';
import 'package:solana/src/parsed_message/parsed_instruction.dart';
import 'package:solana/src/parsed_message/parsed_message_header.dart';

export 'parsed_instruction.dart';
export 'parsed_spl_token_instruction.dart';
export 'parsed_system_instruction.dart';

part 'parsed_message.freezed.dart';
part 'parsed_message.g.dart';

/// A parsed message that is part of a [Transaction] object.
@freezed
class ParsedMessage with _$ParsedMessage {
  const factory ParsedMessage({
    required List<AccountKey> accountKeys,
    required ParsedMessageHeader? header,
    required String recentBlockhash,
    required List<ParsedInstruction> instructions,
  }) = _ParsedMessage;

  factory ParsedMessage.fromJson(Map<String, dynamic> json) =>
      _$ParsedMessageFromJson(json);
}
