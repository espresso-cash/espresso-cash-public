import 'package:ethereum_addresses/ethereum_addresses.dart';
import 'package:solana/solana.dart';

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
}
