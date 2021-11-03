// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simulate_tx_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimulateTxResult _$SimulateTxResultFromJson(Map<String, dynamic> json) =>
    SimulateTxResult(
      err: json['err'],
      logs: json['logs'] as List<dynamic>?,
    );

SimulateTxResultResponse _$SimulateTxResultResponseFromJson(
        Map<String, dynamic> json) =>
    SimulateTxResultResponse(
      ValueResponse.fromJson(json['result'] as Map<String, dynamic>,
          (value) => SimulateTxResult.fromJson(value as Map<String, dynamic>)),
    );
