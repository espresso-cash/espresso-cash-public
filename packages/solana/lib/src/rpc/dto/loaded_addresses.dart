import 'package:json_annotation/json_annotation.dart';

part 'loaded_addresses.g.dart';

/// A Loaded Addresses
@JsonSerializable()
class LoadedAddresses {
  const LoadedAddresses({
    required this.writable,
    required this.readonly,
  });

  factory LoadedAddresses.fromJson(Map<String, dynamic> json) =>
      _$LoadedAddressesFromJson(json);

  /// Ordered list of base-58 encoded addresses for writable loaded accounts
  final List<String> writable;

  /// Ordered list of base-58 encoded addresses for readonly loaded accounts
  final List<String> readonly;

  Map<String, dynamic> toJson() => _$LoadedAddressesToJson(this);
}
