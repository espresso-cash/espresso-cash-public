import 'dart:io';

import 'package:bip39/bip39.dart';
import 'package:solana_dart/solana_dart.dart';
import 'package:solana_dart/src/solana_wallet.dart';
import 'package:solana_dart/src/types/account_info.dart';
import 'package:solana_dart/src/types/blockhash.dart';
import 'package:solana_dart/src/types/signature_status.dart';
import 'package:solana_dart/src/types/simulate_tx_result.dart';
import 'package:solana_dart/src/types/transaction.dart';
import 'package:solana_dart/src/types/tx_signature.dart';
import 'package:test/test.dart';

void main() {
  final devnetRpcUrl =
      Platform.environment['DEVNET_RPC_URL'] ?? 'http://127.0.0.1:8899';

  group('SolanaClient testsuite', () {
    final SolanaWallet targetWallet = SolanaWallet.fromMnemonic(
      generateMnemonic(),
    );
    final SolanaClient solanaClient = SolanaClient(devnetRpcUrl);
    final SolanaWallet sourceWallet = SolanaWallet.fromMnemonic(
      generateMnemonic(),
    );
    int currentBalance = 0;

    test('Can call requestAirdrop and add SOL to an account', () async {
      final int addedBalance = 100 * lamportsPerSol;
      final TxSignature signature = await solanaClient.requestAirdrop(
        sourceWallet.address,
        addedBalance,
        commitment: 'finalized',
      );
      expect(signature, isNot(null));
      await solanaClient.waitForSignatureStatus(
        signature,
        TxStatus.finalized,
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
      expect(accountInfo.owner, solanaSystemProgramID);
      expect(accountInfo.executable, false);
    });

    test('Can simulate a transfer', () async {
      const int transferredAmount = 7500;
      final SimulateTxResult transferResult =
          await solanaClient.simulateTransfer(
        sourceWallet,
        targetWallet.address,
        transferredAmount,
      );
      expect(transferResult.err, null);
    });

    test('Can transfer tokens', () async {
      const int transferredAmount = 7500;
      final TxSignature signature = await solanaClient.transfer(
        sourceWallet,
        targetWallet.address,
        transferredAmount,
      );
      expect(signature, isNot(null));
      await solanaClient.waitForSignatureStatus(
        signature,
        TxStatus.finalized,
      );
      final int balance = await solanaClient.getBalance(targetWallet.address);
      expect(balance, greaterThan(0));
    });

    test('Can list recent transactions', () async {
      final txs = await solanaClient.getTransactionsList(sourceWallet.address);
      expect(txs, isNot(null));
      txs.forEach((TransactionResponse tx) => expect(tx, isNot(null)));
      expect(txs.length, greaterThan(0));
    });
  });
}
