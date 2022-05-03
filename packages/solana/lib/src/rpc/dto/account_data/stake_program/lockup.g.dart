// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lockup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lockup _$LockupFromJson(Map<String, dynamic> json) => Lockup(
      custodian: json['custodian'] as String,
      epoch: BigInt.parse(json['epoch'] as String),
      unixTimestamp: BigInt.parse(json['unixTimestamp'] as String),
    );

Map<String, dynamic> _$LockupToJson(Lockup instance) => <String, dynamic>{
      'custodian': instance.custodian,
      'epoch': instance.epoch.toString(),
      'unixTimestamp': instance.unixTimestamp.toString(),
    };
