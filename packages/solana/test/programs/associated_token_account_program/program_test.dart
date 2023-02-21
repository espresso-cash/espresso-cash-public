import 'package:solana/dto.dart';
import 'package:solana/solana.dart';
import 'package:test/test.dart';

import '../../config.dart';

void main() {
  final solanaClient = createTestSolanaClient();

  test('Creates associated token account', () async {
    final owner = await Ed25519HDKeyPair.random();
    await solanaClient.requestAirdrop(
      address: owner.publicKey,
      lamports: lamportsPerSol,
      commitment: Commitment.confirmed,
    );
    final mint = await solanaClient.initializeMint(
      mintAuthority: owner,
      decimals: 2,
      commitment: Commitment.confirmed,
    );

    final b1 = await solanaClient.rpcClient
        .getBalance(owner.address, commitment: Commitment.confirmed)
        .value;

    final derivedAddress = await findAssociatedTokenAddress(
      owner: owner.publicKey,
      mint: mint.address,
    );
    final instruction = AssociatedTokenAccountInstruction.createAccount(
      mint: mint.address,
      address: derivedAddress,
      owner: owner.publicKey,
      funder: owner.publicKey,
    );

    final message = Message.only(instruction);
    await solanaClient.sendAndConfirmTransaction(
      message: message,
      signers: [owner],
      commitment: Commitment.confirmed,
    );

    final b2 = await solanaClient.rpcClient
        .getBalance(owner.address, commitment: Commitment.confirmed)
        .value;

    expect(b1 - b2, _tokenProgramRent + _lamportsPerSignature);

    expect(
      await solanaClient.hasAssociatedTokenAccount(
        owner: owner.publicKey,
        mint: mint.address,
        commitment: Commitment.confirmed,
      ),
      true,
    );
  });
}

/// Pre-calculated for `TokenProgram.neededAccountSpace = 165`.
const int _tokenProgramRent = 2039280;
const _lamportsPerSignature = 5000;
