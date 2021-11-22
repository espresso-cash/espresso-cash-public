import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc/dto/commitment.dart';
import 'package:solana/src/rpc/dto/encoding.dart';
import 'package:solana/src/rpc/dto/simulate_transaction_accounts.dart';

part 'simulate_transaction_options.g.dart';

/// Configuration object for [RPCClient.simulateTransaction()]
@JsonSerializable(createFactory: false, includeIfNull: false)
class SimulateTransactionOptions {
  const SimulateTransactionOptions({
    this.sigVerify,
    this.commitment,
    this.replaceRecentBlockhash,
    this.accounts,
  });

  Map<String, dynamic> toJson() => _$SimulateTransactionOptionsToJson(this);

  String get encoding => 'base64';

  /// If true the transaction signatures will be verified
  /// (default: false, conflicts with
  /// [SimulateTransactionOptions.replaceRecentBlockhash])
  final bool? sigVerify;

  final Commitment? commitment;

  /// If true the transaction recent blockhash will be replaced
  /// with the most recent blockhash. (default: false, conflicts
  /// with sigVerify)
  final bool? replaceRecentBlockhash;

  /// Accounts configuration object containing the following
  /// fields:
  final SimulateTransactionAccounts? accounts;
}
