import '../../gen/assets.gen.dart';

enum Blockchain { solana, ethereum, polygon }

extension BlockchainExt on Blockchain {
  String get name => switch (this) {
        Blockchain.solana => 'Solana',
        Blockchain.ethereum => 'Ethereum',
        Blockchain.polygon => 'Polygon',
      };

  // https://docs.dln.trade/the-core-protocol/fees-and-supported-chains
  String get chainId => switch (this) {
        Blockchain.solana => '7565164',
        Blockchain.ethereum => '1',
        Blockchain.polygon => '137',
      };

  AssetGenImage get logo => switch (this) {
        Blockchain.solana => Assets.landing.solanaLogo,
        Blockchain.ethereum => Assets.landing.ethLogo,
        Blockchain.polygon => Assets.landing.polygonLogo,
      };
}
