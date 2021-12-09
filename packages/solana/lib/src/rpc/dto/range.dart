import 'package:json_annotation/json_annotation.dart';

part 'range.g.dart';

/// A range of bytes
@JsonSerializable(includeIfNull: false)
class Range {
  const Range({
    required this.firstSlot,
    required this.lastSlot,
  });

  factory Range.fromJson(Map<String, dynamic> json) => _$RangeFromJson(json);

  Map<String, dynamic> toJson() => _$RangeToJson(this);

  /// First slot of the block production information (inclusive)
  final int firstSlot;

  /// Last slot of block production information (inclusive)
  final int lastSlot;
}
