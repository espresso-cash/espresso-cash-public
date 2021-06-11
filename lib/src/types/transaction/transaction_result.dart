import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/types/transaction/meta.dart';
import 'package:solana/src/types/transaction/transaction.dart';

part 'transaction_result.g.dart';

@JsonSerializable(createToJson: false)
class TransactionResult {
  TransactionResult({
    this.meta,
    required this.slot,
    required this.blockTime,
    required this.transaction,
  });

  factory TransactionResult.fromJson(Map<String, dynamic> json) =>
      _$TransactionResultFromJson(json);

  final Meta? meta;
  final int slot;
  final int blockTime;
  final Transaction transaction;
}
