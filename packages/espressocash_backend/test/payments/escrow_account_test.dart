import 'package:espressocash_backend/src/payments/create_payment.dart';
import 'package:espressocash_backend/src/payments/escrow_account.dart';
import 'package:solana/solana.dart';
import 'package:test/test.dart';

import '../config.dart';
import 'utils.dart';

void main() {
  final client = createTestSolanaClient();

  /// Initial token amount for the sender after creation.
  const senderInitialAmount = 500000;

  const transferAmount = 300000;

  test('account without transactions fails', () async {
    final testData = await createTestData(
      client: client,
      senderInitialAmount: senderInitialAmount,
    );

    final account = await Ed25519HDKeyPair.random();

    final escrow = await tryFetchEscrow(
      address: account.publicKey,
      platform: testData.platform,
      mint: testData.mint,
      client: client,
      commitment: Commitment.confirmed,
    );

    expect(escrow, isNull);
  });

  test('account with random transaction fails', () async {
    final testData = await createTestData(
      client: client,
      senderInitialAmount: 10,
    );

    final account = await Ed25519HDKeyPair.random();

    await client.requestAirdrop(
      address: account.publicKey,
      lamports: lamportsPerSol,
      commitment: Commitment.confirmed,
    );

    final escrow = await tryFetchEscrow(
      address: account.publicKey,
      platform: testData.platform,
      mint: testData.mint,
      client: client,
      commitment: Commitment.confirmed,
    );

    expect(escrow, isNull);
  });

  test('account with proper payments succeeds', () async {
    final testData = await createTestData(
      client: client,
      senderInitialAmount: senderInitialAmount,
    );

    final escrowAccount = await Ed25519HDKeyPair.random();

    final result = await createPaymentTx(
      aSender: testData.sender.publicKey,
      aEscrow: escrowAccount.publicKey,
      mint: testData.mint,
      amount: transferAmount,
      client: client,
      platform: testData.platform,
      commitment: Commitment.confirmed,
    );

    // Sender has to resign the transaction with their private key. The tx is
    // already partially signed by the platform.
    final resignedTx = await testData.sender.resign(result.item1);

    final signature = await client.rpcClient.sendTransaction(
      resignedTx.encode(),
      preflightCommitment: Commitment.confirmed,
    );

    await client.waitForSignatureStatus(
      signature,
      status: Commitment.confirmed,
    );

    final escrow = await tryFetchEscrow(
      address: escrowAccount.publicKey,
      platform: testData.platform,
      mint: testData.mint,
      client: client,
      commitment: Commitment.confirmed,
    );

    if (escrow == null) {
      fail('escrow account not found');
    }

    expect(escrow.amount, transferAmount);
  });
}
