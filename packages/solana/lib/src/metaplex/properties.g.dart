// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'properties.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UnknownImpl _$$UnknownImplFromJson(Map<String, dynamic> json) =>
    _$UnknownImpl(
      $type: json['category'] as String?,
    );

Map<String, dynamic> _$$UnknownImplToJson(_$UnknownImpl instance) =>
    <String, dynamic>{
      'category': instance.$type,
    };

_$VideoImpl _$$VideoImplFromJson(Map<String, dynamic> json) => _$VideoImpl(
      files: (json['files'] as List<dynamic>)
          .map((e) => File.fromJson(e as Map<String, dynamic>))
          .toList(),
      $type: json['category'] as String?,
    );

Map<String, dynamic> _$$VideoImplToJson(_$VideoImpl instance) =>
    <String, dynamic>{
      'files': instance.files.map((e) => e.toJson()).toList(),
      'category': instance.$type,
    };

_$ImageImpl _$$ImageImplFromJson(Map<String, dynamic> json) => _$ImageImpl(
      files: (json['files'] as List<dynamic>)
          .map((e) => File.fromJson(e as Map<String, dynamic>))
          .toList(),
      $type: json['category'] as String?,
    );

Map<String, dynamic> _$$ImageImplToJson(_$ImageImpl instance) =>
    <String, dynamic>{
      'files': instance.files.map((e) => e.toJson()).toList(),
      'category': instance.$type,
    };

_$Model3DImpl _$$Model3DImplFromJson(Map<String, dynamic> json) =>
    _$Model3DImpl(
      files: (json['files'] as List<dynamic>)
          .map((e) => File.fromJson(e as Map<String, dynamic>))
          .toList(),
      $type: json['category'] as String?,
    );

Map<String, dynamic> _$$Model3DImplToJson(_$Model3DImpl instance) =>
    <String, dynamic>{
      'files': instance.files.map((e) => e.toJson()).toList(),
      'category': instance.$type,
    };

_$AudioImpl _$$AudioImplFromJson(Map<String, dynamic> json) => _$AudioImpl(
      files: (json['files'] as List<dynamic>)
          .map((e) => File.fromJson(e as Map<String, dynamic>))
          .toList(),
      $type: json['category'] as String?,
    );

Map<String, dynamic> _$$AudioImplToJson(_$AudioImpl instance) =>
    <String, dynamic>{
      'files': instance.files.map((e) => e.toJson()).toList(),
      'category': instance.$type,
    };

_$HtmlImpl _$$HtmlImplFromJson(Map<String, dynamic> json) => _$HtmlImpl(
      files: (json['files'] as List<dynamic>)
          .map((e) => File.fromJson(e as Map<String, dynamic>))
          .toList(),
      $type: json['category'] as String?,
    );

Map<String, dynamic> _$$HtmlImplToJson(_$HtmlImpl instance) =>
    <String, dynamic>{
      'files': instance.files.map((e) => e.toJson()).toList(),
      'category': instance.$type,
    };
