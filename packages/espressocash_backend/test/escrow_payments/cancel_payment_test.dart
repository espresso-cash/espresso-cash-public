import 'package:dfunc/dfunc.dart';
import 'package:espressocash_backend/src/constants.dart';
import 'package:espressocash_backend/src/escrow_payments/cancel_payment.dart';
import 'package:espressocash_backend/src/escrow_payments/create_payment.dart';
import 'package:solana/solana.dart';
import 'package:test/test.dart';

import '../config.dart';
import '../payments/utils.dart';
import 'utils.dart';

void main() {
  final client = createTestSolanaClient();

  /// Initial token amount for the sender after creation.
  const senderInitialAmount = 500000;

  const transferAmount = 300000;

  test('cancels payment', () async {
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

    // Sender and Escrow has to resign the transaction with their private key. The tx is
    // already partially signed by the platform.
    final resignedTx = await result.item1
        .resign(testData.sender)
        .letAsync((tx) => tx.resign(escrowAccount));

    final signature = await client.rpcClient.sendTransaction(
      resignedTx.encode(),
      preflightCommitment: Commitment.confirmed,
    );

    await client.waitForSignatureStatus(
      signature,
      status: Commitment.confirmed,
    );

    final receiveResult = await cancelPaymentTx(
      aEscrow: escrowAccount.publicKey,
      aSender: testData.sender.publicKey,
      mint: testData.mint,
      platform: testData.platform,
      client: client,
      commitment: Commitment.confirmed,
    );

    final resignedReceiveTx = await receiveResult.item1.resign(testData.sender);

    final signatureReceive = await client.rpcClient.sendTransaction(
      resignedReceiveTx.encode(),
      preflightCommitment: Commitment.confirmed,
    );

    await client.waitForSignatureStatus(
      signatureReceive,
      status: Commitment.confirmed,
    );

    final senderBalance = await client.getMintBalance(
      testData.sender.publicKey,
      mint: testData.mint,
    );

    // Receiver should get the expected amount.
    expect(senderBalance, senderInitialAmount - escrowPaymentFee);
  });
}
