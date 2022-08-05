import 'package:json_annotation/json_annotation.dart';

part 'auth_issuer_config.g.dart';

@JsonSerializable()
class AuthIssuerConfig {
  const AuthIssuerConfig({
    required this.name,
    this.maxOutstandingTokensPerIdentity = 50,
    this.authorizationValidity = const Duration(hours: 1),
    this.reauthorizationValidity = const Duration(days: 30),
    this.reauthorizationNopDuration = const Duration(minutes: 10),
  });
  factory AuthIssuerConfig.fromJson(Map<String, dynamic> json) =>
      _$AuthIssuerConfigFromJson(json);

  Map<String, dynamic> toJson() => _$AuthIssuerConfigToJson(this);

  final String name;
  final int maxOutstandingTokensPerIdentity;
  final Duration authorizationValidity;
  final Duration reauthorizationValidity;
  final Duration reauthorizationNopDuration;
}
