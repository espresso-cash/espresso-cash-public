import 'package:json_annotation/json_annotation.dart';

part 'address_table_lookups.g.dart';

/// An AddressTableLookups
@JsonSerializable()
class AddressTableLookups {
  const AddressTableLookups({
    required this.accountKey,
    required this.writableIndexes,
    required this.readonlyIndexes,
  });

  factory AddressTableLookups.fromJson(Map<String, dynamic> json) =>
      _$AddressTableLookupsFromJson(json);

  /// Base-58 encoded public key for an address lookup table account.
  final String accountKey;

  /// List of indices used to load addresses of writable accounts from a lookup table.
  final List<int> writableIndexes;

  /// List of indices used to load addresses of readonly accounts from a lookup table.
  final List<int> readonlyIndexes;

  Map<String, dynamic> toJson() => _$AddressTableLookupsToJson(this);
}
