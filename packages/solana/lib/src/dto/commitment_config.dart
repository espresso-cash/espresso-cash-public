import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/dto/commitment.dart';

part 'commitment_config.g.dart';

/// Configuration of the commitment for some methods
@JsonSerializable(createFactory: true, includeIfNull: false)
class CommitmentConfig {
  const CommitmentConfig({
    required this.commitment,
  });

  factory CommitmentConfig.fromJson(Map<String, dynamic> json) =>
      _$CommitmentConfigFromJson(json);

  Map<String, dynamic> toJson() => _$CommitmentConfigToJson(this);

  final Commitment? commitment;
}
