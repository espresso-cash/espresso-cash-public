// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Token _$TokenFromJson(Map<String, dynamic> json) => Token(
      chainId: json['chainId'] as int,
      address: json['address'] as String,
      symbol: json['symbol'] as String,
      name: json['name'] as String,
      decimals: json['decimals'] as int,
      logoURI: json['logoURI'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      extensions: json['extensions'] == null
          ? null
          : Extensions.fromJson(json['extensions'] as Map<String, dynamic>),
    );

Extensions _$ExtensionsFromJson(Map<String, dynamic> json) => Extensions(
      coingeckoId: json['coingeckoId'] as String?,
    );

Map<String, dynamic> _$ExtensionsToJson(Extensions instance) =>
    <String, dynamic>{
      'coingeckoId': instance.coingeckoId,
    };

ParsedContent _$ParsedContentFromJson(Map<String, dynamic> json) =>
    ParsedContent(
      timestamp: DateTime.parse(json['timestamp'] as String),
      tokens: (json['tokens'] as List<dynamic>)
          .map((e) => Token.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
