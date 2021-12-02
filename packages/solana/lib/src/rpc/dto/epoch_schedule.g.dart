// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'epoch_schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EpochSchedule _$EpochScheduleFromJson(Map<String, dynamic> json) =>
    EpochSchedule(
      slotsPerEpoch: json['slotsPerEpoch'] as int,
      leaderScheduleSlotOffset: json['leaderScheduleSlotOffset'] as int,
      warmup: json['warmup'] as bool,
      firstNormalEpoch: json['firstNormalEpoch'] as int,
      firstNormalSlot: json['firstNormalSlot'] as int,
    );
