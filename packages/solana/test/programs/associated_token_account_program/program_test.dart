import 'package:solana/dto.dart';
import 'package:solana/solana.dart';
import 'package:test/test.dart';

import '../../config.dart';

void main() {
  final solanaClient = createTestSolanaClient();

  test('Creates associated token account', () async {
    await testAssociatedTokenAccountProgram(
      solanaClient,
      AssociatedTokenAccountInstruction.createAccount,
    );
  });

  test('Creates associated token account idempotent', () async {
    await testAssociatedTokenAccountProgram(
      solanaClient,
      AssociatedTokenAccountInstruction.createAccountIdempotent,
    );
  });
}

Future<void> testAssociatedTokenAccountProgram(
  SolanaClient solanaClient,
  AssociatedTokenAccountInstruction Function({
    required Ed25519HDPublicKey funder,
    required Ed25519HDPublicKey address,
    required Ed25519HDPublicKey owner,
    required Ed25519HDPublicKey mint,
    Ed25519HDPublicKey? tokenProgramId,
  })
  ixCreator,
) async {
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

  final b1 =
      await solanaClient.rpcClient
          .getBalance(owner.address, commitment: Commitment.confirmed)
          .value;

  final derivedAddress = await findAssociatedTokenAddress(
    owner: owner.publicKey,
    mint: mint.address,
  );
  final instruction = ixCreator(
    funder: owner.publicKey,
    address: derivedAddress,
    owner: owner.publicKey,
    mint: mint.address,
  );

  final message = Message.only(instruction);
  await solanaClient.sendAndConfirmTransaction(
    message: message,
    signers: [owner],
    commitment: Commitment.confirmed,
  );

  final b2 =
      await solanaClient.rpcClient
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
}

/// Pre-calculated for `TokenProgram.neededAccountSpace = 165`.
const int _tokenProgramRent = 2_039_280;
const _lamportsPerSignature = 5000;
