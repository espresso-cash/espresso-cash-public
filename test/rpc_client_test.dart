import 'dart:io';

import 'package:bip39/bip39.dart';
import 'package:solana/solana.dart';
import 'package:solana/src/encoder/encoder.dart';
import 'package:solana/src/signer.dart';
import 'package:solana/src/types/commitment.dart';
import 'package:solana/src/types/transaction/instruction.dart';
import 'package:solana/src/types/transaction/transaction_result.dart';
import 'package:test/test.dart';

const int _transferredAmount = 0x1000;

void main() {
  final devnetRpcUrl =
      Platform.environment['DEVNET_RPC_URL'] ?? 'http://127.0.0.1:8899';

  group('SolanaClient testsuite', () {
    final RPCClient solanaClient = RPCClient(devnetRpcUrl);
    late Signer targetWallet;
    late Signer sourceWallet;
    int currentBalance = 0;

    setUpAll(() async {
      targetWallet = await Signer.fromMnemonic(
        generateMnemonic(),
      ); // generateMnemonic());
      sourceWallet = await Signer.fromMnemonic(
        generateMnemonic(),
        walletIndex: 1,
      );
    });

    test('Can call requestAirdrop and add SOL to an account', () async {
      const int addedBalance = 100 * lamportsPerSol;
      final TxSignature signature = await solanaClient.requestAirdrop(
        sourceWallet.address,
        addedBalance,
      );
      expect(signature, isNot(null));
      await expectLater(
        solanaClient.waitForSignatureStatus(
          signature,
          Commitment.finalized,
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
      final int balance = await solanaClient.getBalance(
        sourceWallet.address,
      );
      expect(balance, currentBalance);
    });

    test('Can get all the account information of an account', () async {
      final Account accountInfo = await solanaClient.getAccountInfo(
        sourceWallet.address,
      );
      expect(accountInfo.lamports, currentBalance);
      expect(accountInfo.owner, SystemProgram.id);
      expect(accountInfo.executable, false);
    });

    test('Can simulate a transfer', () async {
      final recentBlockhash = await solanaClient.getRecentBlockhash();
      final message = Message.transfer(
        source: sourceWallet.address,
        destination: targetWallet.address,
        lamports: _transferredAmount,
      );
      final SignedTx signedTx = await sourceWallet.signMessage(
        message: message,
        recentBlockhash: recentBlockhash,
      );
      final SimulateTxResult transferResult =
          await solanaClient.simulateTransaction(signedTx);
      expect(transferResult.err, null);
    });

    test('Can transfer tokens', () async {
      final recentBlockhash = await solanaClient.getRecentBlockhash();
      final message = Message.transfer(
        source: sourceWallet.address,
        destination: targetWallet.address,
        lamports: _transferredAmount,
      );
      final SignedTx signedTx = await sourceWallet.signMessage(
        message: message,
        recentBlockhash: recentBlockhash,
      );
      final TxSignature signature =
          await solanaClient.sendTransaction(signedTx);
      expect(signature, isNot(null));
      await expectLater(
        solanaClient.waitForSignatureStatus(
          signature,
          Commitment.finalized,
        ),
        completes,
      );
      final int balance = await solanaClient.getBalance(targetWallet.address);
      expect(balance, greaterThan(0));
    });

    test('Can transfer to the same address', () async {
      final recentBlockhash = await solanaClient.getRecentBlockhash();
      final message = Message.transfer(
        source: sourceWallet.address,
        destination: sourceWallet.address,
        lamports: _transferredAmount,
      );
      final SignedTx signedTx = await sourceWallet.signMessage(
        message: message,
        recentBlockhash: recentBlockhash,
      );
      final TxSignature signature =
          await solanaClient.sendTransaction(signedTx);
      expect(signature, isNot(null));

      await expectLater(
        solanaClient.waitForSignatureStatus(
          signature,
          Commitment.finalized,
        ),
        completes,
      );
    });

    test('Can transfer with memo', () async {
      const memoText = 'Memo test string...';
      final recentBlockhash = await solanaClient.getRecentBlockhash();

      final message = Message.transfer(
        source: sourceWallet.address,
        destination: targetWallet.address,
        lamports: _transferredAmount,
        memo: memoText,
      );
      final SignedTx signedTx = await sourceWallet.signMessage(
        message: message,
        recentBlockhash: recentBlockhash,
      );
      final TxSignature signature = await solanaClient.sendTransaction(
        signedTx,
      );
      expect(signature, isNot(null));

      await expectLater(
        solanaClient.waitForSignatureStatus(
          signature,
          Commitment.finalized,
        ),
        completes,
      );

      final result =
          await solanaClient.getConfirmedTransaction(signature.toString());
      expect(result, isNot(null));
      expect(result?.transaction, isNot(null));
      final transaction = result!.transaction;
      expect(transaction.message, isNot(null));
      final txMessage = transaction.message!;
      expect(txMessage.instructions, isNot(null));
      final instructions = txMessage.instructions;
      expect(instructions.length, equals(2));
      expect(instructions[0], const TypeMatcher<TxSystemInstruction>());
      expect(instructions[1], const TypeMatcher<TxMemoInstruction>());
      final memoInstruction = instructions[1] as TxMemoInstruction;
      expect(memoInstruction.memo, equals(memoText));
    });

    test('Can list recent transactions', () async {
      final txs = await solanaClient.getTransactionsList(sourceWallet.address);
      expect(txs, isNot(null));

      txs.forEach((TransactionResult? tx) => expect(tx, isNot(null)));
      expect(txs.length, greaterThan(0));
    });
  });

  group('Test commitment', () {
    final RPCClient solanaClient = RPCClient(devnetRpcUrl);
    late Signer wallet;

    setUp(() async {
      wallet = await Signer.fromMnemonic(generateMnemonic());
    });

    test('Balance is not updated until tx is finalized', () async {
      const int addedBalance = 5 * lamportsPerSol;
      final TxSignature signature = await solanaClient.requestAirdrop(
        wallet.address,
        addedBalance,
        commitment: Commitment.finalized,
      );

      await expectLater(
        solanaClient.waitForSignatureStatus(signature, Commitment.confirmed),
        completes,
      );

      var balance = await solanaClient.getBalance(wallet.address);
      expect(balance, 0);

      await expectLater(
        solanaClient.waitForSignatureStatus(signature, Commitment.finalized),
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
        commitment: Commitment.finalized,
      );

      await expectLater(
        solanaClient.waitForSignatureStatus(signature, Commitment.confirmed),
        completes,
      );
      final balance = await solanaClient.getBalance(
        wallet.address,
        commitment: Commitment.confirmed,
      );
      expect(balance, greaterThan(0));
    });
  });
}
