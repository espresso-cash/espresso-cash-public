import 'package:cryptoplease/bl/tokens/extensions.dart';
import 'package:cryptoplease/config.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:solana/metaplex.dart';
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

  const factory Token.solana() = _SolanaToken;

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

  const factory Token.nft({
    required String address,
    required Metadata metadata,
  }) = NonFungibleToken;

  factory Token.fromJson(Map<String, dynamic> data) => _$TokenFromJson(data);

  static const sol = Token.solana();

  bool get isSolana => this is _SolanaToken;

  String? get coingeckoId => extensions?.coingeckoId;

  bool get isStablecoin => tags?.contains('stablecoin') == true;

  Ed25519HDPublicKey get publicKey => Ed25519HDPublicKey.fromBase58(address);

  @override
  String toString() => '$address: $chainId/$symbol/$name';

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
          name: 'SOL',
          symbol: 'SOL',
        );
}

class SplToken extends Token {
  const SplToken({
    required int chainId,
    required String address,
    required String symbol,
    required String name,
    required int decimals,
    String? logoURI,
    required List<String> tags,
    Extensions? extensions,
  }) : super(
          chainId: chainId,
          address: address,
          symbol: symbol,
          name: name,
          decimals: decimals,
          logoURI: logoURI,
          tags: tags,
          extensions: extensions,
        );
}

class NonFungibleToken extends SplToken {
  const NonFungibleToken({
    required String address,
    required this.metadata,
  }) : super(
          chainId: currentChainId,
          address: address,
          symbol: '',
          name: '',
          decimals: 0,
          tags: const <String>[],
        );

  final Metadata metadata;
}

class UnknownToken extends SplToken {
  const UnknownToken({
    required String address,
    int decimals = 0,
  }) : super(
          chainId: currentChainId,
          address: address,
          symbol: '',
          name: '',
          decimals: decimals,
          tags: const <String>[],
        );
}
