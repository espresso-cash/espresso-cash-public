import 'package:solana/src/base58/base58.dart' as base58;
import 'package:solana/src/encoder/encoder.dart';

class TokenMessage extends Message {
  TokenMessage({
    required List<Instruction> instructions,
  }) : super(
          instructions: instructions,
        );

  factory TokenMessage.createMint({
    String? freezePubkey,
    required String authorityPubkey,
    required String mintPubkey,
    required int requiredBalance,
    required int allocatedSpace,
    required int decimals,
  }) {
    final instructions = [
      Instruction.system(
        accounts: [
          AccountMeta.writeableSigner(pubKey: authorityPubkey),
          AccountMeta.writeableSigner(pubKey: mintPubkey),
        ],
        data: InstructionData([
          SystemProgram.createAccount,
          Buffer.fromInt64(requiredBalance),
          Buffer.fromInt64(allocatedSpace),
          base58.decode(TokenProgram.id),
        ]),
      ),
      Instruction(
        programId: TokenProgram.id,
        accounts: [
          AccountMeta.writeable(pubKey: mintPubkey),
          AccountMeta.readonly(pubKey: Sysvar.rent),
        ],
        data: InstructionData([
          TokenProgram.initializeMint,
          Buffer.fromUInt8(decimals),
          base58.decode(authorityPubkey),
          Buffer.fromUInt8(freezePubkey != null ? 1 : 0),
          if (freezePubkey != null)
            base58.decode(freezePubkey)
          else
            List<int>.filled(32, 0),
        ]),
      )
    ];

    return TokenMessage(
      instructions: instructions,
    );
  }
}
