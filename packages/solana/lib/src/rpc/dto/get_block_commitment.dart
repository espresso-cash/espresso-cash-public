part of 'dto.dart';

@JsonSerializable(createToJson: false)
class BlockCommitment {
  BlockCommitment({this.commitment, required this.totalStake});

  factory BlockCommitment.fromJson(Map<String, dynamic> json) =>
      _$BlockCommitmentFromJson(json);

  final List<int>? commitment;
  final int totalStake;
}
