// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_table_lookups.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressTableLookups _$AddressTableLookupsFromJson(Map<String, dynamic> json) =>
    AddressTableLookups(
      accountKey: json['accountKey'] as String,
      writableIndexes: (json['writableIndexes'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
      readonlyIndexes: (json['readonlyIndexes'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
    );
