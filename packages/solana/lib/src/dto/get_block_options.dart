import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/dto/commitment.dart';
import 'package:solana/src/dto/encoding.dart';
import 'package:solana/src/dto/transaction_detail_level.dart';

part 'get_block_options.g.dart';

/// Configuration object for [RPCClient.getBlock()]
@JsonSerializable(createFactory: true, includeIfNull: false)
class GetBlockOptions {
  const GetBlockOptions({
    this.encoding,
    this.transactionDetails,
    this.rewards,
    this.commitment,
  });

  factory GetBlockOptions.fromJson(Map<String, dynamic> json) =>
      _$GetBlockOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$GetBlockOptionsToJson(this);

  final Encoding? encoding;

  /// Level of transaction detail to return.
  final TransactionDetailLevel? transactionDetails;

  /// Whether to populate the rewards array. If parameter not
  /// provided, the default includes rewards.
  final bool? rewards;

  final Commitment? commitment;
}
