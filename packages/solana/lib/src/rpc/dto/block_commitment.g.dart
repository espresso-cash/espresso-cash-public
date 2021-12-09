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
