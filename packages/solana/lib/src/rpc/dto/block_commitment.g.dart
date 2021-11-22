// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'block_commitment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlockCommitment _$BlockCommitmentFromJson(Map<String, dynamic> json) =>
    BlockCommitment(
      commitment:
          (json['commitment'] as List<dynamic>?)?.map((e) => e as int).toList(),
      totalStake: json['totalStake'] as int,
    );

Map<String, dynamic> _$BlockCommitmentToJson(BlockCommitment instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('commitment', instance.commitment);
  val['totalStake'] = instance.totalStake;
  return val;
}
