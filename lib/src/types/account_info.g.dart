// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountInfo _$AccountInfoFromJson(Map<String, dynamic> json) {
  return AccountInfo(
    owner: json['owner'] as String,
    lamports: json['lamports'] as int,
    executable: json['executable'] as bool,
    rentEpoch: json['rentEpoch'] as int,
    data: json['data'],
  );
}

AccountInfoResponse _$AccountInfoResponseFromJson(Map<String, dynamic> json) {
  return AccountInfoResponse(
    json['result'] == null
        ? null
        : ValueResponse.fromJson(
            json['result'] as Map<String, dynamic>,
            (value) => value == null
                ? null
                : AccountInfo.fromJson(value as Map<String, dynamic>)),
  );
}
