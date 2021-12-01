// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataSizeFilter _$DataSizeFilterFromJson(Map<String, dynamic> json) =>
    DataSizeFilter(
      json['dataSize'] as int,
    );

Map<String, dynamic> _$DataSizeFilterToJson(DataSizeFilter instance) =>
    <String, dynamic>{
      'dataSize': instance.dataSize,
    };

MemcmpFilter _$MemcmpFilterFromJson(Map<String, dynamic> json) => MemcmpFilter(
      MemcmpFilterValue.fromJson(json['memcmp'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MemcmpFilterToJson(MemcmpFilter instance) =>
    <String, dynamic>{
      'memcmp': instance.memcmp.toJson(),
    };

MemcmpFilterValue _$MemcmpFilterValueFromJson(Map<String, dynamic> json) =>
    MemcmpFilterValue(
      offset: json['offset'] as int,
      bytes: json['bytes'] as String,
    );

Map<String, dynamic> _$MemcmpFilterValueToJson(MemcmpFilterValue instance) =>
    <String, dynamic>{
      'offset': instance.offset,
      'bytes': instance.bytes,
    };
