// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WrappedResult _$$WrappedResultFromJson(Map<String, dynamic> json) =>
    _$WrappedResult(
      type: json['type'] as String,
      description: json['description'] as String,
      nullable: json['nullable'] as bool? ?? false,
    );

Map<String, dynamic> _$$WrappedResultToJson(_$WrappedResult instance) =>
    <String, dynamic>{
      'type': instance.type,
      'description': instance.description,
      'nullable': instance.nullable,
    };

_$SimpleResult _$$SimpleResultFromJson(Map<String, dynamic> json) =>
    _$SimpleResult(
      type: json['type'] as String,
      description: json['description'] as String,
      nullable: json['nullable'] as bool? ?? false,
    );

Map<String, dynamic> _$$SimpleResultToJson(_$SimpleResult instance) =>
    <String, dynamic>{
      'type': instance.type,
      'description': instance.description,
      'nullable': instance.nullable,
    };
