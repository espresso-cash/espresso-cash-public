import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/dto/commitment.dart';

part 'get_signatures_for_address_options.g.dart';

/// Configuration object for
/// [RPCClient.getSignaturesForAddress()]
@JsonSerializable(createFactory: true, includeIfNull: false)
class GetSignaturesForAddressOptions {
  const GetSignaturesForAddressOptions({
    this.limit,
    this.before,
    this.until,
    this.commitment,
  });

  factory GetSignaturesForAddressOptions.fromJson(Map<String, dynamic> json) =>
      _$GetSignaturesForAddressOptionsFromJson(json);

  Map<String, dynamic> toJson() => _$GetSignaturesForAddressOptionsToJson(this);

  /// Maximum transaction signatures to return (between 1 and
  /// 1,000, default: 1,000).
  final int? limit;

  /// Start searching backwards from this transaction signature.
  /// If not provided the search starts from the top of the
  /// highest max confirmed block.
  final String? before;

  /// Search until this transaction signature, if found before
  /// limit reached.
  final String? until;

  final Commitment? commitment;
}
