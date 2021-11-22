import 'package:json_annotation/json_annotation.dart';

part 'block_commitment.g.dart';

/// The commitment of a bloc
@JsonSerializable(createFactory: true, includeIfNull: false)
class BlockCommitment {
  const BlockCommitment({
    required this.commitment,
    required this.totalStake,
  });

  factory BlockCommitment.fromJson(Map<String, dynamic> json) =>
      _$BlockCommitmentFromJson(json);

  Map<String, dynamic> toJson() => _$BlockCommitmentToJson(this);

  /// Commitment, array of u64 integers logging the amount of
  /// cluster stake in lamports that has voted on the block at
  /// each depth from 0 to MAX_LOCKOUT_HISTORY + 1.
  final List<int>? commitment;

  /// Total active stake, in lamports, of the current epoch.
  final int totalStake;
}
