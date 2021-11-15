// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeeCalculator _$FeeCalculatorFromJson(Map<String, dynamic> json) =>
    FeeCalculator(
      lamportsPerSignature: json['lamportsPerSignature'] as int,
    );

AccountInfo _$AccountInfoFromJson(Map<String, dynamic> json) => AccountInfo(
      lamports: json['lamports'] as int,
      owner: json['owner'] as String,
      data: json['data'],
      executable: json['executable'] as bool,
      rentEpoch: json['rentEpoch'] as int,
    );

BlockCommitment _$BlockCommitmentFromJson(Map<String, dynamic> json) =>
    BlockCommitment(
      commitment:
          (json['commitment'] as List<dynamic>?)?.map((e) => e as int).toList(),
      totalStake: json['totalStake'] as int,
    );

SlotRange _$SlotRangeFromJson(Map<String, dynamic> json) => SlotRange(
      firstSlot: json['firstSlot'] as int,
      lastSlot: json['lastSlot'] as int,
    );

Map<String, dynamic> _$SlotRangeToJson(SlotRange instance) => <String, dynamic>{
      'firstSlot': instance.firstSlot,
      'lastSlot': instance.lastSlot,
    };

BlockProduction _$BlockProductionFromJson(Map<String, dynamic> json) =>
    BlockProduction(
      byIdentity: (json['byIdentity'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as int).toList()),
      ),
      range: SlotRange.fromJson(json['range'] as Map<String, dynamic>),
    );

GetFeesResponse _$GetFeesResponseFromJson(Map<String, dynamic> json) =>
    GetFeesResponse(
      blockhash: json['blockhash'] as String,
      feeCalculator:
          FeeCalculator.fromJson(json['feeCalculator'] as Map<String, dynamic>),
      lastValidBlockHeight: json['lastValidBlockHeight'] as int,
    );

RecentBlockhash _$RecentBlockhashFromJson(Map<String, dynamic> json) =>
    RecentBlockhash(
      blockhash: json['blockhash'] as String,
      feeCalculator:
          FeeCalculator.fromJson(json['feeCalculator'] as Map<String, dynamic>),
    );

RpcResponse<T> _$RpcResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    RpcResponse<T>(
      context:
          RpcResponseContext.fromJson(json['context'] as Map<String, dynamic>),
      value: fromJsonT(json['value']),
    );

RpcResponseContext _$RpcResponseContextFromJson(Map<String, dynamic> json) =>
    RpcResponseContext(
      slot: json['slot'] as int,
    );
