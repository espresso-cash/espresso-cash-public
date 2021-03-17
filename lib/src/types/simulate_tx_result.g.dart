// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simulate_tx_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimulateTxResult _$SimulateTxResultFromJson(Map<String, dynamic> json) {
  return SimulateTxResult(
    err: json['err'],
    logs: json['logs'] as List,
  );
}

SimulateTxResultResponse _$SimulateTxResultResponseFromJson(
    Map<String, dynamic> json) {
  return SimulateTxResultResponse(
    json['result'] == null
        ? null
        : ValueResponse.fromJson(
            json['result'] as Map<String, dynamic>,
            (value) => value == null
                ? null
                : SimulateTxResult.fromJson(value as Map<String, dynamic>)),
  );
}
