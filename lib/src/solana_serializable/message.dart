import 'package:meta/meta.dart';
import 'package:solana_dart/src/base58/base58.dart' as base58;
import 'package:solana_dart/src/solana_serializable/address.dart';
import 'package:solana_dart/src/solana_serializable/compact_array.dart';
import 'package:solana_dart/src/solana_serializable/instruction.dart';
import 'package:solana_dart/src/solana_serializable/message_header.dart';
import 'package:solana_dart/src/solana_serializable/serializable.dart';

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
  List<int> serialize() => [
        ...header.serialize(),
        ...accounts.serialize(),
        ...base58.decode(recentBlockhash),
        ...instructions.serialize(),
      ];
}
