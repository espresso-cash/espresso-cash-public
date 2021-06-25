part of 'associated_token_account_program.dart';

class AssociatedTokenAccountInstruction extends Instruction {
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
          data: [0],
        );
}
