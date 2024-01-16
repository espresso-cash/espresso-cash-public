// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loaded_addresses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoadedAddresses _$LoadedAddressesFromJson(Map<String, dynamic> json) =>
    LoadedAddresses(
      writable:
          (json['writable'] as List<dynamic>).map((e) => e as String).toList(),
      readonly:
          (json['readonly'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$LoadedAddressesToJson(LoadedAddresses instance) =>
    <String, dynamic>{
      'writable': instance.writable,
      'readonly': instance.readonly,
    };
