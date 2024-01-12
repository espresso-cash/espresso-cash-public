// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inflation_governor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InflationGovernor _$InflationGovernorFromJson(Map<String, dynamic> json) =>
    InflationGovernor(
      initial: (json['initial'] as num).toDouble(),
      terminal: (json['terminal'] as num).toDouble(),
      taper: (json['taper'] as num).toDouble(),
      foundation: (json['foundation'] as num).toDouble(),
      foundationTerm: (json['foundationTerm'] as num).toDouble(),
    );

Map<String, dynamic> _$InflationGovernorToJson(InflationGovernor instance) =>
    <String, dynamic>{
      'initial': instance.initial,
      'terminal': instance.terminal,
      'taper': instance.taper,
      'foundation': instance.foundation,
      'foundationTerm': instance.foundationTerm,
    };
