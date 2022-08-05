// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_issuer_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthIssuerConfig _$AuthIssuerConfigFromJson(Map<String, dynamic> json) =>
    AuthIssuerConfig(
      name: json['name'] as String,
      maxOutstandingTokensPerIdentity:
          json['maxOutstandingTokensPerIdentity'] as int? ?? 50,
      authorizationValidity: json['authorizationValidity'] == null
          ? const Duration(hours: 1)
          : Duration(microseconds: json['authorizationValidity'] as int),
      reauthorizationValidity: json['reauthorizationValidity'] == null
          ? const Duration(days: 30)
          : Duration(microseconds: json['reauthorizationValidity'] as int),
      reauthorizationNopDuration: json['reauthorizationNopDuration'] == null
          ? const Duration(minutes: 10)
          : Duration(microseconds: json['reauthorizationNopDuration'] as int),
    );

Map<String, dynamic> _$AuthIssuerConfigToJson(AuthIssuerConfig instance) =>
    <String, dynamic>{
      'name': instance.name,
      'maxOutstandingTokensPerIdentity':
          instance.maxOutstandingTokensPerIdentity,
      'authorizationValidity': instance.authorizationValidity.inMicroseconds,
      'reauthorizationValidity':
          instance.reauthorizationValidity.inMicroseconds,
      'reauthorizationNopDuration':
          instance.reauthorizationNopDuration.inMicroseconds,
    };
