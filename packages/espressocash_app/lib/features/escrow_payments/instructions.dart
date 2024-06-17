import 'package:solana/anchor.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

import 'models.dart';

class EscrowInstruction {
  static Future<AnchorInstruction> initEscrow({
    required int amount,
    required Ed25519HDPublicKey escrowAccount,
    required Ed25519HDPublicKey senderAccount,
    required Ed25519HDPublicKey senderTokenAccount,
    required Ed25519HDPublicKey depositorAccount,
    required Ed25519HDPublicKey vaultTokenAccount,
  }) =>
      AnchorInstruction.forMethod(
        programId: escrowProgram,
        method: 'initialize_escrow',
        arguments: ByteArray(
          EscrowArgument(
            amount: BigInt.from(amount),
          ).toBorsh().toList(),
        ),
        accounts: <AccountMeta>[
          AccountMeta.writeable(pubKey: escrowAccount, isSigner: true),
          AccountMeta.writeable(pubKey: depositorAccount, isSigner: true),
          AccountMeta.writeable(pubKey: senderAccount, isSigner: true),
          AccountMeta.writeable(pubKey: senderTokenAccount, isSigner: false),
          AccountMeta.writeable(pubKey: vaultTokenAccount, isSigner: false),
          AccountMeta.readonly(pubKey: SystemProgram.id, isSigner: false),
          AccountMeta.readonly(pubKey: TokenProgram.id, isSigner: false),
        ],
        namespace: 'global',
      );

  static Future<AnchorInstruction> completeEscrow({
    required Ed25519HDPublicKey escrowAccount,
    required Ed25519HDPublicKey receiverTokenAccount,
    required Ed25519HDPublicKey depositorAccount,
    required Ed25519HDPublicKey vaultTokenAccount,
  }) async =>
      AnchorInstruction.forMethod(
        programId: escrowProgram,
        method: 'complete_escrow',
        accounts: <AccountMeta>[
          AccountMeta.writeable(pubKey: escrowAccount, isSigner: true),
          AccountMeta.writeable(pubKey: depositorAccount, isSigner: true),
          AccountMeta.writeable(pubKey: receiverTokenAccount, isSigner: false),
          AccountMeta.writeable(pubKey: vaultTokenAccount, isSigner: false),
          AccountMeta.readonly(
            pubKey: await _calculatePda(escrowAccount),
            isSigner: false,
          ),
          AccountMeta.readonly(pubKey: TokenProgram.id, isSigner: false),
        ],
        namespace: 'global',
      );

  static Future<AnchorInstruction> cancelEscrow({
    required Ed25519HDPublicKey escrowAccount,
    required Ed25519HDPublicKey senderAccount,
    required Ed25519HDPublicKey senderTokenAccount,
    required Ed25519HDPublicKey depositorAccount,
    required Ed25519HDPublicKey vaultTokenAccount,
  }) async =>
      AnchorInstruction.forMethod(
        programId: escrowProgram,
        method: 'cancel_escrow',
        accounts: <AccountMeta>[
          AccountMeta.writeable(pubKey: escrowAccount, isSigner: false),
          AccountMeta.writeable(pubKey: senderAccount, isSigner: true),
          AccountMeta.writeable(pubKey: depositorAccount, isSigner: true),
          AccountMeta.writeable(pubKey: senderTokenAccount, isSigner: false),
          AccountMeta.writeable(pubKey: vaultTokenAccount, isSigner: false),
          AccountMeta.readonly(
            pubKey: await _calculatePda(escrowAccount),
            isSigner: false,
          ),
          AccountMeta.readonly(pubKey: TokenProgram.id, isSigner: false),
        ],
        namespace: 'global',
      );
}

Future<Ed25519HDPublicKey> _calculatePda(
  Ed25519HDPublicKey escrowAccount,
) =>
    Ed25519HDPublicKey.findProgramAddress(
      seeds: [
        'ec_shareable_links'.codeUnits,
        escrowAccount.bytes,
      ],
      programId: escrowProgram,
    );

const escrowAddress = '7rE2We9zMQzj2xmhJRTvYXKP22VKDGh3krujdBqWibBL';
final escrowProgram = Ed25519HDPublicKey.fromBase58(escrowAddress);
