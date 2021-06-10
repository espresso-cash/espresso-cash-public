import 'package:json_annotation/json_annotation.dart';

part 'tx_meta.g.dart';

@JsonSerializable(createToJson: false)
class TxMeta {
  TxMeta({
    this.err,
    required this.fee,
    required this.preBalances,
    required this.postBalances,
    required this.innerInstructions,
    required this.preTokenBalances,
    required this.postTokenBalances,
    required this.logMessages,
    required this.rewards,
  });

  factory TxMeta.fromJson(Map<String, dynamic> json) => _$TxMetaFromJson(json);

  final Object? err;
  final int fee;
  final List<dynamic> preBalances;
  final List<dynamic> postBalances;
  final List<dynamic> innerInstructions;
  final List<dynamic> preTokenBalances;
  final List<dynamic> postTokenBalances;
  final List<String> logMessages;
  final List<Reward> rewards;
}

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
