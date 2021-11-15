part of 'dto.dart';

@JsonSerializable()
class SlotRange {
  SlotRange({required this.firstSlot, required this.lastSlot});

  factory SlotRange.fromJson(Map<String, dynamic> json) =>
      _$SlotRangeFromJson(json);

  Map<String, dynamic> toJson() => _$SlotRangeToJson(this);

  final int firstSlot;
  final int lastSlot;
}

@JsonSerializable(createToJson: false)
class BlockProduction {
  BlockProduction({required this.byIdentity, required this.range});

  factory BlockProduction.fromJson(Map<String, dynamic> json) =>
      _$BlockProductionFromJson(json);

  final Map<String, List<int>> byIdentity;
  final SlotRange range;
}
