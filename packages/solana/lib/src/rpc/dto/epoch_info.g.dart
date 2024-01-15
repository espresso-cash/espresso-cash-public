// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'epoch_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EpochInfo _$EpochInfoFromJson(Map<String, dynamic> json) => EpochInfo(
      absoluteSlot: json['absoluteSlot'] as int,
      blockHeight: json['blockHeight'] as int,
      epoch: json['epoch'] as int,
      slotIndex: json['slotIndex'] as int,
      slotsInEpoch: json['slotsInEpoch'] as int,
      transactionCount: json['transactionCount'] as int?,
    );

Map<String, dynamic> _$EpochInfoToJson(EpochInfo instance) => <String, dynamic>{
      'absoluteSlot': instance.absoluteSlot,
      'blockHeight': instance.blockHeight,
      'epoch': instance.epoch,
      'slotIndex': instance.slotIndex,
      'slotsInEpoch': instance.slotsInEpoch,
      'transactionCount': instance.transactionCount,
    };
