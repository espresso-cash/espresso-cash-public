import 'package:json_annotation/json_annotation.dart';
import 'package:solana/src/metaplex/attribute.dart';
import 'package:solana/src/metaplex/collection.dart';
import 'package:solana/src/metaplex/properties.dart';

part 'off_chain_metadata.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class OffChainMetadata {
  const OffChainMetadata({
    required this.name,
    required this.description,
    required this.symbol,
    required this.image,
    required this.properties,
    required this.attributes,
    required this.collection,
  });

  factory OffChainMetadata.fromJson(Map<String, dynamic> json) =>
      _$OffChainMetadataFromJson(json);

  final String name;
  final String description;
  final String symbol;
  final String image;
  final Properties properties;
  final List<Attribute> attributes;
  final Collection? collection;

  Map<String, dynamic> toJson() => _$OffChainMetadataToJson(this);
}
