import 'package:ethereum_addresses/ethereum_addresses.dart';
import 'package:solana/solana.dart';

import '../../../gen/assets.gen.dart';

enum Blockchain {
  solana,
  arbitrum,
  polygon,
  ethereum,
}

extension BlockchainExt on Blockchain {
  String get displayName => switch (this) {
        Blockchain.solana => 'Solana',
        Blockchain.arbitrum => 'Arbitrum',
        Blockchain.polygon => 'Polygon',
        Blockchain.ethereum => 'Ethereum',
      };

  bool validateAddress(String text) => switch (this) {
        Blockchain.solana => isValidAddress(text),
        Blockchain.arbitrum ||
        Blockchain.polygon ||
        Blockchain.ethereum =>
          isValidEthereumAddress(text)
      };

  // https://docs.dln.trade/the-core-protocol/fees-and-supported-chains
  String get chainId => switch (this) {
        Blockchain.solana => '7565164',
        Blockchain.ethereum => '1',
        Blockchain.polygon => '137',
        Blockchain.arbitrum => '42161',
      };

  String get hexChainId => switch (this) {
        Blockchain.solana => '0x74657374',
        Blockchain.ethereum => '0x1',
        Blockchain.polygon => '0x89',
        Blockchain.arbitrum => '0xa4b1',
      };

  AssetGenImage get logo => switch (this) {
        Blockchain.solana => Assets.landing.solanaLogo,
        Blockchain.ethereum => Assets.landing.ethLogo,
        Blockchain.polygon => Assets.landing.polygonLogo,
        Blockchain.arbitrum => Assets.landing.arbitrumLogo,
      };
}

extension BlockchainIntExt on int {
  Blockchain? get blockchain => switch (this) {
        1 => Blockchain.ethereum,
        137 => Blockchain.polygon,
        42161 => Blockchain.arbitrum,
        7565164 => Blockchain.solana,
        _ => null,
      };
}

extension BlockchainStringExt on String {
  Blockchain? get fromHexChainId => switch (this) {
        '0x1' => Blockchain.ethereum,
        '0x89' => Blockchain.polygon,
        '0xa4b1' => Blockchain.arbitrum,
        '0x74657374' => Blockchain.solana,
        _ => null,
      };
}
