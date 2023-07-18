import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_issuer_config.freezed.dart';

@freezed
class AuthIssuerConfig with _$AuthIssuerConfig {
  const factory AuthIssuerConfig({
    required String name,
    @Default(50) int maxOutstandingTokensPerIdentity,
    @Default(Duration(hours: 1)) Duration authorizationValidity,
    @Default(Duration(days: 30)) Duration reauthorizationValidity,
    @Default(Duration(minutes: 10)) Duration reauthorizationNopDuration,
  }) = _AuthIssuerConfig;
}
