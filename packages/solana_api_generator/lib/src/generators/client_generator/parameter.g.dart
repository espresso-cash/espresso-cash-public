// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parameter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Parameter _$$_ParameterFromJson(Map<String, dynamic> json) => _$_Parameter(
      type: json['type'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      url: json['url'] as String?,
      isOptional: json['is_optional'] as bool,
      defaultValue: json['default_value'],
    );

Map<String, dynamic> _$$_ParameterToJson(_$_Parameter instance) =>
    <String, dynamic>{
      'type': instance.type,
      'name': instance.name,
      'description': instance.description,
      'url': instance.url,
      'is_optional': instance.isOptional,
      'default_value': instance.defaultValue,
    };
