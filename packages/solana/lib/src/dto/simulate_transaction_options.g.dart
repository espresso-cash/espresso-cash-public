// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simulate_transaction_options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$SimulateTransactionOptionsToJson(
    SimulateTransactionOptions instance) {
  final val = <String, dynamic>{
    'encoding': instance.encoding,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('sigVerify', instance.sigVerify);
  writeNotNull('commitment', _$CommitmentEnumMap[instance.commitment]);
  writeNotNull('replaceRecentBlockhash', instance.replaceRecentBlockhash);
  writeNotNull('accounts', instance.accounts);
  return val;
}

const _$CommitmentEnumMap = {
  Commitment.processed: 'processed',
  Commitment.confirmed: 'confirmed',
  Commitment.finalized: 'finalized',
};
