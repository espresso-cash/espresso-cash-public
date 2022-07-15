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
    );
