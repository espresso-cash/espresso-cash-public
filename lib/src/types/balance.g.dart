// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'balance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BalanceResponse _$BalanceResponseFromJson(Map<String, dynamic> json) {
  return BalanceResponse(
    json['result'] == null
        ? null
        : ValueResponse.fromJson(
            json['result'] as Map<String, dynamic>, (value) => value as int),
  );
}
