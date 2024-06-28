import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';
import 'package:solana/src/programs/token_2022_program/extension_type.dart';
import 'package:solana/src/programs/token_2022_program/program.dart';

//TODO: token2022 should also have instructions from TokenProgram
class Token2022Instruction extends Instruction {
  Token2022Instruction._({
    required super.accounts,
    required super.data,
  }) : super(
          programId: Token2022Program.id,
        );

  factory Token2022Instruction.initializeMintCloseAuthority({
    required Ed25519HDPublicKey mint,
    required Ed25519HDPublicKey? closeAuthority,
  }) =>
      Token2022Instruction._(
        accounts: [
          AccountMeta.writeable(pubKey: mint, isSigner: false),
        ],
        data: ByteArray.merge(
          [
            Token2022Program.initializeMintCloseAuthorityInstructionIndex,
            if (closeAuthority != null) closeAuthority.toByteArray(),
          ],
        ),
      );

  factory Token2022Instruction.reallocate({
    required Ed25519HDPublicKey account,
    required Ed25519HDPublicKey payer,
    required List<ExtensionType> extensionTypes,
    required Ed25519HDPublicKey owner,
    List<Ed25519HDPublicKey> signers = const <Ed25519HDPublicKey>[],
  }) =>
      Token2022Instruction._(
        accounts: [
          AccountMeta.writeable(pubKey: account, isSigner: false),
          AccountMeta.writeable(pubKey: payer, isSigner: true),
          AccountMeta.readonly(pubKey: SystemProgram.id, isSigner: false),
          AccountMeta.writeable(
            pubKey: owner,
            isSigner: signers.isEmpty,
          ),
          ...signers.map(
            (pubKey) => AccountMeta.readonly(pubKey: pubKey, isSigner: true),
          ),
        ],
        data: ByteArray.merge([
          Token2022Program.reallocateInstructionIndex,
          ByteArray.merge(
            extensionTypes.map((e) => ByteArray.u16(e.value)),
          ),
        ]),
      );

  factory Token2022Instruction.createNativeMint({
    required Ed25519HDPublicKey payer,
  }) =>
      Token2022Instruction._(
        accounts: [
          AccountMeta.writeable(pubKey: payer, isSigner: true),
          AccountMeta.writeable(pubKey: nativeMint2022, isSigner: false),
          AccountMeta.readonly(pubKey: SystemProgram.id, isSigner: false),
        ],
        data: Token2022Program.createNativeMintInstructionIndex,
      );

  factory Token2022Instruction.initializeNonTransferableMint({
    required Ed25519HDPublicKey mint,
  }) =>
      Token2022Instruction._(
        accounts: [
          AccountMeta.writeable(pubKey: mint, isSigner: false),
        ],
        data: Token2022Program.initializeNonTransferableMintInstructionIndex,
      );

  factory Token2022Instruction.initializePermanentDelegate({
    required Ed25519HDPublicKey mint,
    required Ed25519HDPublicKey? delegate,
  }) =>
      Token2022Instruction._(
        accounts: [
          AccountMeta.writeable(pubKey: mint, isSigner: false),
        ],
        data: ByteArray.merge([
          Token2022Program.initializePermanentDelegateInstructionIndex,
          if (delegate != null) delegate.toByteArray(),
        ]),
      );
}

final nativeMint2022 = Ed25519HDPublicKey.fromBase58(
  '9pan9bMn5HatX4EJdBwg9VgCa7Uz5HL8N1m5D3NdXejP',
);
