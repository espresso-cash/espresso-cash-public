import 'package:json_annotation/json_annotation.dart';

part 'slot.g.dart';

@JsonSerializable(createToJson: false)
class Slot {
  const Slot({
    required this.parent,
    required this.slot,
    required this.type,
  });

  factory Slot.fromJson(Map<String, dynamic> json) => _$SlotFromJson(json);

  final int parent;
  final int slot;
  final String type;
}
