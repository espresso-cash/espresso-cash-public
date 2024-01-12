import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc/dto/meta.dart';
import 'package:solana/src/rpc/dto/transaction.dart';
import 'package:solana/src/rpc/dto/transaction_version.dart';

part 'transaction_details.g.dart';

/// Details of a transaction
@JsonSerializable()
class TransactionDetails {
  const TransactionDetails({
    required this.slot,
    required this.transaction,
    this.blockTime,
    this.meta,
    this.version,
  });

  factory TransactionDetails.fromJson(Map<String, dynamic> json) =>
      _$TransactionDetailsFromJson(json);

  /// The slot this transaction was processed in
  final int slot;

  /// Transaction object, either in JSON format or encoded binary
  /// data, depending on encoding parameter
  final Transaction transaction;

  /// The block time
  final int? blockTime;

  /// Transaction status metadata
  final Meta? meta;

  /// Transaction version.
  /// Undefined if maxSupportedTransactionVersion is not set in request params.
  final TransactionVersion? version;

  Map<String, dynamic> toJson() => _$TransactionDetailsToJson(this);
}
