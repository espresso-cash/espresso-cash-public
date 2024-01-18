import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc/dto/vote_account.dart';

part 'vote_accounts.g.dart';

/// Result of calling [RPCClient.getVoteAccounts()]
@JsonSerializable()
class VoteAccounts {
  const VoteAccounts({
    required this.current,
    required this.delinquent,
  });

  factory VoteAccounts.fromJson(Map<String, dynamic> json) =>
      _$VoteAccountsFromJson(json);

  /// Current vote account
  final List<VoteAccount> current;

  /// Delinquent vote account
  final List<VoteAccount> delinquent;

  Map<String, dynamic> toJson() => _$VoteAccountsToJson(this);
}
