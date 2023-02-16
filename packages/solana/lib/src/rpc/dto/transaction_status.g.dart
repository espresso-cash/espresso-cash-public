// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionStatus _$TransactionStatusFromJson(Map<String, dynamic> json) =>
    TransactionStatus(
      err: json['err'],
      logs: (json['logs'] as List<dynamic>?)?.map((e) => e as String).toList(),
      accounts: (json['accounts'] as List<dynamic>?)
          ?.map((e) => Account.fromJson(e as Map<String, dynamic>))
          .toList(),
      unitsConsumed: json['unitsConsumed'] as int?,
      returnData: json['returnData'] == null
          ? null
          : ReturnData.fromJson(json['returnData'] as Map<String, dynamic>),
    );

TransactionStatusResult _$TransactionStatusResultFromJson(
        Map<String, dynamic> json) =>
    TransactionStatusResult(
      context: Context.fromJson(json['context'] as Map<String, dynamic>),
      value: TransactionStatus.fromJson(json['value'] as Map<String, dynamic>),
    );
