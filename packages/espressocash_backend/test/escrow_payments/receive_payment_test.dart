import 'package:espressocash_backend/src/constants.dart';
import 'package:espressocash_backend/src/escrow_payments/create_payment.dart';
import 'package:espressocash_backend/src/escrow_payments/receive_payment.dart';
import 'package:solana/dto.dart';
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
  const escrowAccountRent = 1893120; // calculated for escrow account len = 144
  const lamportsPerSignature = 5000;
  const accountRent = 2039280;

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
    final resignedTx = await result.item1
        .resign(testData.sender)
        .then((tx) => tx.resign(escrowAccount));

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

    final resignedReceiveTx = await receiveResult.item1
        .resign(escrowAccount)
        .then((it) => it.resign(receiverAccount));

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

    // Platform pays for 3 signatures:
    // - platform itself as a fee payer;
    // - escrow for the transfer;
    // - receiver for the potential ATA creation.
    expect(
      postPlatformBalance - prePlatformBalance,
      escrowAccountRent - lamportsPerSignature * 3,
    );

    final receiverBalance = await client.getMintBalance(
      receiverAccount.publicKey,
      mint: testData.mint,
    );

    // Receiver should get the expected amount.
    expect(receiverBalance, transferAmount - escrowPaymentAccountCreationFee);
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
    final resignedTx = await createPaymentResult.item1
        .resign(testData.sender)
        .then((tx) => tx.resign(escrowAccount));

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

    final resignedReceiveTx = await receiveResult.item1
        .resign(escrowAccount)
        .then((it) => it.resign(receiverAccount));

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
      accountRent + escrowAccountRent - lamportsPerSignature * 2,
    );

    final receiverBalance = await client.getMintBalance(
      receiverAccount.publicKey,
      mint: testData.mint,
    );

    // Receiver should get the expected amount.
    expect(receiverBalance, transferAmount);
  });
}
