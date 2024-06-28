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

  /// Initialize the close account authority on a new mint.
  ///
  /// Fails if the [mint] has already been initialized, so must be called before
  /// `InitializeMint`.
  ///
  /// The mint must have exactly enough space allocated for the base mint (82
  /// bytes), plus 83 bytes of padding, 1 byte reserved for the account type,
  /// then space required for this extension, plus any others.
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

  /// Check to see if a token [account] is large enough for a list of
  /// [extensionTypes], and if not, use reallocation to increase the data
  /// size.
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

  /// Creates the native mint.
  ///
  /// This instruction only needs to be invoked once after deployment and is
  /// permissionless, Wrapped SOL will not be available until this instruction
  /// is successfully executed.
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

  /// Initialize the non transferable extension for the given [mint] account
  ///
  /// Fails if the account has already been initialized, so must be called
  /// before `InitializeMint`.
  factory Token2022Instruction.initializeNonTransferableMint({
    required Ed25519HDPublicKey mint,
  }) =>
      Token2022Instruction._(
        accounts: [
          AccountMeta.writeable(pubKey: mint, isSigner: false),
        ],
        data: Token2022Program.initializeNonTransferableMintInstructionIndex,
      );

  // Initialize the permanent delegate on a new [mint].
  ///
  /// Fails if the [mint] has already been initialized, so must be called before
  /// `InitializeMint`.
  ///
  /// The [mint] must have exactly enough space allocated for the base mint (82
  /// bytes), plus 83 bytes of padding, 1 byte reserved for the account type,
  /// then space required for this extension, plus any others.
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
