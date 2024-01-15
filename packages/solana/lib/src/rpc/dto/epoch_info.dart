import 'package:json_annotation/json_annotation.dart';

part 'epoch_info.g.dart';

/// Information about an epoch
@JsonSerializable()
class EpochInfo {
  const EpochInfo({
    required this.absoluteSlot,
    required this.blockHeight,
    required this.epoch,
    required this.slotIndex,
    required this.slotsInEpoch,
    required this.transactionCount,
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

  /// Total number of transactions processed without error since genesis
  final int? transactionCount;

  Map<String, dynamic> toJson() => _$EpochInfoToJson(this);
}
