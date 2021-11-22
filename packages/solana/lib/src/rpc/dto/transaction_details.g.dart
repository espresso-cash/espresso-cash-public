// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionDetails _$TransactionDetailsFromJson(Map<String, dynamic> json) =>
    TransactionDetails(
      slot: json['slot'] as int,
      transaction:
          Transaction.fromJson(json['transaction'] as Map<String, dynamic>),
      blockTime: json['blockTime'] as int?,
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TransactionDetailsToJson(TransactionDetails instance) {
  final val = <String, dynamic>{
    'slot': instance.slot,
    'transaction': instance.transaction,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('blockTime', instance.blockTime);
  val['meta'] = instance.meta;
  return val;
}
