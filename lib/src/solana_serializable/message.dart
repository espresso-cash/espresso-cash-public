import 'package:solana/solana.dart';
import 'package:solana/src/base58/base58.dart' as base58;
import 'package:solana/src/solana_serializable/address.dart';
import 'package:solana/src/solana_serializable/compact_array.dart';
import 'package:solana/src/solana_serializable/instruction.dart';
import 'package:solana/src/solana_serializable/message_header.dart';
import 'package:solana/src/solana_serializable/solana_serializable.dart';
import 'package:solana/src/types/blockhash.dart';
import 'package:solana/src/util/solana_int_encoder.dart';

class Message extends Serializable {
  Message({
    required this.header,
    required this.accounts,
    required this.recentBlockhash,
    required this.instructions,
  });

  final MessageHeader header;
  final CompactArray<Address> accounts;
  final String recentBlockhash;
  final CompactArray<Instruction> instructions;

  @override
  List<int> serialize() => [
        ...header.serialize(),
        ...accounts.serialize(),
        ...base58.decode(recentBlockhash),
        ...instructions.serialize(),
      ];

  factory Message.transfer({
    required String source,
    required String destination,
    required int lamports,
    required Blockhash recentBlockhash,
  }) {
    final instruction = Instruction(
      programIdIndex: 2,
      accountIndices: CompactArray.fromList([0, 1]),
      data: CompactArray.fromList(
        [
          ...2.toSolanaBytes(32),
          ...lamports.toSolanaBytes(64),
        ],
      ),
    );

    final message = Message(
      header: MessageHeader(1, 0, 1),
      accounts: CompactArray.fromList([
        Address.from(source),
        Address.from(destination),
        Address.from(solanaSystemProgramID),
      ]),
      recentBlockhash: recentBlockhash.blockhash,
      instructions: CompactArray.fromList([instruction]),
    );
    return message;
  }
}
