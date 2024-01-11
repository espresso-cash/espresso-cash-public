import 'package:json_annotation/json_annotation.dart';

part 'epoch_schedule.g.dart';

/// An epoch schedule
@JsonSerializable()
class EpochSchedule {
  const EpochSchedule({
    required this.slotsPerEpoch,
    required this.leaderScheduleSlotOffset,
    required this.warmup,
    required this.firstNormalEpoch,
    required this.firstNormalSlot,
  });

  factory EpochSchedule.fromJson(Map<String, dynamic> json) =>
      _$EpochScheduleFromJson(json);

  /// The maximum number of slots in each epoch.
  final int slotsPerEpoch;

  /// The number of slots before beginning of an epoch to
  /// calculate a leader schedule for that epoch.
  final int leaderScheduleSlotOffset;

  /// Whether epochs start short and grow.
  final bool warmup;

  /// First normal-length epoch, log2(slotsPerEpoch) -
  /// log2(MINIMUM_SLOTS_PER_EPOCH).
  final int firstNormalEpoch;

  /// MINIMUM_SLOTS_PER_EPOCH * (2.pow(firstNormalEpoch) - 1).
  final int firstNormalSlot;

  Map<String, dynamic> toJson() => _$EpochScheduleToJson(this);
}
