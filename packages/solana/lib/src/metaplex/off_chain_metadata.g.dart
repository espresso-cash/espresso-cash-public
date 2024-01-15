// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'off_chain_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OffChainMetadata _$OffChainMetadataFromJson(Map<String, dynamic> json) =>
    OffChainMetadata(
      name: json['name'] as String,
      description: json['description'] as String,
      symbol: json['symbol'] as String,
      image: json['image'] as String,
      properties:
          Properties.fromJson(json['properties'] as Map<String, dynamic>),
      attributes: (json['attributes'] as List<dynamic>)
          .map((e) => Attribute.fromJson(e as Map<String, dynamic>))
          .toList(),
      collection: json['collection'] == null
          ? null
          : Collection.fromJson(json['collection'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OffChainMetadataToJson(OffChainMetadata instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'symbol': instance.symbol,
      'image': instance.image,
      'properties': instance.properties.toJson(),
      'attributes': instance.attributes.map((e) => e.toJson()).toList(),
      'collection': instance.collection?.toJson(),
    };
