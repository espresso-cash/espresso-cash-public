// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionStatus _$TransactionStatusFromJson(Map<String, dynamic> json) =>
    TransactionStatus(
      err: json['err'] as Map<String, dynamic>?,
      logs: (json['logs'] as List<dynamic>?)?.map((e) => e as String).toList(),
      accounts: (json['accounts'] as List<dynamic>?)
          ?.map((e) => Account.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TransactionStatusToJson(TransactionStatus instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('err', instance.err);
  writeNotNull('logs', instance.logs);
  writeNotNull('accounts', instance.accounts);
  return val;
}
