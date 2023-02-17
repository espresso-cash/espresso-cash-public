import 'package:share_escrow/src/instructions.dart';
import 'package:share_escrow/src/models.dart';
import 'package:solana/dto.dart';
import 'package:solana/solana.dart';
import 'package:test/test.dart';

import 'utils/accounts.dart';
import 'utils/config.dart';
import 'utils/helper.dart';

void main() {
  final client = createTestSolanaClient();

  late Mint mint;
  late Ed25519HDKeyPair mintAuthority;

  const initializerAmount = 1000;
  const sendAmount = 700;

  const escrowAccountRent = 1893120; // calculated for escrow account len = 144
  const vaultTokenRent = 2039280; // calculated for token account len = 165
  const airdropAmount = 1000000000;

  const expectedDepositorBalanceAfterInit = airdropAmount - escrowAccountRent;
  const expectedDepositorBalanceAfterComplete =
      airdropAmount - escrowAccountRent + vaultTokenRent;

  Future<void> requestAirdrop(Ed25519HDKeyPair account) async {
    await client.requestAirdrop(
      address: account.publicKey,
      lamports: airdropAmount,
      commitment: Commitment.confirmed,
    );
  }

  setUpAll(() async {
    mintAuthority = await Ed25519HDKeyPair.random();

    await requestAirdrop(mintAuthority);

    mint = await client.initializeMint(
      mintAuthority: mintAuthority,
      decimals: 5,
      commitment: Commitment.confirmed,
    );
  });

  Future<EscrowDataAccount> fetchEscrowAccount(
    Ed25519HDPublicKey escrowAccount,
  ) async {
    final account = await client.rpcClient.getAccountInfo(
      escrowAccount.toBase58(),
      encoding: Encoding.base64,
      commitment: Commitment.confirmed,
    );

    return EscrowDataAccount.fromAccountData(account.value!.data!);
  }

  Future<void> createEscrow(Accounts accounts) async {
    final instruction = await EscrowInstruction.initEscrow(
      amount: sendAmount,
      escrowAccount: accounts.escrowAccount.publicKey,
      senderAccount: accounts.senderAccount.publicKey,
      depositorAccount: accounts.depositorAccount.publicKey,
      senderTokenAccount: accounts.senderTokenAccount,
      vaultTokenAccount: accounts.vaultTokenAccount,
    );

    await client.sendAndConfirmTransaction(
      message: Message.only(instruction),
      signers: [
        accounts.depositorAccount,
        accounts.escrowAccount,
        accounts.senderAccount,
      ],
      commitment: Commitment.confirmed,
    );
  }

  Future<Accounts> createAccounts() async {
    final Ed25519HDKeyPair escrow = await Ed25519HDKeyPair.random();
    final Ed25519HDKeyPair sender = await Ed25519HDKeyPair.random();
    final Ed25519HDKeyPair receiver = await Ed25519HDKeyPair.random();
    final Ed25519HDKeyPair depositor = await Ed25519HDKeyPair.random();

    await requestAirdrop(sender);
    await requestAirdrop(receiver);
    await requestAirdrop(depositor);

    final sellerTokenAccount =
        await createAccount(client: client, owner: sender, mint: mint);

    await client.mintTo(
      mint: mint.address,
      destination: sellerTokenAccount,
      amount: initializerAmount,
      authority: mintAuthority,
      commitment: Commitment.confirmed,
    );

    return Accounts(
      escrowAccount: escrow,
      senderAccount: sender,
      receiverAccount: receiver,
      depositorAccount: depositor,
      senderTokenAccount: sellerTokenAccount,
      receiverTokenAccount:
          await createAccount(client: client, owner: receiver, mint: mint),
      vaultTokenAccount:
          await createAccount(client: client, owner: sender, mint: mint),
    );
  }

  test('Initialize Escrow', () async {
    final accounts = await createAccounts();

    await createEscrow(accounts);

    final escrowAccount =
        await fetchEscrowAccount(accounts.escrowAccount.publicKey);

    expect(EscrowStatus.pending, escrowAccount.status);

    final senderTokenAccount = await getTokenAccountBalance(
      client: client,
      account: accounts.senderTokenAccount,
    );

    expect(
      initializerAmount - sendAmount,
      int.tryParse(senderTokenAccount!.amount) ?? 0,
    );

    final depositorTokenAccount = await getTokenAccountBalance(
      client: client,
      account: accounts.vaultTokenAccount,
    );

    expect(
      sendAmount,
      int.tryParse(depositorTokenAccount!.amount) ?? 0,
    );
  });

  test('Cancel Escrow', () async {
    final accounts = await createAccounts();

    await createEscrow(accounts);

    final instruction = await EscrowInstruction.cancelEscrow(
      escrowAccount: accounts.escrowAccount.publicKey,
      senderAccount: accounts.senderAccount.publicKey,
      depositorAccount: accounts.depositorAccount.publicKey,
      senderTokenAccount: accounts.senderTokenAccount,
      vaultTokenAccount: accounts.vaultTokenAccount,
    );

    await client.sendAndConfirmTransaction(
      message: Message.only(instruction),
      signers: [
        accounts.depositorAccount,
        accounts.senderAccount,
      ],
      commitment: Commitment.confirmed,
    );

    final escrowAccount =
        await fetchEscrowAccount(accounts.escrowAccount.publicKey);

    expect(EscrowStatus.canceled, escrowAccount.status);
  });

  test('Complete Escrow', () async {
    final accounts = await createAccounts();

    await createEscrow(accounts);

    final instruction = await EscrowInstruction.completeEscrow(
      escrowAccount: accounts.escrowAccount.publicKey,
      receiverTokenAccount: accounts.receiverTokenAccount,
      depositorAccount: accounts.depositorAccount.publicKey,
      senderTokenAccount: accounts.senderTokenAccount,
      vaultTokenAccount: accounts.vaultTokenAccount,
    );

    await client.sendAndConfirmTransaction(
      message: Message.only(instruction),
      signers: [
        accounts.depositorAccount,
        accounts.escrowAccount,
      ],
      commitment: Commitment.confirmed,
    );

    final escrowAccount =
        await fetchEscrowAccount(accounts.escrowAccount.publicKey);

    expect(EscrowStatus.completed, escrowAccount.status);
  });
}
