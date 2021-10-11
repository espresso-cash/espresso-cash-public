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

  final int parent;
  final int slot;
  final int timestamp;
  final String type;
}
