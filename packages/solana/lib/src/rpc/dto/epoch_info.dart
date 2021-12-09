import 'package:json_annotation/json_annotation.dart';

part 'epoch_info.g.dart';

/// Information about an epoch
@JsonSerializable(createToJson: false)
class EpochInfo {
  const EpochInfo({
    required this.absoluteSlot,
    required this.blockHeight,
    required this.epoch,
    required this.slotIndex,
    required this.slotsInEpoch,
  });

  factory EpochInfo.fromJson(Map<String, dynamic> json) =>
      _$EpochInfoFromJson(json);

  /// The current slot
  final int absoluteSlot;

  /// The current block height
  final int blockHeight;

  /// The current epoch
  final int epoch;

  /// The current slot relative to the start of the current epoch
  final int slotIndex;

  /// The number of slots in this epoch
  final int slotsInEpoch;
}
