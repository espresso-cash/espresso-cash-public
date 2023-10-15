import 'package:decimal/decimal.dart';

enum Blockchain { solana, ethereum, polygon }

extension BlockchainExt on Blockchain {
  String get name => switch (this) {
        Blockchain.solana => 'Solana',
        Blockchain.ethereum => 'Ethereum',
        Blockchain.polygon => 'Polygon',
      };

  Decimal get fee => switch (this) {
        Blockchain.solana => Decimal.fromInt(0),
        Blockchain.ethereum => Decimal.fromInt(2),
        Blockchain.polygon => Decimal.fromInt(1),
      };
}
