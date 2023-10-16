import 'package:decimal/decimal.dart';

enum Blockchain { solana, ethereum, polygon }

extension BlockchainExt on Blockchain {
  String get name => switch (this) {
        Blockchain.solana => 'Solana',
        Blockchain.ethereum => 'Ethereum',
        Blockchain.polygon => 'Polygon',
      };

  // Hardcoded fees. Update to fetch from api in the future.
  Decimal get fee => switch (this) {
        Blockchain.solana => Decimal.fromInt(0),
        Blockchain.ethereum => Decimal.fromInt(12),
        Blockchain.polygon => Decimal.fromInt(3),
      };
}
