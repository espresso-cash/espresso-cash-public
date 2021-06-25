library associated_account_program;

import 'package:solana/solana.dart';
import 'package:solana/src/encoder/encoder.dart';
import 'package:solana/src/token_program/token_program.dart';

part 'associated_token_account_instruction.dart';

class AssociatedTokenAccountProgram extends Message {
  AssociatedTokenAccountProgram({
    required String funder,
    required String address,
    required String owner,
    required String mint,
  }) : super(
          instructions: [
            AssociatedTokenAccountInstruction(
              funder: funder,
              address: address,
              owner: owner,
              mint: mint,
            )
          ],
        );

  static const programId = 'ATokenGPvbdGVxr1b2hvZbsiqW5xWH25efTNsLJA8knL';
}
