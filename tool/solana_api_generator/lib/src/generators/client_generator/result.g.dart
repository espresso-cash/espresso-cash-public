// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Result _$$_ResultFromJson(Map<String, dynamic> json) => _$_Result(
      type: json['type'] as String,
      description: json['description'] as String,
      wrapped: json['wrapped'] as bool? ?? false,
      nullable: json['nullable'] as bool? ?? false,
    );

Map<String, dynamic> _$$_ResultToJson(_$_Result instance) => <String, dynamic>{
      'type': instance.type,
      'description': instance.description,
      'wrapped': instance.wrapped,
      'nullable': instance.nullable,
    };
