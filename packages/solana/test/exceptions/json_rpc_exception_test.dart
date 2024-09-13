import 'package:solana/dto.dart';
import 'package:solana/solana.dart';
import 'package:test/test.dart';

import '../config.dart';

Future<void> main() async {
  final client = createTestSolanaClient();
  final account = await Ed25519HDKeyPair.random();

  setUpAll(() async {
    await client.requestAirdrop(
      address: account.publicKey,
      lamports: lamportsPerSol,
      commitment: Commitment.confirmed,
    );
  });

  final message =
      Message.only(MemoInstruction(signers: [account.publicKey], memo: 'test'));

  test('recognizes BlockhashNotFoundException', () async {
    final tx = await account.signMessage(
      message: message,
      recentBlockhash: '8yz3T3m319zRKdf6HNzkm3cxRKPe3f3wLePYYknX9Qrx',
    );

    final result = client.rpcClient.sendTransaction(
      tx.encode(),
      preflightCommitment: Commitment.confirmed,
    );

    await expectLater(
      result,
      throwsA(
        isA<JsonRpcException>().having(
          (e) => e.transactionError,
          'err',
          TransactionError.blockhashNotFound,
        ),
      ),
    );
  });

  test('recognizes AlreadyProcessedException', () async {
    final b = await client.rpcClient
        .getLatestBlockhash(commitment: Commitment.confirmed)
        .value;

    final tx = await account.signMessage(
      message: message,
      recentBlockhash: b.blockhash,
    );

    final first = await client.rpcClient.sendTransaction(
      tx.encode(),
      preflightCommitment: Commitment.confirmed,
    );

    await client.waitForSignatureStatus(first, status: Commitment.confirmed);

    final result = client.rpcClient.sendTransaction(
      tx.encode(),
      preflightCommitment: Commitment.confirmed,
    );

    await expectLater(
      result,
      throwsA(
        isA<JsonRpcException>().having(
          (e) => e.transactionError,
          'err',
          TransactionError.alreadyProcessed,
        ),
      ),
    );
  });
}
