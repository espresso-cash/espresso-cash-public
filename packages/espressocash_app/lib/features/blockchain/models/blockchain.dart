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

  String get name => switch (this) {
        Blockchain.solana => 'Solana',
        Blockchain.ethereum => 'Ethereum',
        Blockchain.polygon => 'Polygon',
        Blockchain.arbitrum => 'Arbitrum',
      };

  AssetGenImage get logo => switch (this) {
        Blockchain.solana => Assets.landing.solanaLogo,
        Blockchain.ethereum => Assets.landing.ethLogo,
        Blockchain.polygon => Assets.landing.polygonLogo,
        Blockchain.arbitrum => Assets.landing.polygonLogo, //TODO
      };
}
