// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_transaction_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$SendTransactionOptionsToJson(
    SendTransactionOptions instance) {
  final val = <String, dynamic>{
    'encoding': instance.encoding,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('commitment', _$CommitmentEnumMap[instance.commitment]);
  writeNotNull('skipPreflight', instance.skipPreflight);
  writeNotNull('maxRetries', instance.maxRetries);
  return val;
}

const _$CommitmentEnumMap = {
  Commitment.processed: 'processed',
  Commitment.confirmed: 'confirmed',
  Commitment.finalized: 'finalized',
};
