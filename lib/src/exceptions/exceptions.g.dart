// GENERATED CODE - DO NOT MODIFY BY HAND

part of exceptions;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonRpcError _$JsonRpcErrorFromJson(Map<String, dynamic> json) {
  return JsonRpcError(
    json['message'] as String,
    json['code'] as int,
    json['data'],
  );
}
