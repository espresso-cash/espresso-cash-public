part of 'decoder.dart';

enum Commitment { processed, confirmed, finalized }

extension CommitmentValueExt on Commitment {
  String get value {
    switch (this) {
      case Commitment.processed:
        return 'processed';
      case Commitment.confirmed:
        return 'confirmed';
      case Commitment.finalized:
        return 'finalized';
    }
  }
}
