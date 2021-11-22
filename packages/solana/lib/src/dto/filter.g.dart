// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Filter _$FilterFromJson(Map<String, dynamic> json) => Filter(
      memcmp: FilterParams.fromJson(json['memcmp'] as Map<String, dynamic>),
      dataSize: json['dataSize'] as int,
    );

Map<String, dynamic> _$FilterToJson(Filter instance) => <String, dynamic>{
      'memcmp': instance.memcmp,
      'dataSize': instance.dataSize,
    };
