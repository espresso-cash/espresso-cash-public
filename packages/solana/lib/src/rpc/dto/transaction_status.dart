import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc/dto/account.dart';

part 'transaction_status.g.dart';

/// The status of a transaction
@JsonSerializable(createToJson: false)
class TransactionStatus {
  const TransactionStatus({
    required this.err,
    required this.logs,
    required this.accounts,
  });

  factory TransactionStatus.fromJson(Map<String, dynamic> json) =>
      _$TransactionStatusFromJson(json);

  final Map<String, dynamic>? err;

  /// Array of log messages the transaction instructions output during
  /// execution, null if simulation failed before the transaction was able to
  /// execute (for example due to an invalid blockhash or signature verification
  /// failure).
  final List<String>? logs;

  /// Array of [Account]s with the same length as the
  /// `SimulateTransactionAccounts.addresses` array in the request.
  final List<Account>? accounts;
}
