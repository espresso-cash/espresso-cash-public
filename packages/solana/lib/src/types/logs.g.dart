// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Logs _$LogsFromJson(Map<String, dynamic> json) => Logs(
      signature: json['signature'] as String,
      logs: (json['logs'] as List<dynamic>).map((e) => e as String).toList(),
      err: json['err'],
    );

Map<String, dynamic> _$LogsToJson(Logs instance) => <String, dynamic>{
      'signature': instance.signature,
      'err': instance.err,
      'logs': instance.logs,
    };
