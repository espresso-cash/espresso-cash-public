import 'package:json_annotation/json_annotation.dart';

part 'slot_update.g.dart';

@JsonSerializable(createToJson: false)
class SlotUpdate {
  const SlotUpdate({
    required this.parent,
    required this.slot,
    required this.timestamp,
    required this.type,
  });

  factory SlotUpdate.fromJson(Map<String, dynamic> json) =>
      _$SlotUpdateFromJson(json);

  final int parent;
  final int slot;
  final int timestamp;
  final String type;
}
