import 'package:espressocash_backend/src/payments/create_payment.dart';
import 'package:espressocash_backend/src/payments/receive_payment.dart';
import 'package:solana/dto.dart';
import 'package:solana/solana.dart';
import 'package:test/test.dart';

import '../config.dart';
import 'utils.dart';

void main() {
  final client = createTestSolanaClient();

  /// Initial token amount for the sender after creation.
  const senderInitialAmount = 500000;

  const transferAmount = 300000;

  test('receives payment', () async {
    final testData = await createTestData(
      client: client,
      senderInitialAmount: senderInitialAmount,
    );

    final escrowAccount = await Ed25519HDKeyPair.random();
    final receiverAccount = await Ed25519HDKeyPair.random();

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
    final resignedTx = await result.item1.resign(testData.sender);

    final signature = await client.rpcClient.sendTransaction(
      resignedTx.encode(),
      preflightCommitment: Commitment.confirmed,
    );

    await client.waitForSignatureStatus(
      signature,
      status: Commitment.confirmed,
    );

    final prePlatformBalance = await client.rpcClient
        .getBalance(testData.platform.address, commitment: Commitment.confirmed)
        .value;

    final receiveResult = await receivePaymentTx(
      aEscrow: escrowAccount.publicKey,
      aReceiver: receiverAccount.publicKey,
      mint: testData.mint,
      platform: testData.platform,
      client: client,
      commitment: Commitment.confirmed,
    );

    final resignedReceiveTx = await receiveResult.item1.resign(escrowAccount);

    final signatureReceive = await client.rpcClient.sendTransaction(
      resignedReceiveTx.encode(),
      preflightCommitment: Commitment.confirmed,
    );

    await client.waitForSignatureStatus(
      signatureReceive,
      status: Commitment.confirmed,
    );

    final postPlatformBalance = await client.rpcClient
        .getBalance(testData.platform.address, commitment: Commitment.confirmed)
        .value;

    // Platform pays for 2 signatures: platform itself as a fee payer and escrow
    // for the transfer.
    expect(prePlatformBalance - postPlatformBalance, _lamportsPerSignature * 2);

    final receiverBalance = await client.getMintBalance(
      receiverAccount.publicKey,
      mint: testData.mint,
    );

    // Receiver should get the expected amount.
    expect(receiverBalance, transferAmount);
  });

  test('platform does not create ATA if not needed', () async {
    final testData = await createTestData(
      client: client,
      senderInitialAmount: senderInitialAmount,
    );

    final escrowAccount = await Ed25519HDKeyPair.random();
    final receiverAccount = await Ed25519HDKeyPair.random();
    await client.createAssociatedTokenAccount(
      mint: testData.mint,
      owner: receiverAccount.publicKey,
      funder: testData.platform,
      commitment: Commitment.confirmed,
    );

    final createPaymentResult = await createPaymentTx(
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
    final resignedTx = await createPaymentResult.item1.resign(testData.sender);

    final signature = await client.rpcClient.sendTransaction(
      resignedTx.encode(),
      preflightCommitment: Commitment.confirmed,
    );

    await client.waitForSignatureStatus(
      signature,
      status: Commitment.confirmed,
    );

    final prePlatformBalance = await client.rpcClient
        .getBalance(testData.platform.address, commitment: Commitment.confirmed)
        .value;

    final receiveResult = await receivePaymentTx(
      aEscrow: escrowAccount.publicKey,
      aReceiver: receiverAccount.publicKey,
      mint: testData.mint,
      platform: testData.platform,
      client: client,
      commitment: Commitment.confirmed,
    );

    final resignedReceiveTx = await receiveResult.item1.resign(escrowAccount);

    final signatureReceive = await client.rpcClient.sendTransaction(
      resignedReceiveTx.encode(),
      preflightCommitment: Commitment.confirmed,
    );

    await client.waitForSignatureStatus(
      signatureReceive,
      status: Commitment.confirmed,
    );

    final postPlatformBalance = await client.rpcClient
        .getBalance(testData.platform.address, commitment: Commitment.confirmed)
        .value;

    // Platform pays for 2 signatures: platform itself as a fee payer and escrow
    // for the transfer. Since the receiver has an ATA, the platform does not
    // pay for its creation and gets the rent from terminating escrow ATA.
    expect(
      postPlatformBalance - prePlatformBalance,
      _accountRent - _lamportsPerSignature * 2,
    );

    final receiverBalance = await client.getMintBalance(
      receiverAccount.publicKey,
      mint: testData.mint,
    );

    // Receiver should get the expected amount.
    expect(receiverBalance, transferAmount);
  });
}

const _lamportsPerSignature = 5000;
const _accountRent = 2039280;
