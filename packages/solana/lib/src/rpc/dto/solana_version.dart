import 'package:json_annotation/json_annotation.dart';

part 'solana_version.g.dart';

/// The solana version
@JsonSerializable()
class SolanaVersion {
  const SolanaVersion({
    required this.solanaCore,
    required this.featureSet,
  });

  factory SolanaVersion.fromJson(Map<String, dynamic> json) =>
      _$SolanaVersionFromJson(json);

  /// Software version of solana-core.
  @JsonKey(name: 'solana-core')
  final String solanaCore;

  /// Unique identifier of current feature set.
  @JsonKey(name: 'feature-set')
  final int featureSet;

  Map<String, dynamic> toJson() => _$SolanaVersionToJson(this);
}
