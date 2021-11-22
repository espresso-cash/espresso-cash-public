// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_accounts_filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenAccountsFilter _$TokenAccountsFilterFromJson(Map<String, dynamic> json) =>
    TokenAccountsFilter(
      mint: json['mint'] as String?,
      programId: json['programId'] as String?,
    );

Map<String, dynamic> _$TokenAccountsFilterToJson(TokenAccountsFilter instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('mint', instance.mint);
  writeNotNull('programId', instance.programId);
  return val;
}
