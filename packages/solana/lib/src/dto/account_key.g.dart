// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_key.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AccountKey _$$_AccountKeyFromJson(Map<String, dynamic> json) =>
    _$_AccountKey(
      pubkey: json['pubkey'] as String,
      writable: json['writable'] as bool,
      signer: json['signer'] as bool,
    );

Map<String, dynamic> _$$_AccountKeyToJson(_$_AccountKey instance) =>
    <String, dynamic>{
      'pubkey': instance.pubkey,
      'writable': instance.writable,
      'signer': instance.signer,
    };
