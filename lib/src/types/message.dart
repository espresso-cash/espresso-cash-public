import 'package:meta/meta.dart';
import 'package:solana_dart/src/base58/base58.dart' as base58;
import 'package:solana_dart/src/types/compact_array.dart';
import 'package:solana_dart/src/types/instruction.dart';
import 'package:solana_dart/src/types/message_header.dart';
import 'package:solana_dart/src/types/serializable.dart';
import 'package:solana_dart/src/types/address.dart';

class Message extends Serializable {
  Message({
    @required this.header,
    @required this.accounts,
    @required this.recentBlockhash,
    @required this.instructions,
  });
  MessageHeader header;
  CompactArray<Address> accounts;
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
