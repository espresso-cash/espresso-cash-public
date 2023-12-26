import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:solana/solana.dart';

import '../../config.dart';

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

  const factory Token.solana() = _SolanaToken;

  const factory Token.wrappedSolana() = _WrappedSolanaToken;

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

  static const usdc = isProd ? _UsdcMainToken() : _UsdcDevToken();

  static const sol = Token.solana();

  static const wrappedSol = Token.wrappedSolana();

  bool get isSolana => this is _SolanaToken;

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

class _SolanaToken extends Token {
  const _SolanaToken()
      : super(
          address: 'So11111111111111111111111111111111111111111',
          extensions: const Extensions(
            coingeckoId: 'solana',
          ),
          logoURI:
              'https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/So11111111111111111111111111111111111111112/logo.png',
          chainId: currentChainId,
          tags: const [],
          decimals: 9,
          name: 'Solana',
          symbol: 'SOL',
        );
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

class _WrappedSolanaToken extends SplToken {
  const _WrappedSolanaToken()
      : super(
          address: 'So11111111111111111111111111111111111111112',
          extensions: const Extensions(
            coingeckoId: 'wrapped-solana',
          ),
          logoURI:
              'https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/So11111111111111111111111111111111111111112/logo.png',
          chainId: currentChainId,
          tags: const [],
          decimals: 9,
          name: 'Wrapped SOL',
          symbol: 'SOL',
        );
}

class _UsdcMainToken extends SplToken {
  const _UsdcMainToken()
      : super(
          address: 'EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v',
          extensions: const Extensions(
            coingeckoId: 'usd-coin',
          ),
          logoURI:
              'https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v/logo.png',
          chainId: currentChainId,
          tags: const ['stablecoin'],
          decimals: 6,
          name: 'USD Coin',
          symbol: 'USDC',
        );
}

class _UsdcDevToken extends SplToken {
  const _UsdcDevToken()
      : super(
          address: '4zMMC9srt5Ri5X14GAgXhaHii3GnPAEERYPJgZJDncDU',
          extensions: const Extensions(
            coingeckoId: 'usd-coin',
          ),
          logoURI:
              'https://raw.githubusercontent.com/solana-labs/token-list/main/assets/mainnet/4zMMC9srt5Ri5X14GAgXhaHii3GnPAEERYPJgZJDncDU/logo.png',
          chainId: currentChainId,
          tags: const ['stablecoin'],
          decimals: 6,
          name: 'USD Coin',
          symbol: 'USDC',
        );
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
    required this.name,
    required this.logoURI,
    required this.keywords,
    required this.timestamp,
    required this.tokens,
    required this.version,
  });

  factory ParsedContent.fromJson(Map<String, dynamic> json) =>
      _$ParsedContentFromJson(json);

  final String name;
  final String? logoURI;
  final List<String> keywords;
  final DateTime timestamp;
  final List<Token> tokens;
  final Version version;
}

@JsonSerializable(createToJson: false)
class Version {
  const Version({
    required this.major,
    required this.minor,
    required this.patch,
  });

  factory Version.fromJson(Map<String, dynamic> data) =>
      _$VersionFromJson(data);

  final int major;
  final int minor;
  final int patch;
}
