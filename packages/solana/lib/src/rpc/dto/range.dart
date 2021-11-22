import 'package:json_annotation/json_annotation.dart';

part 'range.g.dart';

/// A range of bytes
@JsonSerializable(createFactory: true, includeIfNull: false)
class Range {
  const Range({
    required this.firstSlot,
    required this.lastSlot,
  });

  factory Range.fromJson(Map<String, dynamic> json) => _$RangeFromJson(json);

  Map<String, dynamic> toJson() => _$RangeToJson(this);

  /// first slot of the block production information (inclusive)
  final int firstSlot;

  /// last slot of block production information (inclusive)
  final int lastSlot;
}
