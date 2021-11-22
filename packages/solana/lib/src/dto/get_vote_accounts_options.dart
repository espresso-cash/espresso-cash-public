import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/dto/commitment.dart';

part 'get_vote_accounts_options.g.dart';

/// Configuration object for [RPCClient.getVoteAccounts()]
@JsonSerializable(createFactory: true, includeIfNull: false)
class GetVoteAccountsOptions {
  const GetVoteAccountsOptions({
    this.commitment,
    this.votePubKey,
    this.keepUnstakedDelinquents,
    this.delinquentSlotDistance,
  });

  factory GetVoteAccountsOptions.fromJson(Map<String, dynamic> json) =>
      _$GetVoteAccountsOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$GetVoteAccountsOptionsToJson(this);

  final Commitment? commitment;

  /// Only return results for this validator vote address
  /// (base-58 encoded)
  final String? votePubKey;

  /// Do not filter out delinquent validators with no stake
  final bool? keepUnstakedDelinquents;

  /// Specify the number of slots behind the tip that a validator
  /// must fall to be considered delinquent. NOTE: For the sake
  /// of consistency between ecosystem products, it is not
  /// recommended that this argument be specified.
  final int? delinquentSlotDistance;
}
