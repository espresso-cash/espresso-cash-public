import 'package:json_annotation/json_annotation.dart';

part 'saved.g.dart';

@JsonSerializable()
class TokenAccount {
  const TokenAccount({
    required this.decimals,
    this.freezeAuthority,
    required this.isInitialized,
    required this.mintAuthority,
    required this.supply,
  });

  factory TokenAccount.fromJson(Map<String, dynamic> json) =>
      _$TokenAccountFromJson(json);

  final int decimals;
  final String? freezeAuthority;
  final bool isInitialized;
  final String mintAuthority;
  final String supply;
}
