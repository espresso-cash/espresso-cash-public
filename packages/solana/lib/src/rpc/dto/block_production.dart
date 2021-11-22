import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc/dto/by_identity_value.dart';
import 'package:solana/src/rpc/dto/range.dart';

part 'block_production.g.dart';

/// A block production
@JsonSerializable(createFactory: true, includeIfNull: false)
class BlockProduction {
  const BlockProduction({
    required this.byIdentity,
    required this.range,
  });

  factory BlockProduction.fromJson(Map<String, dynamic> json) =>
      _$BlockProductionFromJson(json);

  Map<String, dynamic> toJson() => _$BlockProductionToJson(this);

  /// A dictionary of validator identities, as base-58 encoded
  /// strings. Value is a two element array containing the number
  /// of leader slots and the number of blocks produced.
  final Map<String, ByIdentityValue> byIdentity;

  /// Block production slot range
  final Range range;
}
