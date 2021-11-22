import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/parsed_message/parsed_message.dart';

part 'transaction.g.dart';

/// A transaction
@JsonSerializable(createFactory: true, includeIfNull: false)
class Transaction {
  const Transaction({
    required this.signatures,
    required this.message,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionToJson(this);

  /// A list of base-58 encoded signatures applied to the
  /// transaction. The list is always of length
  /// message.header.numRequiredSignatures and not empty. The
  /// signature at index i corresponds to the public key at index
  /// i in message.account_keys. The first one is used as the
  /// transaction id.
  final List<String> signatures;

  /// Defines the content of the transaction.
  final ParsedMessage message;
}
