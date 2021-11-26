// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_program_accounts_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetProgramAccountsResponse _$GetProgramAccountsResponseFromJson(
        Map<String, dynamic> json) =>
    GetProgramAccountsResponse(
      (json['result'] as List<dynamic>)
          .map((e) => AccountWithPubkey.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
