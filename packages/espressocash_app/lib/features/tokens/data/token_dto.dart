import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'token_dto.g.dart';

@immutable
@JsonSerializable(createToJson: true)
class TokenDTO {
  const TokenDTO({
    required this.chainId,
    required this.address,
    required this.symbol,
    required this.name,
    required this.decimals,
    required this.logoURI,
    required this.tags,
    required this.extensions,
  });

  factory TokenDTO.fromJson(Map<String, dynamic> data) =>
      _$TokenDTOFromJson(data);

  final int chainId;
  final String address;
  final String symbol;
  final String name;
  final int decimals;
  final String? logoURI;
  final List<String>? tags;
  final ExtensionsDTO? extensions;

  Map<String, dynamic> toJson() => _$TokenDTOToJson(this);
}

@JsonSerializable()
class ExtensionsDTO {
  const ExtensionsDTO({this.coingeckoId});

  factory ExtensionsDTO.fromJson(Map<String, dynamic> data) =>
      _$ExtensionsDTOFromJson(data);

  final String? coingeckoId;

  Map<String, dynamic> toJson() => _$ExtensionsDTOToJson(this);
}
