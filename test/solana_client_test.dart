import 'dart:io';

import 'package:bip39/bip39.dart';
import 'package:solana/solana.dart';
import 'package:solana/src/solana_serializable/signed_tx.dart';
import 'package:test/test.dart';

void main() {
  final devnetRpcUrl =
      Platform.environment['DEVNET_RPC_URL'] ?? 'http://127.0.0.1:8899';

  group('SolanaClient testsuite', () {
    final SolanaClient solanaClient = SolanaClient(devnetRpcUrl);
    late SolanaWallet targetWallet;
    late SolanaWallet sourceWallet;
    int currentBalance = 0;

    setUpAll(() async {
      targetWallet = await SolanaWallet.fromMnemonic(generateMnemonic());
      sourceWallet = await SolanaWallet.fromMnemonic(
        generateMnemonic(),
        walletIndex: 1,
      );
    });

    test('Can call requestAirdrop and add SOL to an account', () async {
      const int addedBalance = 100 * lamportsPerSol;
      final TxSignature signature = await solanaClient.requestAirdrop(
        sourceWallet.address,
        addedBalance,
        commitment: TxStatus.finalized,
      );
      expect(signature, isNot(null));
      await expectLater(
        solanaClient.waitForSignatureStatus(
          signature,
          TxStatus.finalized,
        ),
        completes,
      );
      final int balance = await solanaClient.getBalance(sourceWallet.address);
      // Update the global balance
      currentBalance += addedBalance;
      // Check that it matches
      expect(balance, currentBalance);
    });

    test('Can read the recent blockhash', () async {
      final Blockhash blockHash = await solanaClient.getRecentBlockhash();
      expect(blockHash, isNot(null));
      expect(blockHash.blockhash, isNot(null));
      expect(blockHash.blockhash, isNot(''));
      expect(blockHash.feeCalculator, isNot(null));
      expect(blockHash.feeCalculator.lamportsPerSignature, isNot(null));
    });

    test('Can read the balance of an account', () async {
      final int balance = await solanaClient.getBalance(sourceWallet.address);
      expect(balance, currentBalance);
    });

    test('Can get all the account information of an account', () async {
      final AccountInfo accountInfo =
          await solanaClient.getAccountInfo(sourceWallet.address);
      expect(accountInfo.lamports, currentBalance);
      expect(accountInfo.owner, systemProgramID);
      expect(accountInfo.executable, false);
    });

    test('Can simulate a transfer', () async {
      const int transferredAmount = 50000;
      final message = Message.transfer(
        source: sourceWallet.address,
        destination: targetWallet.address,
        lamports: transferredAmount,
        recentBlockhash: await solanaClient.getRecentBlockhash(),
      );
      final SignedTx signedTx = await sourceWallet.signMessage(message);
      final SimulateTxResult transferResult =
          await solanaClient.simulateTransaction(signedTx);
      expect(transferResult.err, null);
    });

    test('Can transfer tokens', () async {
      const int transferredAmount = 50000;
      final message = Message.transfer(
        source: sourceWallet.address,
        destination: targetWallet.address,
        lamports: transferredAmount,
        recentBlockhash: await solanaClient.getRecentBlockhash(),
      );
      final SignedTx signedTx = await sourceWallet.signMessage(message);
      final TxSignature signature =
          await solanaClient.sendTransaction(signedTx);
      print(signature);
      expect(signature, isNot(null));
      await expectLater(
        solanaClient.waitForSignatureStatus(
          signature,
          TxStatus.finalized,
        ),
        completes,
      );
      final int balance = await solanaClient.getBalance(targetWallet.address);
      expect(balance, greaterThan(0));
    });

    test('Can transfer to the same address', () async {
      const int transferredAmount = 50000;
      final message = Message.transfer(
        source: sourceWallet.address,
        destination: sourceWallet.address,
        lamports: transferredAmount,
        recentBlockhash: await solanaClient.getRecentBlockhash(),
      );
      final SignedTx signedTx = await sourceWallet.signMessage(message);
      final TxSignature signature =
          await solanaClient.sendTransaction(signedTx);
      expect(signature, isNot(null));

      await expectLater(
        solanaClient.waitForSignatureStatus(
          signature,
          TxStatus.finalized,
        ),
        completes,
      );
    });

    test('Can transfer with memo', () async {
      const int transferredAmount = 50000;
      const memoText = 'Memo test string...';

      final message = Message.transfer(
        source: sourceWallet.address,
        destination: targetWallet.address,
        lamports: transferredAmount,
        recentBlockhash: await solanaClient.getRecentBlockhash(),
        memo: memoText,
      );
      final SignedTx signedTx = await sourceWallet.signMessage(message);
      final TxSignature signature = await solanaClient.sendTransaction(
        signedTx,
      );
      expect(signature, isNot(null));

      await expectLater(
        solanaClient.waitForSignatureStatus(
          signature,
          TxStatus.finalized,
        ),
        completes,
      );

      final result = await solanaClient.getTransaction(signature.toString());
      expect(result, isNot(null));
      expect(result?.transaction, isNot(null));
      final transaction = result!.transaction;
      expect(transaction.message, isNot(null));
      final txMessage = transaction.message!;
      expect(txMessage.instructions, isNot(null));
      final instructions = txMessage.instructions;
      expect(instructions.length, equals(2));
      expect(instructions[0], const TypeMatcher<TransferInstruction>());
      expect(instructions[1], const TypeMatcher<MemoInstruction>());
      final memoInstruction = instructions[1] as MemoInstruction;
      expect(memoInstruction, equals(memoText));
    });

    test('Can list recent transactions', () async {
      final txs = await solanaClient.getTransactionsList(sourceWallet.address);
      expect(txs, isNot(null));

      txs.forEach((GetTransactionResult? tx) => expect(tx, isNot(null)));
      expect(txs.length, greaterThan(0));
    });
  });

  group('Test commitment', () {
    final SolanaClient solanaClient = SolanaClient(devnetRpcUrl);
    late SolanaWallet wallet;

    setUp(() async {
      wallet = await SolanaWallet.fromMnemonic(generateMnemonic());
    });

    test('Balance is not updated until tx is finalized', () async {
      const int addedBalance = 5 * lamportsPerSol;
      final TxSignature signature = await solanaClient.requestAirdrop(
        wallet.address,
        addedBalance,
        commitment: TxStatus.finalized,
      );

      await expectLater(
        solanaClient.waitForSignatureStatus(signature, TxStatus.confirmed),
        completes,
      );

      var balance = await solanaClient.getBalance(wallet.address);
      expect(balance, 0);

      await expectLater(
        solanaClient.waitForSignatureStatus(signature, TxStatus.finalized),
        completes,
      );
      balance = await solanaClient.getBalance(wallet.address);

      expect(balance, greaterThan(0));
    });

    test('Balance is updated if requested with confirmed commitment', () async {
      const int addedBalance = 5 * lamportsPerSol;
      final TxSignature signature = await solanaClient.requestAirdrop(
        wallet.address,
        addedBalance,
        commitment: TxStatus.finalized,
      );

      await expectLater(
        solanaClient.waitForSignatureStatus(signature, TxStatus.confirmed),
        completes,
      );
      final balance = await solanaClient.getBalance(
        wallet.address,
        commitment: TxStatus.confirmed,
      );
      expect(balance, greaterThan(0));
    });
  });
}
