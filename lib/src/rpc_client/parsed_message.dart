part of 'rpc_client.dart';

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
