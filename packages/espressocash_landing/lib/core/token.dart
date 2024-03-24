import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:solana/solana.dart';

import '../../config.dart';

part 'token.g.dart';

@immutable
@JsonSerializable(createToJson: false)
class Token {
  const Token({
    required this.address,
    required this.symbol,
    required this.name,
    required this.decimals,
  });

  static const usdc = isProd ? _UsdcMainToken() : _UsdcDevToken();

  Ed25519HDPublicKey get publicKey => Ed25519HDPublicKey.fromBase58(address);

  @override
  String toString() => '$address: $symbol/$name';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Token && address == other.address;

  @override
  int get hashCode => Object.hash(address, symbol);

  final String address;
  final String symbol;
  final String name;
  final int decimals;
}

class SplToken extends Token {
  const SplToken({
    required super.address,
    required super.symbol,
    required super.name,
    required super.decimals,
  });
}

class _UsdcMainToken extends SplToken {
  const _UsdcMainToken()
      : super(
          address: 'EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v',
          decimals: 6,
          name: 'USD Coin',
          symbol: 'USDC',
        );
}

class _UsdcDevToken extends SplToken {
  const _UsdcDevToken()
      : super(
          address: '4zMMC9srt5Ri5X14GAgXhaHii3GnPAEERYPJgZJDncDU',
          decimals: 6,
          name: 'USD Coin',
          symbol: 'USDC',
        );
}
