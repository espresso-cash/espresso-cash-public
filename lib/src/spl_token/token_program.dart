part of 'spl_token.dart';

class TokenProgram extends Message {
  TokenProgram._({
    required List<Instruction> instructions,
  }) : super(
          instructions: instructions,
        );

  factory TokenProgram.initializeMint({
    required String mint,
    required String mintAuthority,
    required int rent,
    required int space,
    required int decimals,
    String? freezeAuthority,
  }) =>
      TokenProgram._(
        instructions: [
          SystemInstruction.createAccount(
            address: mint,
            owner: mintAuthority,
            rent: rent,
            space: space,
            programId: TokenProgram.programId,
          ),
          Instruction(
            programId: TokenProgram.programId,
            accounts: [
              AccountMeta.writeable(pubKey: mint, isSigner: false),
              AccountMeta.readonly(pubKey: Sysvar.rent, isSigner: false),
            ],
            data: Buffer.fromConcatenatedByteArrays([
              TokenProgram._initializeMintInstructionIndex,
              Buffer.fromUint8(decimals),
              Buffer.fromBase58(mintAuthority),
              Buffer.fromUint8(freezeAuthority != null ? 1 : 0),
              if (freezeAuthority != null)
                Buffer.fromBase58(freezeAuthority)
              else
                List<int>.filled(32, 0),
            ]),
          )
        ],
      );

  factory TokenProgram.createAccount({
    required String mint,
    required String address,
    required String owner,
    required int rent,
    required int space,
  }) =>
      TokenProgram._(
        instructions: [
          SystemInstruction.createAccount(
            address: address,
            owner: owner,
            rent: rent,
            space: space,
            programId: TokenProgram.programId,
          ),
          Instruction(
            programId: TokenProgram.programId,
            accounts: [
              AccountMeta.writeable(pubKey: address, isSigner: true),
              AccountMeta.readonly(pubKey: mint, isSigner: false),
              AccountMeta.readonly(pubKey: owner, isSigner: false),
              AccountMeta.readonly(pubKey: Sysvar.rent, isSigner: false),
            ],
            data: TokenProgram._initializeAccountInstructionIndex,
          ),
        ],
      );

  factory TokenProgram.mintTo({
    required String mint,
    required String destination,
    required String owner,
    required int amount,
    String? feePayer,
  }) =>
      TokenProgram._(
        instructions: [
          Instruction(
            programId: TokenProgram.programId,
            accounts: [
              AccountMeta.writeable(pubKey: mint, isSigner: false),
              AccountMeta.writeable(pubKey: destination, isSigner: false),
              AccountMeta(
                pubKey: owner,
                isSigner: true,
                isWriteable: feePayer == null,
              ),
            ],
            data: Buffer.fromConcatenatedByteArrays([
              TokenProgram._mintToInstructionIndex,
              Buffer.fromUint64(amount),
            ]),
          ),
        ],
      );

  factory TokenProgram.transfer({
    required String source,
    required String destination,
    required String owner,
    required int amount,
    String? feePayer,
  }) =>
      TokenProgram._(
        instructions: [
          Instruction(
            programId: TokenProgram.programId,
            accounts: [
              AccountMeta.writeable(pubKey: source, isSigner: false),
              AccountMeta.writeable(pubKey: destination, isSigner: false),
              AccountMeta(
                pubKey: owner,
                isSigner: true,
                isWriteable: feePayer == null,
              ),
            ],
            data: Buffer.fromConcatenatedByteArrays([
              TokenProgram._transferInstructionIndex,
              Buffer.fromUint64(amount),
            ]),
          ),
        ],
      );

  factory TokenProgram.createAssociatedTokenAccount({
    required String mint,
    required String address,
    required String owner,
    required String funder,
  }) =>
      TokenProgram._(
        instructions: [
          Instruction(
            programId: AssociatedTokenAccountProgram.id,
            accounts: [
              AccountMeta.writeable(pubKey: funder, isSigner: true),
              AccountMeta.writeable(pubKey: address, isSigner: false),
              AccountMeta.readonly(pubKey: owner, isSigner: false),
              AccountMeta.readonly(pubKey: mint, isSigner: false),
              AccountMeta.readonly(
                  pubKey: SystemProgram.programId, isSigner: false),
              AccountMeta.readonly(
                pubKey: TokenProgram.programId,
                isSigner: false,
              ),
              AccountMeta.readonly(pubKey: Sysvar.rent, isSigner: false),
            ],
            data: [0],
          ),
        ],
      );

  static const programId = 'TokenkegQfeZyiNwAJbNbGKPFXCWuBvf9Ss623VQ5DA';

  // Instruction indexes
  static const _initializeMintInstructionIndex = [0];
  static const _initializeAccountInstructionIndex = [1];
  static const _transferInstructionIndex = [3];
  static const _mintToInstructionIndex = [7];

  // This is computed by adding the bytes in the following
  // structure
  //
  // mintAuthorityOption:   int32 ( 4 bytes)
  // mintAuthority:        PubKey (32 bytes)
  // supply:                int64 ( 8 bytes)
  // decimals:               byte ( 1 bytes)
  // isInitialized:          byte ( 1 bytes)
  // freezeAuthorityOption: int32 ( 4 bytes)
  // freezeAuthority:      PubKey (32 bytes)
  static const _neededMintAccountSpace = 82;

  // This is computed by adding the bytes in the following
  // structure
  //
  // mint:                 PubKey (32 bytes),
  // owner:                PubKey (32 bytes),
  // amount:               uint64 ( 8 bytes),
  // delegateOption:       uint32 ( 4 bytes),
  // delegate:             PubKey (32 bytes),
  // state:                byte   ( 1 bytes),
  // isNativeOption:       uint32 ( 4 bytes),
  // isNative:             uint64 ( 8 bytes),
  // delegatedAmount:      uint64 ( 8 bytes),
  // closeAuthorityOption: uint32 ( 4 bytes),
  // closeAuthority:       PubKey (32 bytes),
  static const _neededAccountSpace = 165;
}
