// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_multiple_accounts_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetMultipleAccountsResponse _$GetMultipleAccountsResponseFromJson(
        Map<String, dynamic> json) =>
    GetMultipleAccountsResponse(
      ValueResponse.fromJson(
          json['result'] as Map<String, dynamic>,
          (value) => (value as List<dynamic>)
              .map((e) => Account.fromJson(e as Map<String, dynamic>))
              .toList()),
    );
