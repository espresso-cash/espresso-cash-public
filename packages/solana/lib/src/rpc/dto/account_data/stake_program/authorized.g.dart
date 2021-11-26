// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authorized.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Authorized _$AuthorizedFromJson(Map<String, dynamic> json) => Authorized(
      staker: json['staker'] as String,
      withdrawer: json['withdrawer'] as String,
    );

Map<String, dynamic> _$AuthorizedToJson(Authorized instance) =>
    <String, dynamic>{
      'staker': instance.staker,
      'withdrawer': instance.withdrawer,
    };
