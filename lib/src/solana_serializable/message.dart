import 'package:solana/solana.dart';
import 'package:solana/src/base58/base58.dart' as base58;
import 'package:solana/src/constants/constants.dart';
import 'package:solana/src/solana_serializable/address.dart';
import 'package:solana/src/solana_serializable/compact_array.dart';
import 'package:solana/src/solana_serializable/instruction.dart';
import 'package:solana/src/solana_serializable/int.dart';
import 'package:solana/src/solana_serializable/message_header.dart';
import 'package:solana/src/solana_serializable/solana_serializable.dart';
import 'package:solana/src/solana_serializable/string.dart';
import 'package:solana/src/types/account_meta.dart';
import 'package:solana/src/types/blockhash.dart';

/// This is an implementation of the Solana message format.
class Message extends Serializable {
  Message({
    required List<AccountMeta> accounts,
    required List<Instruction> instructions,
    required Blockhash recentBlockhash,
  })  : _header = MessageHeader.fromAccounts(accounts),
        _instructions = CompactArray.fromList(instructions),
        _accounts = CompactArray.fromList([
          for (AccountMeta account in accounts) Address.from(account.pubKey),
        ]),
        _recentBlockhash = base58.decode(recentBlockhash.blockhash),
        super();

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
    final accounts = [
      AccountMeta.writeable(pubKey: source, isSigner: true),
      AccountMeta.writeable(pubKey: destination, isSigner: false),
      AccountMeta.readonly(pubKey: SystemProgram.id, isSigner: false),
    ];
    final data = [
      ...SerializableInt.from(2, bitSize: 32),
      ...SerializableInt.from(lamports, bitSize: 64),
    ];
    final uniqueAccounts = accounts.unique();
    final instructions = [
      Instruction.system(
        keys: [source, destination],
        accounts: uniqueAccounts,
        data: data,
      ),
      if (memo != null)
        Instruction.memo(
          accounts: [
            AccountMeta.writeable(pubKey: source, isSigner: true),
            AccountMeta.readonly(pubKey: MemoProgram.id, isSigner: false),
          ],
          keys: [source],
          memo: SerializableString(memo),
        ),
    ];

    return Message(
      accounts: uniqueAccounts,
      recentBlockhash: recentBlockhash,
      instructions: instructions,
    );
  }

  final MessageHeader _header;
  final CompactArray<Address> _accounts;
  final List<int> _recentBlockhash;
  final CompactArray<Instruction> _instructions;

  @override
  List<int> serialize() => [
        ..._header.serialize(),
        ..._accounts.serialize(),
        ..._recentBlockhash,
        ..._instructions.serialize(),
      ];
}
