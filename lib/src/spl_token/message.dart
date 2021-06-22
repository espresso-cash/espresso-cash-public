import 'package:solana/src/base58/base58.dart' as base58;
import 'package:solana/src/encoder/encoder.dart';

class TokenMessage extends Message {
  TokenMessage({
    required List<Instruction> instructions,
  }) : super(
          instructions: instructions,
        );

  factory TokenMessage.createToken({
    required String authority,
    required String mint,
    required int decimals,
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
    );
  }
}
