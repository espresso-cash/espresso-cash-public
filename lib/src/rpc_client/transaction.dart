import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc_client/parsed_message.dart';

part 'transaction.g.dart';

/// The program type of a transaction instruction
enum ProgramType {
  @JsonValue('system')
  system,
  @JsonValue('spl-memo')
  memo,
  @JsonValue('spl-token')
  splToken,
}

/// The `transaction` field type of a [TransactionResponse] object.
@JsonSerializable(createToJson: false)
class Transaction {
  Transaction({
    this.message,
    required this.signatures,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  final List<String> signatures;
  final ParsedMessage? message;
}
