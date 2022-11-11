import '../../../core/tokens/token.dart';

class CoingeckoToken extends Token {
  const CoingeckoToken({
    required super.chainId,
    required super.address,
    required super.symbol,
    required super.name,
    required super.decimals,
    required super.logoURI,
    required super.tags,
    required super.extensions,
    required this.currentPrice,
    required this.marketCapRank,
  });

  final double currentPrice;
  final int marketCapRank;
}
