import 'package:solana/solana.dart';

enum Blockchain { solana, ethereum, polygon }

extension BlockchainExt on Blockchain {
  String get name => switch (this) {
        Blockchain.solana => 'Solana',
        Blockchain.ethereum => 'Ethereum',
        Blockchain.polygon => 'Polygon',
      };

  bool validate(String text) => switch (this) {
        Blockchain.solana => isValidAddress(text),
        _ => true,
      };
}
