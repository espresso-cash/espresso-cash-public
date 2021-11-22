import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/dto/commitment.dart';
import 'package:solana/src/dto/encoding.dart';

part 'send_transaction_options.g.dart';

/// Configuration object for [RPCClient.sendTransaction()]
@JsonSerializable(createFactory: false, includeIfNull: false)
class SendTransactionOptions {
  const SendTransactionOptions({
    this.commitment,
    this.skipPreflight,
    this.maxRetries,
  });

  Map<String, dynamic> toJson() => _$SendTransactionOptionsToJson(this);

  String get encoding => 'base64';

  final Commitment? commitment;

  /// If true, skip the preflight transaction checks (default:
  /// false).
  final bool? skipPreflight;

  /// Maximum number of times for the RPC node to retry sending
  /// the transaction to the leader. If this parameter not
  /// provided, the RPC node will retry the transaction until it
  /// is finalized or until the blockhash expires.
  final int? maxRetries;
}
