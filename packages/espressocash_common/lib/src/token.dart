import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:solana/solana.dart';

part 'token.g.dart';

@immutable
@JsonSerializable(createToJson: false)
class Token {
  const Token({
    required this.chainId,
    required this.address,
    required this.symbol,
    required this.name,
    required this.decimals,
    required this.logoURI,
    required this.tags,
    required this.extensions,
  });

  const factory Token.splToken({
    required int chainId,
    required String address,
    required String symbol,
    required String name,
    required int decimals,
    required String logoURI,
    required List<String> tags,
    required Extensions? extensions,
  }) = SplToken;

  factory Token.fromJson(Map<String, dynamic> data) => _$TokenFromJson(data);

  String? get coingeckoId => extensions?.coingeckoId;

  bool get isStablecoin => tags?.contains('stablecoin') == true;

  Ed25519HDPublicKey get publicKey => Ed25519HDPublicKey.fromBase58(address);

  @override
  String toString() => '$address: $chainId/$symbol/$name';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Token && chainId == other.chainId && address == other.address;

  @override
  int get hashCode => Object.hash(chainId, address);

  final int chainId;
  final String address;
  final String symbol;
  final String name;
  final int decimals;
  final String? logoURI;
  final List<String>? tags;
  final Extensions? extensions;
}

class SplToken extends Token {
  const SplToken({
    required super.chainId,
    required super.address,
    required super.symbol,
    required super.name,
    required super.decimals,
    super.logoURI,
    required List<String> super.tags,
    super.extensions,
  });
}

@JsonSerializable()
class Extensions {
  const Extensions({
    this.coingeckoId,
  });

  factory Extensions.fromJson(Map<String, dynamic> data) =>
      _$ExtensionsFromJson(data);

  Map<String, dynamic> toJson() {
    throw const FormatException('cannot convert token to json');
  }

  final String? coingeckoId;
}

@JsonSerializable(createToJson: false)
class ParsedContent {
  const ParsedContent({
    required this.timestamp,
    required this.tokens,
  });

  factory ParsedContent.fromJson(Map<String, dynamic> json) =>
      _$ParsedContentFromJson(json);

  final List<Token> tokens;
  final DateTime timestamp;
}
