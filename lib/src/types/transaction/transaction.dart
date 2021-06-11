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
