// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'latest_blockhash.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LatestBlockhash _$LatestBlockhashFromJson(Map<String, dynamic> json) =>
    LatestBlockhash(
      blockhash: json['blockhash'] as String,
      lastValidBlockHeight: json['lastValidBlockHeight'] as int,
    );

LatestBlockhashResult _$LatestBlockhashResultFromJson(
        Map<String, dynamic> json) =>
    LatestBlockhashResult(
      value: LatestBlockhash.fromJson(json['value'] as Map<String, dynamic>),
      context: Context.fromJson(json['context'] as Map<String, dynamic>),
    );
