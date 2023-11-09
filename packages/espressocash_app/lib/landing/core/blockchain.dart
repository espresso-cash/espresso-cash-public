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
}
