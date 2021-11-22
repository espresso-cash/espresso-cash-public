// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'object_member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ObjectMember _$ObjectMemberFromJson(Map<String, dynamic> json) => ObjectMember(
      type: json['type'] as String,
      description: json['description'] as String,
      name: json['name'] as String,
      defaultValue: json['default_value'],
      constantValue: json['constant_value'],
      isOptional: json['is_optional'] as bool? ?? false,
      nullable: json['nullable'] as bool? ?? false,
      fields: (json['fields'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, ObjectMember.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$ObjectMemberToJson(ObjectMember instance) =>
    <String, dynamic>{
      'type': instance.type,
      'description': instance.description,
      'name': instance.name,
      'is_optional': instance.isOptional,
      'default_value': instance.defaultValue,
      'constant_value': instance.constantValue,
      'nullable': instance.nullable,
      'fields': instance.fields,
    };
