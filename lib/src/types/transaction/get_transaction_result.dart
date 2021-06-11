import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/types/transaction/meta.dart';
import 'package:solana/src/types/transaction/transaction.dart';

part 'get_transaction_result.g.dart';

@JsonSerializable(createToJson: false)
class GetTransactionResult {
  GetTransactionResult({
    this.meta,
    required this.slot,
    required this.blockTime,
    required this.transaction,
  });

  factory GetTransactionResult.fromJson(Map<String, dynamic> json) =>
      _$GetTransactionResultFromJson(json);

  final Meta? meta;
  final int slot;
  final int blockTime;
  final Transaction transaction;
}
