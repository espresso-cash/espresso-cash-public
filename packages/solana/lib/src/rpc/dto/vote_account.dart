import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc/dto/epoch_credits.dart';

part 'vote_account.g.dart';

/// A list of vote accounts
@JsonSerializable()
class VoteAccount {
  const VoteAccount({
    required this.votePubkey,
    required this.nodePubkey,
    required this.activatedStake,
    required this.epochVoteAccount,
    required this.commission,
    required this.lastVote,
    required this.epochCredits,
  });

  factory VoteAccount.fromJson(Map<String, dynamic> json) =>
      _$VoteAccountFromJson(json);

  /// Vote account address, as base-58 encoded string.
  final String votePubkey;

  /// Validator identity, as base-58 encoded string.
  final String nodePubkey;

  /// The stake, in lamports, delegated to this vote account and
  /// active in this epoch.
  final int activatedStake;

  /// Bool, whether the vote account is staked for this epoch.
  final bool epochVoteAccount;

  /// Percentage (0-100) of rewards payout owed to the vote
  /// account.
  final int commission;

  /// Most recent slot voted on by this vote account.
  final int lastVote;

  /// History of how many credits earned by the end of each epoch, as an array
  /// of arrays containing: epoch, credits, previousCredits.
  final List<EpochCredits> epochCredits;

  Map<String, dynamic> toJson() => _$VoteAccountToJson(this);
}
