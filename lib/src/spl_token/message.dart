import 'package:solana/src/base58/base58.dart' as base58;
import 'package:solana/src/constants/constants.dart';
import 'package:solana/src/solana_serializable/instruction.dart';
import 'package:solana/src/solana_serializable/int.dart';
import 'package:solana/src/solana_serializable/message.dart';
import 'package:solana/src/types/account_meta.dart';
import 'package:solana/src/types/blockhash.dart';

class TokenMessage extends Message {
  TokenMessage({
    required List<Instruction> instructions,
    required Blockhash recentBlockhash,
  }) : super(
          instructions: instructions,
          recentBlockhash: recentBlockhash,
        );

  factory TokenMessage.createToken({
    required String authority,
    required String mint,
    required int decimals,
    required Blockhash recentBlockhash,
  }) {
    final mintAccount = AccountMeta.readonly(pubKey: mint, isSigner: false);
    final instructions = [
      Instruction(
        programId: SystemProgram.id,
        accounts: [mintAccount],
        data: SystemProgramIndex.createAccount,
      ),
      Instruction(
        programId: TokenProgram.id,
        accounts: [
          mintAccount,
          AccountMeta.readonly(pubKey: Sysvar.rent, isSigner: false),
        ],
        data: [
          ...TokenProgramIndex.initializeMint,
          ...SerializableInt.from(decimals),
          ...base58.decode(authority),
          ...Int32Bytes.zero,
        ],
      )
    ];

    return TokenMessage(
      instructions: instructions,
      recentBlockhash: recentBlockhash,
    );
  }
}
