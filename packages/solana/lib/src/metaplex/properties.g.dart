// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'properties.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$Unknown _$$UnknownFromJson(Map<String, dynamic> json) => _$Unknown(
      $type: json['category'] as String?,
    );

Map<String, dynamic> _$$UnknownToJson(_$Unknown instance) => <String, dynamic>{
      'category': instance.$type,
    };

_$Video _$$VideoFromJson(Map<String, dynamic> json) => _$Video(
      files: (json['files'] as List<dynamic>)
          .map((e) => File.fromJson(e as Map<String, dynamic>))
          .toList(),
      $type: json['category'] as String?,
    );

Map<String, dynamic> _$$VideoToJson(_$Video instance) => <String, dynamic>{
      'files': instance.files,
      'category': instance.$type,
    };

_$Image _$$ImageFromJson(Map<String, dynamic> json) => _$Image(
      files: (json['files'] as List<dynamic>)
          .map((e) => File.fromJson(e as Map<String, dynamic>))
          .toList(),
      $type: json['category'] as String?,
    );

Map<String, dynamic> _$$ImageToJson(_$Image instance) => <String, dynamic>{
      'files': instance.files,
      'category': instance.$type,
    };

_$Model3D _$$Model3DFromJson(Map<String, dynamic> json) => _$Model3D(
      files: (json['files'] as List<dynamic>)
          .map((e) => File.fromJson(e as Map<String, dynamic>))
          .toList(),
      $type: json['category'] as String?,
    );

Map<String, dynamic> _$$Model3DToJson(_$Model3D instance) => <String, dynamic>{
      'files': instance.files,
      'category': instance.$type,
    };

_$Audio _$$AudioFromJson(Map<String, dynamic> json) => _$Audio(
      files: (json['files'] as List<dynamic>)
          .map((e) => File.fromJson(e as Map<String, dynamic>))
          .toList(),
      $type: json['category'] as String?,
    );

Map<String, dynamic> _$$AudioToJson(_$Audio instance) => <String, dynamic>{
      'files': instance.files,
      'category': instance.$type,
    };

_$Html _$$HtmlFromJson(Map<String, dynamic> json) => _$Html(
      files: (json['files'] as List<dynamic>)
          .map((e) => File.fromJson(e as Map<String, dynamic>))
          .toList(),
      $type: json['category'] as String?,
    );

Map<String, dynamic> _$$HtmlToJson(_$Html instance) => <String, dynamic>{
      'files': instance.files,
      'category': instance.$type,
    };
