import 'package:solana/solana.dart';

enum Blockchain { solana, arbitrum }

extension BlockchainExt on Blockchain {
  String get name => switch (this) {
        Blockchain.solana => 'Solana',
        Blockchain.arbitrum => 'Arbitrum',
      };

  bool validate(String text) => switch (this) {
        Blockchain.solana => isValidAddress(text),
        Blockchain.arbitrum => true, //TODO setup erc20 validation
      };

  String get value => switch (this) {
        Blockchain.solana => 'solana',
        Blockchain.arbitrum => 'arbitrum',
      };
}
