import 'package:solana/src/solana_serializable/compact_array.dart';
import 'package:solana/src/solana_serializable/signature.dart';
import 'package:solana/src/solana_serializable/solana_serializable.dart';

import 'message.dart';

/// Represents a signed transaction that consists of the transaction
/// message and an array of signatures. The array of signatures must
/// be populated following the solana convention for the set of addresses
/// that they belong to within the message.
class SignedTx extends Serializable {
  const SignedTx({
    this.signatures = const CompactArray<Signature>.fromIterable([]),
    required this.message,
  });

  final CompactArray<Signature> signatures;
  final Message message;

  @override
  List<int> serialize() => [
        ...signatures.serialize(),
        ...message.serialize(),
      ];
}
