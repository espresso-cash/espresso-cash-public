import 'package:ethereum_addresses/ethereum_addresses.dart';
import 'package:solana/solana.dart';

enum Blockchain { solana, arbitrum }

extension BlockchainExt on Blockchain {
  String get name => switch (this) {
        Blockchain.solana => 'Solana',
        Blockchain.arbitrum => 'Arbitrum',
      };

  bool validate(String text) => switch (this) {
        Blockchain.solana => isValidAddress(text),
        Blockchain.arbitrum => isValidEthereumAddress(text),
      };

  String get value => switch (this) {
        Blockchain.solana => 'solana',
        Blockchain.arbitrum => 'arbitrum',
      };
}
