import 'package:crypto_please_solana_lib/src/base58/base58.dart' as base58;
import 'package:crypto_please_solana_lib/src/types/compact_array.dart';
import 'package:crypto_please_solana_lib/src/types/instruction.dart';
import 'package:crypto_please_solana_lib/src/types/message_header.dart';
import 'package:crypto_please_solana_lib/src/types/serializable.dart';
import 'package:crypto_please_solana_lib/src/types/serializable_address.dart';
import 'package:meta/meta.dart';

class Message extends Serializable {
  Message({
    @required this.header,
    @required this.accounts,
    @required this.recentBlockhash,
    @required this.instructions,
  });
  MessageHeader header;
  CompactArray<SerializableAddress> accounts;
  String recentBlockhash;
  CompactArray<Instruction> instructions;

  @override
  List<int> serialize() {
    return [
      ...header.serialize(),
      ...accounts.serialize(),
      ...base58.decode(recentBlockhash),
      ...instructions.serialize(),
    ];
  }
}
