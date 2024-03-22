import '../../../gen/assets.gen.dart';

enum Blockchain {
  arbitrum,
  polygon,
  ethereum,
}

extension BlockchainExt on Blockchain {
  String get displayName => switch (this) {
        Blockchain.arbitrum => 'Arbitrum',
        Blockchain.polygon => 'Polygon',
        Blockchain.ethereum => 'Ethereum',
      };

  // https://docs.dln.trade/the-core-protocol/fees-and-supported-chains
  String get chainId => switch (this) {
        Blockchain.ethereum => '1',
        Blockchain.polygon => '137',
        Blockchain.arbitrum => '42161',
      };

  String get hexChainId => switch (this) {
        Blockchain.ethereum => '0x1',
        Blockchain.polygon => '0x89',
        Blockchain.arbitrum => '0xa4b1',
      };

  AssetGenImage get logo => switch (this) {
        Blockchain.ethereum => Assets.images.ethLogo,
        Blockchain.polygon => Assets.images.polygonLogo,
        Blockchain.arbitrum => Assets.images.arbitrumLogo,
      };
}

extension BlockchainIntExt on int {
  Blockchain? get blockchain => switch (this) {
        1 => Blockchain.ethereum,
        137 => Blockchain.polygon,
        42161 => Blockchain.arbitrum,
        _ => null,
      };
}

extension BlockchainStringExt on String {
  Blockchain? get fromHexChainId => switch (this) {
        '0x1' => Blockchain.ethereum,
        '0x89' => Blockchain.polygon,
        '0xa4b1' => Blockchain.arbitrum,
        _ => null,
      };
}
