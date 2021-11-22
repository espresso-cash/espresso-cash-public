import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/dto/vote_account.dart';
import 'package:solana/src/dto/vote_account.dart';

part 'vote_accounts.g.dart';

/// Result of calling [RPCClient.getVoteAccounts()]
@JsonSerializable(createFactory: true, includeIfNull: false)
class VoteAccounts {
  const VoteAccounts({
    required this.current,
    required this.delinquent,
  });

  factory VoteAccounts.fromJson(Map<String, dynamic> json) =>
      _$VoteAccountsFromJson(json);

  Map<String, dynamic> toJson() => _$VoteAccountsToJson(this);

  /// Current vote account
  final List<VoteAccount> current;

  /// Delinquent vote account
  final List<VoteAccount> delinquent;
}
