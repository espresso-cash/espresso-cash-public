import 'package:json_annotation/json_annotation.dart';

part 'slot.g.dart';

@JsonSerializable(createToJson: false)
class Slot {
  const Slot({
    required this.parent,
    required this.slot,
    required this.type,
  });

  final int parent;
  final int slot;
  final String type;
}
