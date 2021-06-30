import 'package:json_annotation/json_annotation.dart';

part 'meta.g.dart';

/// Metadata of a [TransactionResponse] object.
@JsonSerializable(createToJson: false)
class Meta {
  Meta({
    this.err,
    this.rewards,
    required this.fee,
    required this.preBalances,
    required this.postBalances,
    required this.innerInstructions,
    required this.preTokenBalances,
    required this.postTokenBalances,
    required this.logMessages,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);

  final Object? err;
  final int fee;
  final List<dynamic> preBalances;
  final List<dynamic> postBalances;
  final List<dynamic> innerInstructions;
  final List<dynamic> preTokenBalances;
  final List<dynamic> postTokenBalances;
  final List<String> logMessages;
  final List<Reward>? rewards;
}

/// A [Reward] which is part of a [Meta] object.
@JsonSerializable(createToJson: false)
class Reward {
  Reward({
    required this.pubkey,
    required this.lamports,
    required this.postBalance,
    required this.rewardType,
  });

  factory Reward.fromJson(Map<String, dynamic> json) => _$RewardFromJson(json);

  final String pubkey;
  final int lamports;
  final int postBalance;
  final String rewardType;
}
