import 'package:solana/dto.dart';
import 'package:solana/solana.dart';
import 'package:solana/src/programs/token_2022_program/extension_type.dart';
import 'package:solana/src/programs/token_2022_program/instruction.dart';
import 'package:test/test.dart';

import '../../config.dart';

void main() {
  late final Ed25519HDKeyPair mint;
  late final Ed25519HDKeyPair mintAuthority;

  late final Ed25519HDKeyPair account;
  late final Ed25519HDKeyPair owner;

  late final Ed25519HDKeyPair payer;

  final client = createTestSolanaClient();

  setUpAll(() async {
    mint = await Ed25519HDKeyPair.random();
    mintAuthority = await Ed25519HDKeyPair.random();

    account = await Ed25519HDKeyPair.random();
    owner = await Ed25519HDKeyPair.random();

    payer = await Ed25519HDKeyPair.random();

    await client.requestAirdrop(
      address: mintAuthority.publicKey,
      lamports: lamportsPerSol,
      commitment: Commitment.confirmed,
    );
    await client.requestAirdrop(
      address: payer.publicKey,
      lamports: lamportsPerSol,
      commitment: Commitment.confirmed,
    );
    await client.requestAirdrop(
      address: owner.publicKey,
      lamports: lamportsPerSol,
      commitment: Commitment.confirmed,
    );
  });

  Future<void> sendMessage(
    Message message,
    List<Ed25519HDKeyPair> signers,
  ) async {
    await client.sendAndConfirmTransaction(
      message: message,
      signers: signers,
      commitment: Commitment.confirmed,
    );
  }

  test('initializeMintCloseAuthority', () {});

  test('reallocate', () async {
    final mintRent = await client.rpcClient
        .getMinimumBalanceForRentExemption(TokenProgram.neededMintAccountSpace);

    final createMintIx = TokenInstruction.createAccountAndInitializeMint(
      mint: mint.publicKey,
      mintAuthority: mintAuthority.publicKey,
      rent: mintRent,
      space: TokenProgram.neededMintAccountSpace,
      decimals: 5,
      tokenProgramType: TokenProgramType.token2022Program,
    );

    await sendMessage(
      Message(instructions: createMintIx),
      [mintAuthority, mint],
    );

    final accountRent = await client.rpcClient
        .getMinimumBalanceForRentExemption(TokenProgram.neededAccountSpace);
    final createAccountIx = TokenInstruction.createAndInitializeAccount(
      mint: mint.publicKey,
      address: account.publicKey,
      owner: owner.publicKey,
      rent: accountRent,
      space: TokenProgram.neededAccountSpace,
      tokenProgramType: TokenProgramType.token2022Program,
    );

    await sendMessage(
      Message(instructions: createAccountIx),
      [owner, account],
    );

    final reallocateIx = Token2022Instruction.reallocate(
      account: account.publicKey,
      payer: payer.publicKey,
      extensionTypes: const [ExtensionType.immutableOwner],
      owner: owner.publicKey,
    );

    await sendMessage(
      Message(instructions: [reallocateIx]),
      [payer, owner],
    );

    final accountInfo = await client.rpcClient
        .getAccountInfo(
          account.publicKey.toBase58(),
          commitment: Commitment.confirmed,
          encoding: Encoding.jsonParsed,
        )
        .value;

    print(accountInfo);
  });

  test('createNativeMint', () {});

  test('initializeNonTransferableMint', () {});

  test('initializePermanentDelegate', () {});
}
