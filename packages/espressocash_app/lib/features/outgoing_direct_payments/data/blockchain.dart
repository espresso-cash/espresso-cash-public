import 'package:solana/solana.dart';

enum Blockchain { solana, ethereum, arbitrum, polygon }

extension BlockchainExt on Blockchain {
  String get name => switch (this) {
        Blockchain.solana => 'Solana',
        Blockchain.ethereum => 'Ethereum',
        Blockchain.arbitrum => 'Arbitrum',
        Blockchain.polygon => 'Polygon',
      };

  bool validate(String text) => switch (this) {
        Blockchain.solana => isValidAddress(text),
        _ => true,
      };
}
