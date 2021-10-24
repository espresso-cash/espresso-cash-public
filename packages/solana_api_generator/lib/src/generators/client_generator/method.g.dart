// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'method.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Method _$$_MethodFromJson(Map<String, dynamic> json) => _$_Method(
      name: json['name'] as String,
      description: json['description'] as String,
      isDeprecated: json['is_deprecated'] as bool? ?? false,
      isNew: json['is_new'] as bool? ?? false,
      result: Result.fromJson(json['result'] as Map<String, dynamic>),
      parameters: (json['parameters'] as List<dynamic>?)
          ?.map((e) => Parameter.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_MethodToJson(_$_Method instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'is_deprecated': instance.isDeprecated,
      'is_new': instance.isNew,
      'result': instance.result,
      'parameters': instance.parameters,
    };
