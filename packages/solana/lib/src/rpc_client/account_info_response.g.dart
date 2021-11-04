// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountInfoResponse _$AccountInfoResponseFromJson(Map<String, dynamic> json) =>
    AccountInfoResponse(
      ValueResponse.fromJson(json['result'] as Map<String, dynamic>,
          (value) => Account.fromJson(value as Map<String, dynamic>)),
    );
