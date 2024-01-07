enum DlnChains {
  arbitrum,
  avalanche,
  bnb,
  ethereum,
  polygon,
  solana,
  linea,
  base,
  optimism
}

extension DlnChainsExt on DlnChains {
  String get name => switch (this) {
        DlnChains.arbitrum => 'Arbitrum',
        DlnChains.avalanche => 'Avalanche',
        DlnChains.bnb => 'Binance Smart Chain',
        DlnChains.ethereum => 'Ethereum',
        DlnChains.polygon => 'Polygon',
        DlnChains.solana => 'Solana',
        DlnChains.linea => 'Linea',
        DlnChains.base => 'Base',
        DlnChains.optimism => 'Optimism',
      };

  String get chainId => switch (this) {
        DlnChains.arbitrum => '42161',
        DlnChains.avalanche => '43114',
        DlnChains.bnb => '56',
        DlnChains.ethereum => '1',
        DlnChains.polygon => '137',
        DlnChains.solana => '7565164',
        DlnChains.linea => '59144',
        DlnChains.base => '8453',
        DlnChains.optimism => '10',
      };
}
