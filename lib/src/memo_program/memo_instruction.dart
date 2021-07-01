import 'package:solana/src/encoder/account_meta.dart';
import 'package:solana/src/encoder/buffer.dart';
import 'package:solana/src/encoder/instruction.dart';
import 'package:solana/src/memo_program/memo_program.dart';

/// The memo instruction for the memo program
class MemoInstruction extends Instruction {
  /// Construct a memo instruction for the memo program with
  /// [signers] as signers and [memo] as content.
  ///
  /// Please note that there's a limit on the length of the [memo] string, which
  /// otherwise is an arbitrary string of utf-8 data.
  ///
  /// The limit as [specified in this document][memo limit] is 566 bytes.
  ///
  /// [memo limit](https://spl.solana.com/memo#compute-limits)
  factory MemoInstruction({
    required List<String> signers,
    required String memo,
  }) {
    if (memo.length > _memoSizeLimit) {
      throw const FormatException(
        'the [memo] cannot be more than 566 bytes length',
      );
    }
    final accounts = signers.map(_addressToAccount).toList(growable: false);

    return MemoInstruction._(
      accounts: accounts,
      data: Buffer.fromString(memo),
    );
  }

  MemoInstruction._({
    required List<AccountMeta> accounts,
    required Buffer data,
  }) : super(
          programId: MemoProgram.programId,
          accounts: accounts,
          data: data,
        );

  static AccountMeta _addressToAccount(String address) =>
      AccountMeta.writeable(pubKey: address, isSigner: true);
}

const _memoSizeLimit = 566;
