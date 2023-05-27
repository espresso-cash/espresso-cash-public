import 'dart:convert';

import 'package:solana/src/crypto/ed25519_hd_public_key.dart';
import 'package:solana/src/encoder/account_meta.dart';
import 'package:solana/src/encoder/byte_array.dart';
import 'package:solana/src/encoder/instruction.dart';
import 'package:solana/src/programs/memo_program/program.dart';

/// The memo instruction for the memo program.
class MemoInstruction extends Instruction {
  /// Construct a memo instruction for the memo program with [signers] as
  /// signers and [memo] as content.
  ///
  /// Please note that there's a limit on the length of the [memo] string, which
  /// otherwise is an arbitrary string of utf-8 data.
  ///
  /// The limit as [specified in this document][1] is 566 bytes.
  ///
  /// [1](https://spl.solana.com/memo#compute-limits)
  factory MemoInstruction({
    required List<Ed25519HDPublicKey> signers,
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
      data: ByteArray(utf8.encode(memo)),
    );
  }

  MemoInstruction._({
    required super.accounts,
    required super.data,
  }) : super(
          programId: MemoProgram.id,
        );

  static AccountMeta _addressToAccount(Ed25519HDPublicKey address) =>
      AccountMeta.writeable(pubKey: address, isSigner: true);
}

const _memoSizeLimit = 566;
