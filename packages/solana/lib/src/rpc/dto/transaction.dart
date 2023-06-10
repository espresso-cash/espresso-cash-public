import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc/dto/message.dart';
import 'package:solana/src/rpc/dto/parse_with_encoding.dart';

part 'transaction.g.dart';

abstract class Transaction {
  factory Transaction.fromJson(dynamic data) => parseWithEncoding(
        data,
        fromEncoded: RawTransaction.new,
        fromParsed: ParsedTransaction.fromJson,
      );
}

/// A transaction
@JsonSerializable(createToJson: false)
class ParsedTransaction implements Transaction {
  const ParsedTransaction({
    required this.signatures,
    required this.message,
  });

  factory ParsedTransaction.fromJson(Map<String, dynamic> json) =>
      _$ParsedTransactionFromJson(json);

  /// A list of base-58 encoded signatures applied to the
  /// transaction. The list is always of length
  /// message.header.numRequiredSignatures and not empty. The
  /// signature at index i corresponds to the public key at index
  /// i in message.account_keys. The first one is used as the
  /// transaction id.
  final List<String> signatures;

  /// Defines the content of the transaction.
  final Message message;
}

class RawTransaction implements Transaction {
  const RawTransaction(this.data);

  final List<int> data;
}
