import 'package:mews_pedantic/mews_pedantic.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

@immutable
class TestData {
  const TestData({
    required this.mint,
    required this.platform,
    required this.sender,
  });

  final Ed25519HDPublicKey mint;
  final Ed25519HDKeyPair platform;
  final Ed25519HDKeyPair sender;
}

Future<TestData> createTestData({
  required SolanaClient client,
  required int senderInitialAmount,
}) async {
  final mintAuthority = await Ed25519HDKeyPair.random();

  await client.requestAirdrop(
    address: mintAuthority.publicKey,
    lamports: 5 * lamportsPerSol,
    commitment: Commitment.confirmed,
  );
  final mint = await client.initializeMint(
    mintAuthority: mintAuthority,
    decimals: 2,
    commitment: Commitment.confirmed,
  );

  Future<Ed25519HDKeyPair> createSender() async {
    final sender = await Ed25519HDKeyPair.random();
    final account = await client.createAssociatedTokenAccount(
      mint: mint.address,
      funder: mintAuthority,
      owner: sender.publicKey,
      commitment: Commitment.confirmed,
    );
    final ataSender = Ed25519HDPublicKey.fromBase58(account.pubkey);

    await client.mintTo(
      mint: mint.address,
      destination: ataSender,
      amount: senderInitialAmount,
      authority: mintAuthority,
      commitment: Commitment.confirmed,
    );

    return sender;
  }

  /// Creates platform system account and ATA, and airdrops 5 SOL to the system
  /// account, as platform is supposed to pay all the fees.
  Future<Ed25519HDKeyPair> createPlatform() async {
    final platform = await Ed25519HDKeyPair.random();
    await client.requestAirdrop(
      address: platform.publicKey,
      lamports: 5 * lamportsPerSol,
      commitment: Commitment.confirmed,
    );

    await client.createAssociatedTokenAccount(
      mint: mint.address,
      funder: mintAuthority,
      owner: platform.publicKey,
      commitment: Commitment.confirmed,
    );

    return platform;
  }

  return TestData(
    mint: mint.address,
    platform: await createPlatform(),
    sender: await createSender(),
  );
}

extension SolanaClientExt on SolanaClient {
  Future<int> getMintBalance(
    Ed25519HDPublicKey account, {
    required Ed25519HDPublicKey mint,
  }) async {
    final balance = await getTokenBalance(
      owner: account,
      mint: mint,
      commitment: Commitment.confirmed,
    );

    return int.parse(balance.amount);
  }
}

extension Ed25519HDKeyPairExt on Ed25519HDKeyPair {
  Future<SignedTx> resign(SignedTx tx) async {
    final compiledMessage =
        CompiledMessage.fromSignedTransaction(tx.toByteArray());

    return SignedTx(
      signatures: tx.signatures.toList()
        ..removeLast()
        ..add(await sign(compiledMessage.data)),
      messageBytes: compiledMessage.data,
    );
  }
}
