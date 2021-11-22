import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc/dto/meta.dart';
import 'package:solana/src/rpc/dto/transaction.dart';

part 'transaction_details.g.dart';

/// Details of a transaction
@JsonSerializable(createFactory: true, includeIfNull: false)
class TransactionDetails {
  const TransactionDetails({
    required this.slot,
    required this.transaction,
    required this.blockTime,
    required this.meta,
  });

  factory TransactionDetails.fromJson(Map<String, dynamic> json) =>
      _$TransactionDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionDetailsToJson(this);

  /// the slot this transaction was processed in
  final int slot;

  /// Transaction object, either in JSON format or encoded binary
  /// data, depending on encoding parameter
  final Transaction transaction;

  ///
  final int? blockTime;

  /// transaction status metadata
  final Meta meta;
}
