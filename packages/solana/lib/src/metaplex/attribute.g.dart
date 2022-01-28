// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attribute.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Attribute _$AttributeFromJson(Map<String, dynamic> json) => Attribute(
      traitType: json['trait_type'] as String,
      value: json['value'],
    );

Map<String, dynamic> _$AttributeToJson(Attribute instance) => <String, dynamic>{
      'trait_type': instance.traitType,
      'value': instance.value,
    };
