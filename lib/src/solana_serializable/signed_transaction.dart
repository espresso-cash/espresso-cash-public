import 'package:solana/src/solana_serializable/compact_array.dart';
import 'package:solana/src/solana_serializable/signature.dart';
import 'package:solana/src/solana_serializable/solana_serializable.dart';

import 'message.dart';

class SignedTx extends Serializable {
  SignedTx({
    required this.signatures,
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
