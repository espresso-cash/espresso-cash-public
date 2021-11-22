// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_signature_statuses_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSignatureStatusesOptions _$GetSignatureStatusesOptionsFromJson(
        Map<String, dynamic> json) =>
    GetSignatureStatusesOptions(
      searchTransactionHistory: json['searchTransactionHistory'] as bool?,
    );

Map<String, dynamic> _$GetSignatureStatusesOptionsToJson(
    GetSignatureStatusesOptions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('searchTransactionHistory', instance.searchTransactionHistory);
  return val;
}
