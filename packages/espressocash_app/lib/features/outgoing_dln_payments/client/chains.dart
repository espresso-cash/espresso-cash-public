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

  String get usdcAddress => switch (this) {
        DlnChains.arbitrum => '0xaf88d065e77c8cC2239327C5EDb3A432268e5831',
        DlnChains.avalanche => '0xB97EF9Ef8734C71904D8002F8b6Bc66Dd9c48a6E',
        DlnChains.bnb => '0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d',
        DlnChains.ethereum => '0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48',
        DlnChains.polygon => '0x3c499c542cEF5E3811e1192ce70d8cC03d5c3359',
        DlnChains.solana => 'EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v',
        DlnChains.linea => '0x176211869ca2b568f2a7d4ee941e073a821ee1ff',
        DlnChains.base => '0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913',
        DlnChains.optimism => '0x0b2C639c533813f4Aa9D7837CAf62653d097Ff85',
      };
}

extension StringExt on String {
  DlnChains? get toDlnChain => switch (this) {
        'arbitrum' => DlnChains.arbitrum,
        'avalanche' => DlnChains.avalanche,
        'bnb' => DlnChains.bnb,
        'ethereum' => DlnChains.ethereum,
        'polygon' => DlnChains.polygon,
        'solana' => DlnChains.solana,
        'linea' => DlnChains.linea,
        'base' => DlnChains.base,
        'optimism' => DlnChains.optimism,
        _ => null,
      };
}
