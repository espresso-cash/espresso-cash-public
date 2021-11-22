import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/dto/commitment.dart';
import 'package:solana/src/dto/range.dart';

part 'get_block_production_options.g.dart';

/// Configuration object for [RPCClient.getBlockProduction()]
@JsonSerializable(createFactory: true, includeIfNull: false)
class GetBlockProductionOptions {
  const GetBlockProductionOptions({
    this.commitment,
    this.range,
    this.identity,
  });

  factory GetBlockProductionOptions.fromJson(Map<String, dynamic> json) =>
      _$GetBlockProductionOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$GetBlockProductionOptionsToJson(this);

  final Commitment? commitment;

  /// Slot range to return block production for. If parameter not
  /// provided, defaults to current epoch.
  final Range? range;

  /// Only return results for this validator identity (base-58
  /// encoded)
  final String? identity;
}
