// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

File _$FileFromJson(Map<String, dynamic> json) => File(
      uri: json['uri'] as String,
      type: json['type'] as String,
      cdn: json['cdn'] as bool? ?? false,
    );

Map<String, dynamic> _$FileToJson(File instance) => <String, dynamic>{
      'uri': instance.uri,
      'type': instance.type,
      'cdn': instance.cdn,
    };
