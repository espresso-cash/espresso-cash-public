// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'properties.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Unknown _$UnknownFromJson(Map<String, dynamic> json) =>
    Unknown($type: json['category'] as String?);

Map<String, dynamic> _$UnknownToJson(Unknown instance) => <String, dynamic>{
  'category': instance.$type,
};

Video _$VideoFromJson(Map<String, dynamic> json) => Video(
  files: (json['files'] as List<dynamic>)
      .map((e) => File.fromJson(e as Map<String, dynamic>))
      .toList(),
  $type: json['category'] as String?,
);

Map<String, dynamic> _$VideoToJson(Video instance) => <String, dynamic>{
  'files': instance.files.map((e) => e.toJson()).toList(),
  'category': instance.$type,
};

Image _$ImageFromJson(Map<String, dynamic> json) => Image(
  files: (json['files'] as List<dynamic>)
      .map((e) => File.fromJson(e as Map<String, dynamic>))
      .toList(),
  $type: json['category'] as String?,
);

Map<String, dynamic> _$ImageToJson(Image instance) => <String, dynamic>{
  'files': instance.files.map((e) => e.toJson()).toList(),
  'category': instance.$type,
};

Model3D _$Model3DFromJson(Map<String, dynamic> json) => Model3D(
  files: (json['files'] as List<dynamic>)
      .map((e) => File.fromJson(e as Map<String, dynamic>))
      .toList(),
  $type: json['category'] as String?,
);

Map<String, dynamic> _$Model3DToJson(Model3D instance) => <String, dynamic>{
  'files': instance.files.map((e) => e.toJson()).toList(),
  'category': instance.$type,
};

Audio _$AudioFromJson(Map<String, dynamic> json) => Audio(
  files: (json['files'] as List<dynamic>)
      .map((e) => File.fromJson(e as Map<String, dynamic>))
      .toList(),
  $type: json['category'] as String?,
);

Map<String, dynamic> _$AudioToJson(Audio instance) => <String, dynamic>{
  'files': instance.files.map((e) => e.toJson()).toList(),
  'category': instance.$type,
};

Html _$HtmlFromJson(Map<String, dynamic> json) => Html(
  files: (json['files'] as List<dynamic>)
      .map((e) => File.fromJson(e as Map<String, dynamic>))
      .toList(),
  $type: json['category'] as String?,
);

Map<String, dynamic> _$HtmlToJson(Html instance) => <String, dynamic>{
  'files': instance.files.map((e) => e.toJson()).toList(),
  'category': instance.$type,
};
