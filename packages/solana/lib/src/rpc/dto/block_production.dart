import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/rpc/dto/by_identity_value.dart';
import 'package:solana/src/rpc/dto/context.dart';
import 'package:solana/src/rpc/dto/range.dart';

part 'block_production.g.dart';

/// A block production
@JsonSerializable(createToJson: false)
class BlockProduction {
  const BlockProduction({
    required this.byIdentity,
    required this.range,
  });

  factory BlockProduction.fromJson(Map<String, dynamic> json) =>
      _$BlockProductionFromJson(json);

  /// A dictionary of validator identities, as base-58 encoded
  /// strings. Value is a two element array containing the number
  /// of leader slots and the number of blocks produced.
  final Map<String, ByIdentityValue> byIdentity;

  /// Block production slot range
  final Range range;
}

@JsonSerializable(createToJson: false)
class BlockProductionResult extends ContextResult<BlockProduction> {
  const BlockProductionResult({required super.context, required super.value});

  factory BlockProductionResult.fromJson(Map<String, dynamic> json) =>
      _$BlockProductionResultFromJson(json);
}
