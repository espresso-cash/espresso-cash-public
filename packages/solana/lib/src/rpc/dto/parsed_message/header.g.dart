// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'header.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Header _$HeaderFromJson(Map<String, dynamic> json) => Header(
      numRequiredSignatures: json['numRequiredSignatures'] as int,
      numReadonlySignedAccounts: json['numReadonlySignedAccounts'] as int,
      numReadonlyUnsignedAccounts: json['numReadonlyUnsignedAccounts'] as int,
    );

Map<String, dynamic> _$HeaderToJson(Header instance) => <String, dynamic>{
      'numRequiredSignatures': instance.numRequiredSignatures,
      'numReadonlySignedAccounts': instance.numReadonlySignedAccounts,
      'numReadonlyUnsignedAccounts': instance.numReadonlyUnsignedAccounts,
    };
