import 'package:espressocash_backend/src/constants.dart';
import 'package:espressocash_backend/src/payments/create_direct_payment.dart';
import 'package:solana/solana.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../config.dart';
import 'utils.dart';

void main() {
  final client = createTestSolanaClient();

  /// Initial token amount for the sender after creation.
  const senderInitialAmount = 500000;

  const transferAmount = 300000;

  test('Receiver does not have ATA', () async {
    final data = await createTestData(
      client: client,
      senderInitialAmount: senderInitialAmount,
    );
    final sender = data.sender;
    final platform = data.platform;
    final mint = data.mint;

    final receiver = await Ed25519HDKeyPair.random();

    final payment = await createDirectPayment(
      aSender: sender.publicKey,
      aReceiver: receiver.publicKey,
      aReference: null,
      mint: mint,
      amount: transferAmount,
      platform: platform,
      client: client,
      commitment: Commitment.confirmed,
    );

    expect(payment.fee, directPaymentWithAccountCreationFee);

    // Sender has to resign the transaction with their private key. The tx is
    // already partially signed by the platform.
    final resignedTx = await payment.transaction.resign(sender);

    final signature = await client.rpcClient.sendTransaction(
      resignedTx.encode(),
      preflightCommitment: Commitment.confirmed,
    );

    await client.waitForSignatureStatus(
      signature,
      status: Commitment.confirmed,
    );

    expect(
      await client.getMintBalance(sender.publicKey, mint: mint),
      senderInitialAmount - transferAmount - payment.fee,
    );
    expect(
      await client.getMintBalance(receiver.publicKey, mint: mint),
      transferAmount,
    );
    expect(
      await client.getMintBalance(platform.publicKey, mint: mint),
      payment.fee,
    );
  });

  test('Receiver has ATA', () async {
    final data = await createTestData(
      client: client,
      senderInitialAmount: senderInitialAmount,
    );
    final sender = data.sender;
    final platform = data.platform;
    final mint = data.mint;

    final receiver = await Ed25519HDKeyPair.random();

    await client.createAssociatedTokenAccount(
      mint: mint,
      funder: data.mintAuthority,
      owner: receiver.publicKey,
      commitment: Commitment.confirmed,
    );

    final payment = await createDirectPayment(
      aSender: sender.publicKey,
      aReceiver: receiver.publicKey,
      aReference: null,
      mint: mint,
      amount: transferAmount,
      platform: platform,
      client: client,
      commitment: Commitment.confirmed,
    );

    expect(payment.fee, directPaymentFee);

    // Sender has to resign the transaction with their private key. The tx is
    // already partially signed by the platform.
    final resignedTx = await payment.transaction.resign(sender);

    final signature = await client.rpcClient.sendTransaction(
      resignedTx.encode(),
      preflightCommitment: Commitment.confirmed,
    );

    await client.waitForSignatureStatus(
      signature,
      status: Commitment.confirmed,
    );

    expect(
      await client.getMintBalance(sender.publicKey, mint: mint),
      senderInitialAmount - transferAmount - payment.fee,
    );
    expect(
      await client.getMintBalance(receiver.publicKey, mint: mint),
      transferAmount,
    );
    expect(
      await client.getMintBalance(platform.publicKey, mint: mint),
      payment.fee,
    );
  });
}
