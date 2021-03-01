import 'package:crypto_please_solana_lib/src/types/compact_array.dart';
import 'package:crypto_please_solana_lib/src/types/serializable.dart';
import 'package:crypto_please_solana_lib/src/types/serializable_signature.dart';
import 'package:meta/meta.dart';

import 'message.dart';

class Transaction extends Serializable {
  Transaction({
    @required this.signatures,
    @required this.message,
  });

  final CompactArray<SerializableSignature> signatures;
  final Message message;

  @override
  List<int> serialize() {
    return [
      ...signatures.serialize(),
      ...message.serialize(),
    ];
  }
}
