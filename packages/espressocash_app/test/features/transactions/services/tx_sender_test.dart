import 'package:espressocash_app/features/transactions/models/tx_results.dart';
import 'package:espressocash_app/features/transactions/services/tx_sender.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:solana/dto.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

import '../../../utils.dart';

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
    final bh = await client.rpcClient
        .getLatestBlockhash(commitment: Commitment.confirmed)
        .value;
    final tx = await signTransaction(
      RecentBlockhash(
        blockhash: bh.blockhash,
        feeCalculator: const FeeCalculator(lamportsPerSignature: 500),
      ),
      message,
      [sender],
    );

    final result = await service.send(tx, minContextSlot: BigInt.zero);

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

    final result = await service.send(tx, minContextSlot: BigInt.zero);

    expect(result, const TxSendResult.invalidBlockhash());
  });

  test('Duplicate', () async {
    final message = Message.only(
      MemoInstruction(signers: [sender.publicKey], memo: 'Duplicate'),
    );
    final bh = await client.rpcClient
        .getLatestBlockhash(commitment: Commitment.confirmed)
        .value;
    final tx = await signTransaction(
      RecentBlockhash(
        blockhash: bh.blockhash,
        feeCalculator: const FeeCalculator(lamportsPerSignature: 500),
      ),
      message,
      [sender],
    );

    await service.send(tx, minContextSlot: BigInt.zero);
    await client.waitForSignatureStatus(tx.id, status: Commitment.confirmed);
    final result = await service.send(tx, minContextSlot: BigInt.zero);

    expect(result, const TxSendResult.sent());
  });

  test('Failure', () async {
    final message = Message.only(
      MemoInstruction(signers: [sender.publicKey], memo: 'Failure'),
    );

    final b = await client.rpcClient
        .getLatestBlockhash(commitment: Commitment.confirmed)
        .value
        .then((value) => value.blockhash);
    final compiled = message.compile(
      recentBlockhash: b,
      feePayer: sender.publicKey,
    );
    final tx = SignedTx(compiledMessage: compiled);

    final result = await service.send(tx, minContextSlot: BigInt.zero);

    expect(
      result,
      const TxSendResult.failure(reason: TxFailureReason.txError),
    );
  });

  test('Wait for confirmation', () async {
    final message = Message.only(
      MemoInstruction(
        signers: [sender.publicKey],
        memo: 'Wait for confirmation',
      ),
    );
    final bh = await client.rpcClient
        .getLatestBlockhash(commitment: Commitment.confirmed)
        .value;
    final tx = await signTransaction(
      RecentBlockhash(
        blockhash: bh.blockhash,
        feeCalculator: const FeeCalculator(lamportsPerSignature: 500),
      ),
      message,
      [sender],
    );

    await service.send(tx, minContextSlot: BigInt.zero);
    final result = await service.wait(
      tx,
      minContextSlot: BigInt.zero,
      txType: 'Test',
    );

    expect(result, const TxWaitResult.success());
  });

  test('Wait for confirmation if already confirmed', () async {
    final message = Message.only(
      MemoInstruction(
        signers: [sender.publicKey],
        memo: 'Wait for confirmation if already confirmed',
      ),
    );
    final bh = await client.rpcClient
        .getLatestBlockhash(commitment: Commitment.confirmed)
        .value;
    final tx = await signTransaction(
      RecentBlockhash(
        blockhash: bh.blockhash,
        feeCalculator: const FeeCalculator(lamportsPerSignature: 500),
      ),
      message,
      [sender],
    );

    await service.send(tx, minContextSlot: BigInt.zero);
    await client.waitForSignatureStatus(tx.id, status: Commitment.confirmed);
    final result = await service.wait(
      tx,
      minContextSlot: BigInt.zero,
      txType: 'Test',
    );

    expect(result, const TxWaitResult.success());
  });
}
