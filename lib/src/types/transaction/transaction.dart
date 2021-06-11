import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/types/transaction/message.dart';

part 'transaction.g.dart';

enum ProgramType {
  @JsonValue('system')
  system,
  @JsonValue('spl-memo')
  memo,
}

/// A generic transaction as returned by the `getTransaction` RPC
/// method
@JsonSerializable(createToJson: false)
class Transaction {
  Transaction({
    this.message,
    required this.signatures,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  final List<String> signatures;
  final TxMessage? message;
}
