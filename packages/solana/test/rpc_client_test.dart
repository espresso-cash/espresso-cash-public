import 'package:bip39/bip39.dart';
import 'package:solana/solana.dart';
import 'package:solana/src/crypto/ed25519_hd_keypair.dart';
import 'package:solana/src/rpc/dto/account_data/parsed_account_data.dart';
import 'package:solana/src/rpc/dto/account_data/parsed_spl_token_account_data.dart';
import 'package:solana/src/subscription_client/subscription_client.dart';
import 'package:solana/src/system_program/system_program.dart';
import 'package:test/test.dart';

import 'airdrop.dart';
import 'config.dart';

const int _transferredAmount = 0x1000;

void main() {
  group('SolanaClient testsuite', () {
    late final RpcClient rpcClient;
    late final SubscriptionClient subscriptionClient;
    late Ed25519HDKeyPair destination;
    late Ed25519HDKeyPair source;
    int currentBalance = 0;

    setUpAll(() async {
      rpcClient = RpcClient(devnetRpcUrl);
      subscriptionClient = await SubscriptionClient.connect(devnetWebsocketUrl);
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
        source.address,
        addedBalance,
      );
      expect(signature, isNot(null));
      await subscriptionClient.waitForSignatureStatus(
        signature,
        status: ConfirmationStatus.finalized,
      );
      final int balance = await rpcClient.getBalance(source.address);
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
        source.address,
      );
      expect(balance, currentBalance);
    });

    test('Get all the account information of an account', () async {
      final Account? accountInfo = await rpcClient.getAccountInfo(
        source.address,
        encoding: Encoding.jsonParsed,
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
          await rpcClient.simulateTransaction(
        signedTx.encode(),
      );
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
        signedTx.encode(),
      );
      expect(signature, signedTx.signatures.first.toBase58());
      await expectLater(
        subscriptionClient.waitForSignatureStatus(
          signature,
          status: ConfirmationStatus.finalized,
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
        recentBlockhash: recentBlockhash.blockhash,
      );
      final String signature = await rpcClient.sendTransaction(
        signedTx.encode(),
      );
      expect(signature, isNot(null));

      await expectLater(
        subscriptionClient.waitForSignatureStatus(
          signature,
          status: Commitment.finalized,
        ),
        completes,
      );
    });

    test('List recent transactions', () async {
      /*final txs = await rpcClient.getTransactionsList(source.address);
      expect(txs, isNot(null));

      txs.forEach((TransactionDetails? tx) => expect(tx, isNot(null)));
      expect(txs.length, greaterThan(0));*/
    }, skip: 'Will enable it soon');
  });

  group('Test commitment', () {
    late final RpcClient rpcClient;
    late final SubscriptionClient subscriptionClient;
    late Ed25519HDKeyPair wallet;

    setUpAll(() async {
      rpcClient = RpcClient(devnetRpcUrl);
      subscriptionClient = await SubscriptionClient.connect(devnetWebsocketUrl);
    });

    setUp(() async {
      wallet = await Ed25519HDKeyPair.fromMnemonic(generateMnemonic());
    });

    test('Balance is not updated until tx is finalized', () async {
      const int addedBalance = 5 * lamportsPerSol;
      final String signature = await rpcClient.requestAirdrop(
        wallet.address,
        addedBalance,
        commitment: Commitment.confirmed,
      );

      await subscriptionClient.waitForSignatureStatus(
        signature,
        status: Commitment.confirmed,
      );

      var balance = await rpcClient.getBalance(wallet.address);
      expect(balance, equals(0));

      await subscriptionClient.waitForSignatureStatus(
        signature,
        status: Commitment.finalized,
      );
      balance = await rpcClient.getBalance(wallet.address);

      expect(balance, greaterThan(0));
    });

    test('Balance is updated if requested with confirmed commitment', () async {
      const int addedBalance = 5 * lamportsPerSol;
      final String signature = await rpcClient.requestAirdrop(
        wallet.address,
        addedBalance,
        commitment: Commitment.finalized,
      );

      await subscriptionClient.waitForSignatureStatus(
        signature,
        status: Commitment.confirmed,
      );

      final balance = await rpcClient.getBalance(
        wallet.address,
        commitment: Commitment.confirmed,
      );
      expect(balance, greaterThan(0));
    });

    test('Get token accounts by owner', () async {
      final accountKeyPair = await Ed25519HDKeyPair.random();
      final accountCreator = await Ed25519HDKeyPair.random();

      await airdrop(rpcClient, subscriptionClient, wallet, sol: 100);
      await airdrop(rpcClient, subscriptionClient, accountCreator, sol: 100);

      final token = await rpcClient.initializeMint(
        owner: wallet,
        subscriptionClient: subscriptionClient,
        decimals: 8,
      );

      final createdAccount = await token.createAssociatedAccount(
        owner: accountKeyPair.address,
        funder: accountCreator,
      );
      expect(createdAccount, isNotNull);

      final accounts = await rpcClient.getTokenAccountsByOwner(
        accountKeyPair.address,
        const TokenAccountsFilter(
          programId: TokenProgram.programId,
        ),
        encoding: Encoding.jsonParsed,
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
    late final SubscriptionClient subscriptionClient;
    late final RpcClient rpcClient;

    setUpAll(() async {
      rpcClient = RpcClient(devnetRpcUrl);
      subscriptionClient = await SubscriptionClient.connect(devnetWebsocketUrl);
    });

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
        commitment: Commitment.finalized,
      );
      expect(slot, greaterThan(0));
    });

    test('call to getSupply() succeeds with default parameters', () async {
      final supply =
          await rpcClient.getSupply(commitment: Commitment.finalized);

      expect(supply.total, equals(supply.circulating + supply.nonCirculating));
      expect(supply.nonCirculatingAccounts.length, greaterThan(0));
    });

    test('call to getSupply() succeeds with circulating accounts list',
        () async {
      final supply = await rpcClient.getSupply(
        commitment: Commitment.finalized,
        excludeNonCirculatingAccountsList: false,
      );

      expect(supply.total, equals(supply.circulating + supply.nonCirculating));
      expect(supply.nonCirculatingAccounts.length, greaterThan(0));
    });

    test('call to getSupply() succeeds excluding circulating accounts list',
        () async {
      final supply = await rpcClient.getSupply(
        commitment: Commitment.confirmed,
        excludeNonCirculatingAccountsList: true,
      );

      expect(supply.total, equals(supply.circulating + supply.nonCirculating));
      expect(supply.nonCirculatingAccounts.length, equals(0));
    });

    test('call to getLeaderSchedule() succeeds with default parameters',
        () async {
      // FIXME: should not need the parameter (fix the generator)
      final leaderSchedule = await rpcClient.getLeaderSchedule(null);
      expect(leaderSchedule, isNotNull);
    });

    test('call to getLargerAccounts() succeeds with default parameters',
        () async {
      final largestAccounts = await rpcClient.getLargestAccounts();
      expect(largestAccounts.length, equals(20));
    });

    test('call to getLargerAccounts() succeeds with commitment', () async {
      final largestAccounts = await rpcClient.getLargestAccounts(
        commitment: Commitment.processed,
      );
      expect(largestAccounts.length, equals(20));
    });

    test('call to getLargerAccounts() succeeds with filter: circulating',
        () async {
      final largestAccounts = await rpcClient.getLargestAccounts(
        filter: CirculationStatus.circulating,
      );
      expect(largestAccounts.length, equals(20));
    });

    test('call to getLargerAccounts() succeeds with filter: non-circulating',
        () async {
      final largestAccounts = await rpcClient.getLargestAccounts(
        filter: CirculationStatus.nonCirculating,
      );
      expect(largestAccounts.length, equals(0));
    });

    test('call to getMultipleAccounts() succeeds with jsonParsed encoding',
        () async {
      final largestAccounts = await rpcClient.getLargestAccounts();

      final accounts = await rpcClient.getMultipleAccounts(
        largestAccounts.map((l) => l.address).toList(),
        encoding: Encoding.jsonParsed,
      );

      expect(accounts.length, equals(largestAccounts.length));
    });

    test('call to getMultipleAccounts() succeeds with base64 encoding',
        () async {
      final largestAccounts = await rpcClient.getLargestAccounts();

      final accounts = await rpcClient.getMultipleAccounts(
        largestAccounts.map((l) => l.address).toList(),
        encoding: Encoding.base64,
      );

      expect(accounts.length, equals(largestAccounts.length));
    });

    test('call to getMultipleAccounts() succeeds with base58 encoding',
        () async {
      final largestAccounts = await rpcClient.getLargestAccounts();

      final future = rpcClient.getMultipleAccounts(
        largestAccounts.map((l) => l.address).toList(),
        encoding: Encoding.base58,
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
      // TODO(IA): could check if it is a valid base58 string
      expect(genesisHash, isNotNull);
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
        commitment: Commitment.finalized,
      );
      expect(inflationGovernor, isNotNull);
    });

    test('call to getInflationRate() succeeds', () async {
      final inflationGovernor = await rpcClient.getInflationRate();
      expect(inflationGovernor, isNotNull);
    });

    test('call to getInflationReward() succeeds', () async {
      final largestAccounts = await rpcClient.getLargestAccounts();
      final inflationReward = await rpcClient.getInflationReward(
        largestAccounts.map((l) => l.address).toList(growable: false),
      );

      expect(inflationReward.length, greaterThan(0));
    });

    test('call to getClusterNodes() succeeds', () async {
      final clusterNodes = await rpcClient.getClusterNodes();
      expect(clusterNodes.length, equals(1));
    });

    test('call to getBlockTime() succeeds', () async {
      final blockTime = await rpcClient.getBlockTime(
        await rpcClient.getFirstAvailableBlock(),
      );

      expect(blockTime, greaterThan(0));
    });

    test('call to getEpochInfo() succeeds', () async {
      final epochInfo = await rpcClient.getEpochInfo();
      expect(epochInfo.absoluteSlot, greaterThan(0));
    });

    test('call to getEpochInfo() succeeds with commitment', () async {
      final epochInfo = await rpcClient.getEpochInfo(
        commitment: Commitment.finalized,
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
        recentBlockhash.blockhash,
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
        commitment: Commitment.finalized,
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
          await rpcClient.getMinimumBalanceForRentExemption(302);
      expect(maxRetransmitSlot, isA<int>());
    });

    test('call to getProgramAccounts() succeeds', () async {
      final programAccounts = await rpcClient.getProgramAccounts(
        [TokenProgram.programId],
      );

      expect(programAccounts.length, greaterThan(0));
    });

    test('call to getSlotLeader() succeeds', () async {
      final slotLeader = await rpcClient.getSlotLeader();
      expect(slotLeader, _validAddressMatcher);
    });

    test('call to getSlotLeaders() succeeds', () async {
      final slotLeaders = await rpcClient.getSlotLeaders(0, 4);

      expect(slotLeaders.length, lessThanOrEqualTo(4));
      expect(slotLeaders.every(isValidAddress), equals(true));
    });

    test('call to getStakeActivation() succeeds', () async {
      final largestAccounts = await rpcClient.getLargestAccounts();
      final accounts = await rpcClient.getMultipleAccounts(
        largestAccounts.map((l) => l.address).toList(growable: false),
        encoding: Encoding.jsonParsed,
      );
      final stakeAccountIndex =
          accounts.indexWhere((a) => a.data is StakeProgramAccountData);
      if (stakeAccountIndex == -1) {
        fail('cannot find a staking account');
      }
      final stakeActivation = await rpcClient.getStakeActivation(
        largestAccounts[stakeAccountIndex].address,
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
      expect(minimumLedgerSlot, greaterThanOrEqualTo(0));
    });

    test(
        'call to getAccountInfo() succeeds with base58 works for the right data size',
        () async {
      final accountAddress = await _createAccount(
        rpcClient,
        subscriptionClient,
        128,
      );

      final account = await rpcClient.getAccountInfo(
        accountAddress,
        encoding: Encoding.base58,
      );

      expect(account, isNotNull);
    });

    test('call to getAccountInfo() succeeds with base58 throws for large data',
        () async {
      final accountAddress = await _createAccount(
        rpcClient,
        subscriptionClient,
        130,
      );

      final future = rpcClient.getAccountInfo(
        accountAddress,
        encoding: Encoding.base58,
      );

      expect(future, throwsA(isA<JsonRpcException>()));
    });

    test('call to getAccountInfo() succeeds with base64 encoding', () async {
      final accountAddress = await _createAccount(
        rpcClient,
        subscriptionClient,
        230,
      );

      final account = await rpcClient.getAccountInfo(
        accountAddress,
        encoding: Encoding.base64,
      );

      expect(account, isNotNull);
    });
  });
}

Future<String> _createAccount(
  RpcClient rpcClient,
  SubscriptionClient subscriptionClient,
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

  await airdrop(rpcClient, subscriptionClient, source, sol: 10);

  final program = SystemProgram.createAccount(
    owner: source.address,
    programId: SystemProgram.programId,
    address: accountKeyPair.address,
    rent: await rpcClient.getMinimumBalanceForRentExemption(
      100,
      commitment: Commitment.finalized,
    ),
    space: size,
  );
  final recentBlockhash = await rpcClient.getRecentBlockhash(
    commitment: Commitment.finalized,
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
    signedTx.encode(),
    commitment: Commitment.finalized,
  );
  await subscriptionClient.waitForSignatureStatus(
    signature,
    status: ConfirmationStatus.finalized,
  );

  return accountKeyPair.address;
}

const Matcher _validAddressMatcher = _AddressMatcher();

class _AddressMatcher extends Matcher {
  const _AddressMatcher();

  @override
  Description describe(Description description) =>
      description.add('is valid address');

  @override
  bool matches(covariant String item, Map<dynamic, dynamic> matchState) =>
      isValidAddress(item);
}
