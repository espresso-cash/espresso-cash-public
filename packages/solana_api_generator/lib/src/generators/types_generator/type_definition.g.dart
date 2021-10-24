// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'type_definition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EnumType _$$EnumTypeFromJson(Map<String, dynamic> json) => _$EnumType(
      name: json['name'] as String,
      values: (json['values'] as List<dynamic>)
          .map((e) => EnumValue.fromJson(e as Map<String, dynamic>))
          .toList(),
      description: json['description'] as String,
    );

Map<String, dynamic> _$$EnumTypeToJson(_$EnumType instance) =>
    <String, dynamic>{
      'name': instance.name,
      'values': instance.values,
      'description': instance.description,
    };

_$ObjectType _$$ObjectTypeFromJson(Map<String, dynamic> json) => _$ObjectType(
      name: json['name'] as String,
      fields: (json['fields'] as List<dynamic>)
          .map((e) => ObjectMember.fromJson(e as Map<String, dynamic>))
          .toList(),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$ObjectTypeToJson(_$ObjectType instance) =>
    <String, dynamic>{
      'name': instance.name,
      'fields': instance.fields,
      'description': instance.description,
    };

_$AliasType _$$AliasTypeFromJson(Map<String, dynamic> json) => _$AliasType(
      name: json['name'] as String,
      description: json['description'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$$AliasTypeToJson(_$AliasType instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'type': instance.type,
    };
