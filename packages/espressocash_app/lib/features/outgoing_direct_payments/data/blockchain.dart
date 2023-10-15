import 'package:solana/solana.dart';

enum Blockchain { solana }

extension BlockchainExt on Blockchain {
  String get name => switch (this) {
        Blockchain.solana => 'Solana',
      };

  bool validate(String text) => switch (this) {
        Blockchain.solana => isValidAddress(text),
      };
}
