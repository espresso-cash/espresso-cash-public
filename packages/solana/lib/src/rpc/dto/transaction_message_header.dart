import 'package:json_annotation/json_annotation.dart';

part 'transaction_message_header.g.dart';

/// The header of a transaction message
@JsonSerializable()
class TransactionMessageHeader {
  const TransactionMessageHeader({
    required this.numRequiredSignatures,
    required this.numReadonlySignedAccounts,
    required this.numReadonlyUnsignedAccounts,
  });

  factory TransactionMessageHeader.fromJson(Map<String, dynamic> json) =>
      _$TransactionMessageHeaderFromJson(json);

  /// The total number of signatures required to make the
  /// transaction valid. The signatures must match the first
  /// numRequiredSignatures of message.account_keys.
  final int numRequiredSignatures;

  /// The last numReadonlySignedAccounts of the signed keys are
  /// read-only accounts. Programs may process multiple
  /// transactions that load read-only accounts within a single
  /// PoH entry, but are not permitted to credit or debit
  /// lamports or modify account data. Transactions targeting the
  /// same read-write account are evaluated sequentially.
  final int numReadonlySignedAccounts;

  /// The last numReadonlyUnsignedAccounts of the unsigned keys
  /// are read-only accounts.
  final int numReadonlyUnsignedAccounts;

  Map<String, dynamic> toJson() => _$TransactionMessageHeaderToJson(this);
}
