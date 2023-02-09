import 'package:json_annotation/json_annotation.dart';

part 'highest_snapshot_slot.g.dart';

/// A Highest Snapshot Slot
@JsonSerializable(createToJson: false)
class HighestSnapshotSlot {
  const HighestSnapshotSlot({
    required this.full,
    required this.incremental,
  });

  factory HighestSnapshotSlot.fromJson(Map<String, dynamic> json) =>
      _$HighestSnapshotSlotFromJson(json);

  /// Highest full snapshot slot
  final int full;

  /// Highest incremental snapshot slot based on [full]
  final int? incremental;
}
