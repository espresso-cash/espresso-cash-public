// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vote_accounts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoteAccounts _$VoteAccountsFromJson(Map<String, dynamic> json) => VoteAccounts(
      current: (json['current'] as List<dynamic>)
          .map((e) => VoteAccount.fromJson(e as Map<String, dynamic>))
          .toList(),
      delinquent: (json['delinquent'] as List<dynamic>)
          .map((e) => VoteAccount.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VoteAccountsToJson(VoteAccounts instance) =>
    <String, dynamic>{
      'current': instance.current.map((e) => e.toJson()).toList(),
      'delinquent': instance.delinquent.map((e) => e.toJson()).toList(),
    };
