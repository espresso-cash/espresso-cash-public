import 'package:espressocash_app/core/transactions/tx_sender.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:solana/dto.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

import '../../utils.dart';

Future<void> main() async {
  final client = createTestSolanaClient();
  final sender = await Ed25519HDKeyPair.random();
  await client.requestAirdrop(
    address: sender.publicKey,
    lamports: lamportsPerSol,
    commitment: Commitment.confirmed,
  );

  final service = TxSender(client: client);

  test('Sends tx', () async {
    final message = Message.only(
      MemoInstruction(signers: [sender.publicKey], memo: 'Sends tx'),
    );
    final tx = await signTransaction(
      await client.rpcClient
          .getRecentBlockhash(commitment: Commitment.confirmed),
      message,
      [sender],
    );

    final result = await service.send(tx);

    expect(result, const TxSendResult.sent());
  });

  test('Invalid blockhash', () async {
    final message = Message.only(
      MemoInstruction(signers: [sender.publicKey], memo: 'Invalid blockhash'),
    );
    const invalidBlockhash = RecentBlockhash(
      blockhash: 'EkSnNWid2cvwEVnVx9aBqawnmiCNiDgp3gUdkDPTKN1N',
      feeCalculator: FeeCalculator(lamportsPerSignature: 5000),
    );

    final tx = await signTransaction(invalidBlockhash, message, [sender]);

    final result = await service.send(tx);

    expect(result, const TxSendResult.invalidBlockhash());
  });

  test('Duplicate', () async {
    final message = Message.only(
      MemoInstruction(signers: [sender.publicKey], memo: 'Duplicate'),
    );
    final tx = await signTransaction(
      await client.rpcClient
          .getRecentBlockhash(commitment: Commitment.confirmed),
      message,
      [sender],
    );

    await service.send(tx);
    await client.waitForSignatureStatus(tx.id, status: Commitment.confirmed);
    final result = await service.send(tx);

    expect(result, const TxSendResult.sent());
  });

  test('Failure', () async {
    final message = Message.only(
      MemoInstruction(signers: [sender.publicKey], memo: 'Failure'),
    );

    final b = await client.rpcClient
        .getRecentBlockhash(commitment: Commitment.confirmed)
        .then((value) => value.blockhash);
    final compiled = message.compile(recentBlockhash: b);
    final tx = SignedTx(
      messageBytes: compiled.data,
    );

    final result = await service.send(tx);

    expect(result, const TxSendResult.failure());
  });

  test('Wait for confirmation', () async {
    final message = Message.only(
      MemoInstruction(
        signers: [sender.publicKey],
        memo: 'Wait for confirmation',
      ),
    );
    final tx = await signTransaction(
      await client.rpcClient
          .getRecentBlockhash(commitment: Commitment.confirmed),
      message,
      [sender],
    );

    await service.send(tx);
    final result = await service.wait(tx);

    expect(result, const TxWaitResult.success());
  });

  test('Wait for confirmation if already confirmed', () async {
    final message = Message.only(
      MemoInstruction(
        signers: [sender.publicKey],
        memo: 'Wait for confirmation if already confirmed',
      ),
    );
    final tx = await signTransaction(
      await client.rpcClient
          .getRecentBlockhash(commitment: Commitment.confirmed),
      message,
      [sender],
    );

    await service.send(tx);
    await client.waitForSignatureStatus(tx.id, status: Commitment.confirmed);
    final result = await service.wait(tx);

    expect(result, const TxWaitResult.success());
  });
}
