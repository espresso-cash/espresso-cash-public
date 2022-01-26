part of 'associated_token_account_program.dart';

class AssociatedTokenAccountInstruction extends Instruction {
  /// Create an instruction for the [associated token account] program.
  ///
  /// The account will be associated to [mint] and have the associated token account [address].
  ///
  /// It will be owned by [owner] and funded by [funder].
  ///
  /// The [address] can be derived using [SplToken.computeAssociatedAddress].
  /// It is required here just to match the spl token program closely in terms of
  /// its API.
  ///
  /// If the [address] does not match the derived address, this method will fail.
  ///
  /// [associated token account]: https://spl.solana.com/associated-token-account
  factory AssociatedTokenAccountInstruction({
    required String funder,
    required String address,
    required String owner,
    required String mint,
  }) =>
      AssociatedTokenAccountInstruction._(
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
      );

  AssociatedTokenAccountInstruction._({
    required List<AccountMeta> accounts,
  }) : super(
          programId: AssociatedTokenAccountProgram.programId,
          accounts: accounts,
          data: [],
        );
}
