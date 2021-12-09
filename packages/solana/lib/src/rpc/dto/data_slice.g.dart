// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_slice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataSlice _$DataSliceFromJson(Map<String, dynamic> json) => DataSlice(
      offset: json['offset'] as int?,
      length: json['length'] as int?,
    );

Map<String, dynamic> _$DataSliceToJson(DataSlice instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('offset', instance.offset);
  writeNotNull('length', instance.length);
  return val;
}
