import 'package:bip39/bip39.dart';
import 'package:solana/solana.dart';
import 'package:solana/src/crypto/ed25519_hd_keypair.dart';
import 'package:solana/src/rpc_client/rpc_client.dart';
import 'package:solana/src/system_program/system_program.dart';
import 'package:test/test.dart';

import 'config.dart';

const int _transferredAmount = 0x1000;

void main() {
  group('SolanaClient testsuite', () {
    late final RPCClient rpcClient;
    late Ed25519HDKeyPair destination;
    late Ed25519HDKeyPair source;
    int currentBalance = 0;

    setUpAll(() async {
      rpcClient = RPCClient(
        rpcUrl: devnetRpcUrl,
        websocketUrl: devnetWebsocketUrl,
      );
      destination = await Ed25519HDKeyPair.fromMnemonic(
        generateMnemonic(),
      ); // generateMnemonic());
      source = await Ed25519HDKeyPair.fromMnemonic(
        generateMnemonic(),
        account: 1,
      );
    });

    test('Call requestAirdrop and add SOL to an account works', () async {
      const int addedBalance = 100 * lamportsPerSol;
      final String signature = await rpcClient.requestAirdrop(
        pubKey: source.address,
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
      final int balance = await rpcClient.getBalance(pubKey: source.address);
      // Update the global balance
      currentBalance += addedBalance;
      // Check that it matches
      expect(balance, currentBalance);
    });

    test('Read the recent blockhash', () async {
      final RecentBlockhash blockHash = await rpcClient.getRecentBlockhash();
      expect(blockHash, isNot(null));
      expect(blockHash.blockhash, isNot(null));
      expect(blockHash.blockhash, isNot(''));
      expect(blockHash.feeCalculator, isNot(null));
      expect(blockHash.feeCalculator.lamportsPerSignature, isNot(null));
    });

    test('Read the balance of an account', () async {
      final int balance = await rpcClient.getBalance(
        pubKey: source.address,
      );
      expect(balance, currentBalance);
    });

    test('Get all the account information of an account', () async {
      final Account? accountInfo = await rpcClient.getAccountInfo(
        pubKey: source.address,
      );
      expect(accountInfo, isNotNull);
      expect(accountInfo?.lamports, currentBalance);
      expect(accountInfo?.owner, SystemProgram.programId);
      expect(accountInfo?.executable, false);
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
        recentBlockhash: recentBlockhash.blockhash,
      );
      final TransactionStatus transferResult =
          await rpcClient.simulateTransaction(transaction: signedTx.encode());
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
        recentBlockhash: recentBlockhash.blockhash,
      );
      final String signature = await rpcClient.sendTransaction(
        transaction: signedTx.encode(),
      );
      expect(signature, signedTx.signatures.first.toBase58());
      await expectLater(
        rpcClient.waitForSignatureStatus(
          signature,
          Commitment.finalized,
        ),
        completes,
      );
      final int balance = await rpcClient.getBalance(
        pubKey: destination.address,
      );
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
        recentBlockhash: recentBlockhash.blockhash,
      );
      final String signature = await rpcClient.sendTransaction(
        transaction: signedTx.encode(),
      );
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

      txs.forEach((TransactionDetails? tx) => expect(tx, isNot(null)));
      expect(txs.length, greaterThan(0));
    });
  });

  group('Test commitment', () {
    late final RPCClient solanaClient;
    late Ed25519HDKeyPair wallet;

    setUpAll(() async {
      solanaClient = RPCClient(
        rpcUrl: devnetRpcUrl,
        websocketUrl: devnetWebsocketUrl,
      );
    });

    setUp(() async {
      wallet = await Ed25519HDKeyPair.fromMnemonic(generateMnemonic());
    });

    test('Balance is not updated until tx is finalized', () async {
      const int addedBalance = 5 * lamportsPerSol;
      final String signature = await solanaClient.requestAirdrop(
        pubKey: wallet.address,
        lamports: addedBalance,
        commitment: const CommitmentObject(commitment: Commitment.finalized),
      );

      await expectLater(
        solanaClient.waitForSignatureStatus(signature, Commitment.confirmed),
        completes,
      );

      var balance = await solanaClient.getBalance(pubKey: wallet.address);
      expect(balance, 0);

      await expectLater(
        solanaClient.waitForSignatureStatus(signature, Commitment.finalized),
        completes,
      );
      balance = await solanaClient.getBalance(pubKey: wallet.address);

      expect(balance, greaterThan(0));
    });

    test('Balance is updated if requested with confirmed commitment', () async {
      const int addedBalance = 5 * lamportsPerSol;
      final String signature = await solanaClient.requestAirdrop(
        pubKey: wallet.address,
        lamports: addedBalance,
        commitment: const CommitmentObject(commitment: Commitment.finalized),
      );

      await expectLater(
        solanaClient.waitForSignatureStatus(signature, Commitment.confirmed),
        completes,
      );
      final balance = await solanaClient.getBalance(
        pubKey: wallet.address,
        commitment: const CommitmentObject(commitment: Commitment.confirmed),
      );
      expect(balance, greaterThan(0));
    });

    test('Get token accounts by owner', () async {
      /*final accountKeyPair = await Ed25519HDKeyPair.random();
      final accountCreator = await Ed25519HDKeyPair.random();

      await airdrop(solanaClient, wallet, sol: 100);
      await airdrop(solanaClient, accountCreator, sol: 100);

      final token = await solanaClient.initializeMint(
        owner: wallet,
        decimals: 8,
      );

      final createdAccount = await token.createAssociatedAccount(
        owner: accountKeyPair.address,
        funder: accountCreator,
      );

      final accounts = await solanaClient.getTokenAccountsByOwner(
        pubKey: accountKeyPair.address,
        mintOrProgramId: const MintOrProgramId(
          programId: TokenProgram.programId,
        ),
        options: const GetAccountInfoOptions(
          encoding: Encoding.jsonParsed,
        ),
      );

      expect(accounts.length, equals(1));
      expect(accounts.first.pubkey, equals(createdAccount.pubkey));
      expect(accounts.first.account.data, isA<SplTokenAccountData>());

      final data = accounts.first.account.data as SplTokenAccountData;
      expect(data.parsed.info.mint, equals(token.mint));
      expect(data.parsed.info.owner, equals(createdAccount.account.owner));*/
    }, timeout: const Timeout(Duration(minutes: 4)));
  });
}
