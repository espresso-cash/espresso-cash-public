import 'package:bip39/bip39.dart';
import 'package:solana/solana.dart';
import 'package:solana/src/crypto/ed25519_hd_keypair.dart';
import 'package:solana/src/dto/parsed_account_data.dart';
import 'package:solana/src/dto/parsed_spl_token_account_data.dart';
import 'package:solana/src/rpc_client/rpc_client.dart';
import 'package:solana/src/system_program/system_program.dart';
import 'package:test/test.dart';

import 'airdrop.dart';
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

    test('call requestAirdrop and add SOL to an account works', () async {
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
        options: const GetAccountInfoOptions(
          encoding: Encoding.jsonParsed,
        ),
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
        commitment: const CommitmentConfig(commitment: Commitment.finalized),
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
        commitment: const CommitmentConfig(commitment: Commitment.finalized),
      );

      await expectLater(
        solanaClient.waitForSignatureStatus(signature, Commitment.confirmed),
        completes,
      );
      final balance = await solanaClient.getBalance(
        pubKey: wallet.address,
        commitment: const CommitmentConfig(commitment: Commitment.confirmed),
      );
      expect(balance, greaterThan(0));
    });

    test('Get token accounts by owner', () async {
      final accountKeyPair = await Ed25519HDKeyPair.random();
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
        filter: const TokenAccountsFilter(
          programId: TokenProgram.programId,
        ),
        options: const GetAccountInfoOptions(
          encoding: Encoding.jsonParsed,
        ),
      );

      expect(accounts.length, equals(1));
      expect(accounts.first.pubkey, equals(createdAccount.pubkey));
      expect(accounts.first.account.data, isA<ParsedAccountData>());

      final data = accounts.first.account.data as ParsedAccountData;
      final programData = data as SplTokenProgramAccountData;
      final parsed = programData.parsed as SplTokenAccountData;
      expect(parsed.info.mint, equals(token.mint));
      expect(parsed.info.owner, equals(createdAccount.account.owner));
    }, timeout: const Timeout(Duration(minutes: 4)));
  });

  group('Test informational methods', () {
    final rpcClient = RPCClient(
      rpcUrl: devnetRpcUrl,
      websocketUrl: devnetWebsocketUrl,
    );

    test('call to getVersion() succeeds and parses the response correctly',
        () async {
      final version = await rpcClient.getVersion();
      expect(version.solanaCore, isNotNull);
      expect(version.solanaCore.codeUnitAt(0), equals(49));
      expect(version.solanaCore.codeUnitAt(1), equals(46));
    });

    test('call to getSnapshotSlot() succeeds', () async {
      final snapshotSlot = await rpcClient.getSnapshotSlot();
      expect(snapshotSlot, greaterThan(0));
    });

    test('call to getSlot() succeeds', () async {
      final slot = await rpcClient.getSlot(
        commitment: const CommitmentConfig(commitment: Commitment.finalized),
      );
      expect(slot, greaterThan(0));
    });

    test('call to getSupply() succeeds with default parameters', () async {
      final supply = await rpcClient.getSupply();

      expect(supply.total, equals(supply.circulating + supply.nonCirculating));
      expect(supply.nonCirculatingAccounts.length, greaterThan(0));
    });

    test('call to getSupply() succeeds with circulating accounts list',
        () async {
      final supply = await rpcClient.getSupply(
        options: const GetSupplyOptions(
          commitment: Commitment.finalized,
          excludeNonCirculatingAccountsList: false,
        ),
      );

      expect(supply.total, equals(supply.circulating + supply.nonCirculating));
      expect(supply.nonCirculatingAccounts.length, greaterThan(0));
    });

    test('call to getSupply() succeeds excluding circulating accounts list',
        () async {
      final supply = await rpcClient.getSupply(
        options: const GetSupplyOptions(
          commitment: Commitment.confirmed,
          excludeNonCirculatingAccountsList: true,
        ),
      );

      expect(supply.total, equals(supply.circulating + supply.nonCirculating));
      expect(supply.nonCirculatingAccounts.length, equals(0));
    }, skip: 'seems not to honor the flag');

    test('call to getLeaderSchedule() succeeds with default parameters',
        () async {
      final leaderSchedule = await rpcClient.getLeaderSchedule();
      expect(leaderSchedule, isNotNull);
    });

    test('call to getLargerAccounts() succeeds with default parameters',
        () async {
      final largestAccounts = await rpcClient.getLargestAccounts();
      expect(largestAccounts.length, equals(20));
    });

    test('call to getLargerAccounts() succeeds with commitment', () async {
      final largestAccounts = await rpcClient.getLargestAccounts(
        options: const GetLargestAccountsOptions(
          commitment: Commitment.processed,
        ),
      );
      expect(largestAccounts.length, equals(20));
    });

    test('call to getLargerAccounts() succeeds with filter: circulating',
        () async {
      final largestAccounts = await rpcClient.getLargestAccounts(
        options: const GetLargestAccountsOptions(
          filter: CirculationStatus.circulating,
        ),
      );
      expect(largestAccounts.length, equals(20));
    });

    test('call to getLargerAccounts() succeeds with filter: non-circulating',
        () async {
      final largestAccounts = await rpcClient.getLargestAccounts(
        options: const GetLargestAccountsOptions(
          filter: CirculationStatus.nonCirculating,
        ),
      );
      expect(largestAccounts.length, equals(0));
    });

    test('call to getMultipleAccounts() succeeds with jsonParsed encoding',
        () async {
      final largestAccounts = await rpcClient.getLargestAccounts();

      final accounts = await rpcClient.getMultipleAccounts(
        pubKeys: largestAccounts.map((l) => l.address).toList(),
        options: const GetAccountInfoOptions(
          encoding: Encoding.jsonParsed,
        ),
      );

      expect(accounts.length, equals(largestAccounts.length));
    });

    test('call to getMultipleAccounts() succeeds with base64 encoding',
        () async {
      final largestAccounts = await rpcClient.getLargestAccounts();

      final accounts = await rpcClient.getMultipleAccounts(
        pubKeys: largestAccounts.map((l) => l.address).toList(),
        options: const GetAccountInfoOptions(
          encoding: Encoding.base64,
        ),
      );

      expect(accounts.length, equals(largestAccounts.length));
    });

    test('call to getMultipleAccounts() succeeds with base58 encoding',
        () async {
      final largestAccounts = await rpcClient.getLargestAccounts();

      final future = rpcClient.getMultipleAccounts(
        pubKeys: largestAccounts.map((l) => l.address).toList(),
        options: const GetAccountInfoOptions(
          encoding: Encoding.base58,
        ),
      );

      // It throws because some accounts are too large for base58
      expect(future, throwsA(isA<JsonRpcException>()));
    });

    test('call to getBlockProduction() succeeds', () async {
      final blockProduction = await rpcClient.getBlockProduction();
      expect(blockProduction, isNotNull);
    });

    test('call to getGenesisHash() succeeds', () async {
      final genesisHash = await rpcClient.getGenesisHash();
      expect(genesisHash, isValidAddress);
    });

    test('call to getHealth() succeeds', () async {
      final health = await rpcClient.getHealth();
      expect(health, equals('ok'));
    });

    test('call to getInflationGovernor() succeeds', () async {
      final inflationGovernor = await rpcClient.getInflationGovernor();
      expect(inflationGovernor, isNotNull);
    });

    test('call to getInflationGovernor() succeeds with commitment', () async {
      final inflationGovernor = await rpcClient.getInflationGovernor(
        commitment: const CommitmentConfig(commitment: Commitment.finalized),
      );
      expect(inflationGovernor, isNotNull);
    });

    test('call to getInflationRate() succeeds with commitment', () async {
      final inflationGovernor = await rpcClient.getInflationRate();
      expect(inflationGovernor, isNotNull);
    });

    test('call to getInflationReward() succeeds with commitment', () async {
      final largestAccounts = await rpcClient.getLargestAccounts();
      final inflationReward = await rpcClient.getInflationReward(
        addresses:
            largestAccounts.map((l) => l.address).toList(growable: false),
      );

      expect(inflationReward.length, greaterThan(0));
    }, skip: 'throws an exception about the block not being available');

    test('call to getClusterNodes() succeeds', () async {
      final clusterNodes = await rpcClient.getClusterNodes();
      expect(clusterNodes.length, equals(1));
    });

    test('call to getBlocks() succeeds', () async {
      final blocks = await rpcClient.getBlocks(
        startSlot: 0,
      );

      expect(blocks.length, greaterThan(0));
    });

    test('call to getBlocks() succeeds with commitment and end slot', () async {
      final blocks = await rpcClient.getBlocks(
        startSlot: 0,
        endSlot: 500000,
        commitment: const CommitmentConfig(
          commitment: Commitment.finalized,
        ),
      );

      expect(blocks.length, greaterThan(0));
    });

    test('call to getBlocksWithLimit() succeeds', () async {
      final blocks = await rpcClient.getBlocksWithLimit(
        startSlot: 0,
        limit: 100,
      );

      expect(blocks.length, equals(100));
    });

    test('call to getBlockTime() succeeds', () async {
      final blockTime = await rpcClient.getBlockTime(
        block: await rpcClient.getFirstAvailableBlock(),
      );

      expect(blockTime, greaterThan(0));
    });

    test('call to getEpochInfo() succeeds', () async {
      final epochInfo = await rpcClient.getEpochInfo();
      expect(epochInfo.absoluteSlot, greaterThan(0));
    });

    test('call to getEpochInfo() succeeds with commitment', () async {
      final epochInfo = await rpcClient.getEpochInfo(
        commitment: const CommitmentConfig(
          commitment: Commitment.finalized,
        ),
      );

      expect(epochInfo.absoluteSlot, greaterThan(0));
    });

    test('call to getEpochSchedule() succeeds', () async {
      final epochInfo = await rpcClient.getEpochSchedule();
      expect(epochInfo.slotsPerEpoch, greaterThan(0));
    });

    test('call to getFeeCalculatorForBlockhash() succeeds', () async {
      final recentBlockhash = await rpcClient.getRecentBlockhash();
      final feeCalculator = await rpcClient.getFeeCalculatorForBlockhash(
        blockhash: recentBlockhash.blockhash,
      );

      expect(feeCalculator, isNotNull);
      expect(feeCalculator?.feeCalculator.lamportsPerSignature, greaterThan(0));
    });

    test('call to getFees() succeeds', () async {
      final fees = await rpcClient.getFees();
      expect(fees.lastValidBlockHeight, greaterThan(0));
    });

    test('call to getFees() succeeds with commitment', () async {
      final fees = await rpcClient.getFees(
        commitment: const CommitmentConfig(
          commitment: Commitment.finalized,
        ),
      );

      expect(fees.lastValidBlockHeight, greaterThan(0));
    });

    test('call to getFirstAvailableBlock() succeeds', () async {
      final block = await rpcClient.getFirstAvailableBlock();
      expect(block, greaterThan(0));
    });

    test('call to getIdentity() succeeds', () async {
      final identity = await rpcClient.getIdentity();
      expect(identity, isNotNull);
    });

    test('call to getMaxRetransmitSlot() succeeds', () async {
      final maxRetransmitSlot = await rpcClient.getMaxRetransmitSlot();
      expect(maxRetransmitSlot, isA<int>());
    });

    test('call to getMaxShredInsertSlot() succeeds', () async {
      final maxRetransmitSlot = await rpcClient.getMaxShredInsertSlot();
      expect(maxRetransmitSlot, isA<int>());
    });

    test('call to getMinimumBalanceForRentExemption() succeeds', () async {
      final maxRetransmitSlot =
          await rpcClient.getMinimumBalanceForRentExemption(
        accountDataLength: 302,
      );

      expect(maxRetransmitSlot, isA<int>());
    });

    test('call to getProgramAccounts() succeeds', () async {
      final programAccounts = await rpcClient.getProgramAccounts(
        pubKey: TokenProgram.programId,
      );

      expect(programAccounts.length, greaterThan(0));
    }, skip: 'base64.decode fails to decode the account data');

    test('call to getSignaturesForAddress() succeeds', () async {
      final largestAccounts = await rpcClient.getLargestAccounts();
      for (final largeAccount in largestAccounts) {
        final signatures = await rpcClient.getSignaturesForAddress(
          pubKey: largeAccount.address,
        );

        expect(signatures, isNotNull);
        if (signatures.isNotEmpty) {
          expect(signatures[0].err, isNull);
          expect(signatures[0].slot, greaterThan(0));
        }
      }
    });

    test('call to getSignaturesForAddress() succeeds with limit', () async {
      final largestAccounts = await rpcClient.getLargestAccounts();
      for (final largeAccount in largestAccounts) {
        final signatures = await rpcClient.getSignaturesForAddress(
          pubKey: largeAccount.address,
          options: const GetSignaturesForAddressOptions(
            limit: 5,
          ),
        );

        expect(signatures, isNotNull);
        if (signatures.isNotEmpty) {
          expect(signatures.length, lessThanOrEqualTo(5));
          expect(signatures[0].err, isNull);
          expect(signatures[0].slot, greaterThan(0));
        }
      }
    });

    test('call to getSlotLeader() succeeds', () async {
      final slotLeader = await rpcClient.getSlotLeader();
      expect(slotLeader, isValidAddress);
    });

    test('call to getSlotLeaders() succeeds', () async {
      final slotLeaders = await rpcClient.getSlotLeaders(
        startSlot: 0,
        limit: 4,
      );

      expect(slotLeaders.length, lessThanOrEqualTo(4));
      expect(slotLeaders.every(isValidAddress), equals(true));
    });

    test('call to getStakeActivation() succeeds', () async {
      final largestAccounts = await rpcClient.getLargestAccounts();
      final accounts = await rpcClient.getMultipleAccounts(
        pubKeys: largestAccounts.map((l) => l.address).toList(growable: false),
        options: const GetAccountInfoOptions(
          encoding: Encoding.jsonParsed,
        ),
      );
      final stakeAccountIndex =
          accounts.indexWhere((a) => a.data is StakeProgramAccountData);
      if (stakeAccountIndex == -1) {
        fail('cannot find a staking account');
      }
      final stakeActivation = await rpcClient.getStakeActivation(
        pubKey: largestAccounts[stakeAccountIndex].address,
      );

      expect(stakeActivation.state, equals(StakeActivationState.active));
    });

    test('call to getVoteAccounts() succeeds', () async {
      final voteAccounts = await rpcClient.getVoteAccounts();

      expect(
        voteAccounts.delinquent.every((va) => isValidAddress(va.votePubkey)),
        equals(true),
      );
      expect(
        voteAccounts.current.every((va) => isValidAddress(va.votePubkey)),
        equals(true),
      );
    });

    test('call to minimumLedgerSlot() succeeds', () async {
      final minimumLedgerSlot = await rpcClient.minimumLedgerSlot();
      expect(minimumLedgerSlot, greaterThan(0));
    });

    test(
        'call to getAccountInfo() succeeds with base58 works for the right data size',
        () async {
      final accountAddress = await _createAccount(rpcClient, 128);

      final account = await rpcClient.getAccountInfo(
        pubKey: accountAddress,
        options: const GetAccountInfoOptions(
          encoding: Encoding.base58,
        ),
      );

      expect(account, isNotNull);
    });

    test('call to getAccountInfo() succeeds with base58 throws for large data',
        () async {
      final accountAddress = await _createAccount(rpcClient, 130);

      final future = rpcClient.getAccountInfo(
        pubKey: accountAddress,
        options: const GetAccountInfoOptions(
          encoding: Encoding.base58,
        ),
      );

      expect(future, throwsA(isA<JsonRpcException>()));
    });

    test('call to getAccountInfo() succeeds with base64 encoding', () async {
      final accountAddress = await _createAccount(rpcClient, 230);

      final account = await rpcClient.getAccountInfo(
        pubKey: accountAddress,
        options: const GetAccountInfoOptions(
          encoding: Encoding.base64,
        ),
      );

      expect(account, isNotNull);
    });
  });
}

Future<String> _createAccount(
  RPCClient rpcClient,
  int size,
) async {
  final source = await Ed25519HDKeyPair.fromMnemonic(
    generateMnemonic(),
    account: 0,
  );

  final accountKeyPair = await Ed25519HDKeyPair.fromMnemonic(
    generateMnemonic(),
    account: 0,
  );

  await airdrop(rpcClient, source, sol: 10);

  final program = SystemProgram.createAccount(
    owner: source.address,
    programId: SystemProgram.programId,
    address: accountKeyPair.address,
    rent: await rpcClient.getMinimumBalanceForRentExemption(
      accountDataLength: 100,
      commitment: const CommitmentConfig(
        commitment: Commitment.finalized,
      ),
    ),
    space: size,
  );
  final recentBlockhash = await rpcClient.getRecentBlockhash(
    commitment: const CommitmentConfig(commitment: Commitment.finalized),
  );

  final signedTx = await signTransaction(
    recentBlockhash,
    program,
    [
      source,
      accountKeyPair,
    ],
  );
  final signature = await rpcClient.sendTransaction(
    transaction: signedTx.encode(),
    options: const SendTransactionOptions(
      commitment: Commitment.finalized,
    ),
  );
  await rpcClient.waitForSignatureStatus(
    signature,
    ConfirmationStatus.finalized,
  );

  return accountKeyPair.address;
}
