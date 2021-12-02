// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vote_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoteAccount _$VoteAccountFromJson(Map<String, dynamic> json) => VoteAccount(
      votePubkey: json['votePubkey'] as String,
      nodePubkey: json['nodePubkey'] as String,
      activatedStake: json['activatedStake'] as int,
      epochVoteAccount: json['epochVoteAccount'] as bool,
      commission: json['commission'] as int,
      lastVote: json['lastVote'] as int,
      epochCredits: (json['epochCredits'] as List<dynamic>)
          .map((e) => EpochCredits.fromJson(e))
          .toList(),
    );
