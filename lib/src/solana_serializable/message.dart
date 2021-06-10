import 'package:solana/solana.dart';
import 'package:solana/src/base58/base58.dart' as base58;
import 'package:solana/src/helpers/create_transfer_metas.dart';
import 'package:solana/src/solana_serializable/address.dart';
import 'package:solana/src/solana_serializable/compact_array.dart';
import 'package:solana/src/solana_serializable/instruction.dart';
import 'package:solana/src/solana_serializable/int.dart';
import 'package:solana/src/solana_serializable/message_header.dart';
import 'package:solana/src/solana_serializable/solana_serializable.dart';
import 'package:solana/src/solana_serializable/string.dart';
import 'package:solana/src/types/account_meta.dart';
import 'package:solana/src/types/blockhash.dart';

const _memoSizeLimit = 566;

/// This is an implementation of the Solana message format.
class Message extends Serializable {
  Message._({
    required this.header,
    required this.accounts,
    required this.recentBlockhash,
    required this.instructions,
  });

  /// Creates a solana transfer message to send [lamports] SOL tokens from [source]
  /// to [destination]. The recent block hash must be queried and provided as
  /// [recentBlockhash] to this function.
  ///
  /// To add additional data to the transaction you can use the [memo] field.
  /// It accepts an arbitrary string of utf-8 characters. As of now the maximum
  /// allowed length for the memo is 566 bytes of utf-8 data.
  factory Message.transfer({
    required String source,
    required String destination,
    required int lamports,
    required Blockhash recentBlockhash,
    String? memo,
  }) {
    final metas = createTransferMetas(source, destination);
    final data = CompactArray.fromList([
      ...Int.from(2, bitSize: 32),
      ...Int.from(lamports, bitSize: 64),
    ]);
    final instruction = Instruction.system(
      pubKeys: [source, destination],
      metas: metas,
      data: data,
    );
    final instructions = [instruction];
    if (memo != null) {
      final memoStr = Str(memo);
      if (memoStr.size > _memoSizeLimit) {
        throw const FormatException(
          'the [memo] cannot be more than 566 bytes length',
        );
      }
      instructions.add(
        Instruction.memo(
          metas: metas,
          signers: [source],
          memo: Str(memo),
        ),
      );
    }

    return Message._(
      header: MessageHeader.fromAccounts(metas),
      accounts: CompactArray.fromList([
        for (AccountMeta account in metas) Address.from(account.pubKey),
      ]),
      recentBlockhash: recentBlockhash.blockhash,
      instructions: CompactArray.fromList(instructions),
    );
  }

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
}
