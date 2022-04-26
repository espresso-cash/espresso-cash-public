import 'package:json_annotation/json_annotation.dart';

part 'supply.g.dart';

/// The total supply of tokens
@JsonSerializable(createToJson: false)
class Supply {
  const Supply({
    required this.total,
    required this.circulating,
    required this.nonCirculating,
    required this.nonCirculatingAccounts,
  });

  factory Supply.fromJson(Map<String, dynamic> json) => _$SupplyFromJson(json);

  /// Total supply in lamports.
  final int total;

  /// Circulating supply in lamports.
  final int circulating;

  /// Non-circulating supply in lamports.
  final int nonCirculating;

  /// An array of account addresses of non-circulating accounts, as strings. If
  /// `excludeNonCirculatingAccountsList` is enabled, the returned array will be
  /// empty.
  final List<String> nonCirculatingAccounts;
}
