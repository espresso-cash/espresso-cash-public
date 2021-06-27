import 'package:bip39/bip39.dart';
import 'package:solana/solana.dart';
import 'package:solana/src/crypto/hd_keypair.dart';
import 'package:solana/src/encoder/encoder.dart';
import 'package:solana/src/system_program/system_program.dart';
import 'package:test/test.dart';

import 'config.dart';

const int _transferredAmount = 0x1000;

void main() {
  group('SolanaClient testsuite', () {
    final RPCClient rpcClient = RPCClient(devnetRpcUrl);
    late HDKeyPair destination;
    late HDKeyPair source;
    int currentBalance = 0;

    setUpAll(() async {
      destination = await HDKeyPair.fromMnemonic(
        generateMnemonic(),
      ); // generateMnemonic());
      source = await HDKeyPair.fromMnemonic(
        generateMnemonic(),
        account: 1,
      );
    });

    test('Call requestAirdrop and add SOL to an account works', () async {
      const int addedBalance = 100 * lamportsPerSol;
      final TxSignature signature = await rpcClient.requestAirdrop(
        address: source.address,
        lamports: addedBalance,
      );
      expect(signature, isNot(null));
      await expectLater(
        rpcClient.waitForSignatureStatus(
          signature,
          Commitment.finalized,
        ),
        completes,
      );
      final int balance = await rpcClient.getBalance(source.address);
      // Update the global balance
      currentBalance += addedBalance;
      // Check that it matches
      expect(balance, currentBalance);
    });

    test('Read the recent blockhash', () async {
      final Blockhash blockHash = await rpcClient.getRecentBlockhash();
      expect(blockHash, isNot(null));
      expect(blockHash.blockhash, isNot(null));
      expect(blockHash.blockhash, isNot(''));
      expect(blockHash.feeCalculator, isNot(null));
      expect(blockHash.feeCalculator.lamportsPerSignature, isNot(null));
    });

    test('Read the balance of an account', () async {
      final int balance = await rpcClient.getBalance(
        source.address,
      );
      expect(balance, currentBalance);
    });

    test('Get all the account information of an account', () async {
      final Account accountInfo = await rpcClient.getAccountInfo(
        source.address,
      );
      expect(accountInfo.lamports, currentBalance);
      expect(accountInfo.owner, SystemProgram.programId);
      expect(accountInfo.executable, false);
    });

    test('Simulate a transfer', () async {
      final recentBlockhash = await rpcClient.getRecentBlockhash();
      final message = SystemProgram.transfer(
        source: source.address,
        destination: destination.address,
        lamports: _transferredAmount,
      );
      final SignedTx signedTx = await source.signMessage(
        message: message,
        recentBlockhash: recentBlockhash,
      );
      final SimulateTxResult transferResult =
          await rpcClient.simulateTransaction(signedTx);
      expect(transferResult.err, null);
    });

    test('Transfer SOL', () async {
      final recentBlockhash = await rpcClient.getRecentBlockhash();
      final message = SystemProgram.transfer(
        source: source.address,
        destination: destination.address,
        lamports: _transferredAmount,
      );
      final SignedTx signedTx = await source.signMessage(
        message: message,
        recentBlockhash: recentBlockhash,
      );
      final TxSignature signature = await rpcClient.sendTransaction(signedTx);
      expect(signature, isNot(null));
      await expectLater(
        rpcClient.waitForSignatureStatus(
          signature,
          Commitment.finalized,
        ),
        completes,
      );
      final int balance = await rpcClient.getBalance(destination.address);
      expect(balance, greaterThan(0));
    });

    test('Transfer SOL to the same address', () async {
      final recentBlockhash = await rpcClient.getRecentBlockhash();
      final message = SystemProgram.transfer(
        source: source.address,
        destination: source.address,
        lamports: _transferredAmount,
      );
      final SignedTx signedTx = await source.signMessage(
        message: message,
        recentBlockhash: recentBlockhash,
      );
      final TxSignature signature = await rpcClient.sendTransaction(signedTx);
      expect(signature, isNot(null));

      await expectLater(
        rpcClient.waitForSignatureStatus(
          signature,
          Commitment.finalized,
        ),
        completes,
      );
    });

    test('List recent transactions', () async {
      final txs = await rpcClient.getTransactionsList(source.address);
      expect(txs, isNot(null));

      txs.forEach((TransactionResult? tx) => expect(tx, isNot(null)));
      expect(txs.length, greaterThan(0));
    });
  });

  group('Test commitment', () {
    final RPCClient solanaClient = RPCClient(devnetRpcUrl);
    late HDKeyPair wallet;

    setUp(() async {
      wallet = await HDKeyPair.fromMnemonic(generateMnemonic());
    });

    test('Balance is not updated until tx is finalized', () async {
      const int addedBalance = 5 * lamportsPerSol;
      final TxSignature signature = await solanaClient.requestAirdrop(
        address: wallet.address,
        lamports: addedBalance,
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
        address: wallet.address,
        lamports: addedBalance,
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
