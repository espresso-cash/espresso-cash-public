// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DataSizeFilter _$$DataSizeFilterFromJson(Map<String, dynamic> json) =>
    _$DataSizeFilter(
      json['dataSize'] as int,
    );

Map<String, dynamic> _$$DataSizeFilterToJson(_$DataSizeFilter instance) =>
    <String, dynamic>{
      'dataSize': instance.dataSize,
    };

_$MemcmpFilter _$$MemcmpFilterFromJson(Map<String, dynamic> json) =>
    _$MemcmpFilter(
      offset: json['offset'] as int,
      bytes: json['bytes'] as String,
    );

Map<String, dynamic> _$$MemcmpFilterToJson(_$MemcmpFilter instance) =>
    <String, dynamic>{
      'offset': instance.offset,
      'bytes': instance.bytes,
    };
