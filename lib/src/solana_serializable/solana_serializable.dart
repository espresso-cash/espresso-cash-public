library solana_serializable;

export 'address.dart';
export 'compact_array.dart';
export 'compact_u16.dart';
export 'instruction.dart';
export 'message.dart';
export 'message_header.dart';
export 'signature.dart';
export 'signed_tx.dart';

// ignore: one_member_abstracts
abstract class Serializable {
  List<int> serialize();
}
