// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'return_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReturnData _$ReturnDataFromJson(Map<String, dynamic> json) => ReturnData(
      programId: json['programId'] as String,
      data: ReturnData._dataFromJson(json['data']),
    );

Map<String, dynamic> _$ReturnDataToJson(ReturnData instance) =>
    <String, dynamic>{
      'programId': instance.programId,
      'data': ReturnData._dataToJson(instance.data),
    };
