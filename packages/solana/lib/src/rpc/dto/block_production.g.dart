// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'block_production.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlockProduction _$BlockProductionFromJson(Map<String, dynamic> json) =>
    BlockProduction(
      byIdentity: (json['byIdentity'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, ByIdentityValue.fromJson(e)),
      ),
      range: Range.fromJson(json['range'] as Map<String, dynamic>),
    );
