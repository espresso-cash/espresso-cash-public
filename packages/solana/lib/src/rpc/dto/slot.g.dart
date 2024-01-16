// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Slot _$SlotFromJson(Map<String, dynamic> json) => Slot(
      parent: json['parent'] as int,
      slot: json['slot'] as int,
      type: json['type'] as String,
    );

Map<String, dynamic> _$SlotToJson(Slot instance) => <String, dynamic>{
      'parent': instance.parent,
      'slot': instance.slot,
      'type': instance.type,
    };
