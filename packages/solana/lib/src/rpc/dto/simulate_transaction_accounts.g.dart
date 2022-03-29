// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simulate_transaction_accounts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimulateTransactionAccounts _$SimulateTransactionAccountsFromJson(
        Map<String, dynamic> json) =>
    SimulateTransactionAccounts(
      accountEncoding:
          $enumDecodeNullable(_$EncodingEnumMap, json['accountEncoding']),
      addresses: (json['addresses'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$SimulateTransactionAccountsToJson(
    SimulateTransactionAccounts instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('accountEncoding', _$EncodingEnumMap[instance.accountEncoding]);
  writeNotNull('addresses', instance.addresses);
  return val;
}

const _$EncodingEnumMap = {
  Encoding.base64: 'base64',
  Encoding.jsonParsed: 'jsonParsed',
  Encoding.base58: 'base58',
  Encoding.json: 'json',
};
