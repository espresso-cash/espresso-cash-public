// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rpc_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RpcResponse<T> _$RpcResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    RpcResponse<T>(
      result: fromJsonT(json['result']),
    );

Map<String, dynamic> _$RpcResponseToJson<T>(
  RpcResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'result': toJsonT(instance.result),
    };
