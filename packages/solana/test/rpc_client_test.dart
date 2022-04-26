import 'dart:async';

import 'package:bip39/bip39.dart';
import 'package:solana/dto.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';
import 'package:test/test.dart';

import 'airdrop.dart';
import 'config.dart';

const int _transferredAmount = 0x1000;

void main() {
  test('throws exception on timeout', () async {
    final client = RpcClient(devnetRpcUrl, timeout: Duration.zero);
    expect(client.getTransactionCount, throwsA(isA<TimeoutException>()));
  });

  group('RpcClient testsuite', () {
    late final RpcClient rpcClient;
    late final SubscriptionClient subscriptionClient;
    late Ed25519HDKeyPair destination;
    late Ed25519HDKeyPair source;
    int currentBalance = 0;

    setUpAll(() async {
      rpcClient = RpcClient(devnetRpcUrl);
      subscriptionClient = SubscriptionClient.connect(devnetWebsocketUrl);
      destination = await Ed25519HDKeyPair.fromMnemonic(
        generateMnemonic(),
      ); // generateMnemonic());
      source = await Ed25519HDKeyPair.fromMnemonic(
        generateMnemonic(),
        account: 1,
      );

      currentBalance =
          await _createTokenAccount(rpcClient, subscriptionClient, source);
    });

    test('Call requestAirdrop and add SOL to an account works', () async {
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
      final int balance = await rpcClient.getBalance(source.address);
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
      final instruction = SystemInstruction.transfer(
        fundingAccount: source.publicKey,
        recipientAccount: destination.publicKey,
        lamports: _transferredAmount,
      );
      final SignedTx signedTx = await source.signMessage(
        message: Message.only(instruction),
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
      final instruction = SystemInstruction.transfer(
        fundingAccount: source.publicKey,
        recipientAccount: destination.publicKey,
        lamports: _transferredAmount,
      );
      final SignedTx signedTx = await source.signMessage(
        message: Message.only(instruction),
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
      final instruction = SystemInstruction.transfer(
        fundingAccount: source.publicKey,
        recipientAccount: source.publicKey,
        lamports: _transferredAmount,
      );
      final SignedTx signedTx = await source.signMessage(
        message: Message.only(instruction),
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
      final txs = await rpcClient.getTransactionsList(source.publicKey);
      expect(txs, isNot(null));

      for (final tx in txs) {
        expect(tx, isNot(null));
      }
      expect(txs.length, greaterThan(0));
    });
  });

  group('Test commitment', () {
    late final RpcClient rpcClient;
    late final SubscriptionClient subscriptionClient;
    late Ed25519HDKeyPair wallet;

    setUpAll(() async {
      rpcClient = RpcClient(devnetRpcUrl);
      subscriptionClient = SubscriptionClient.connect(devnetWebsocketUrl);
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

    test(
      'Get token accounts by owner',
      () async {
        final accountKeyPair = await Ed25519HDKeyPair.random();
        final accountCreator = await Ed25519HDKeyPair.random();

        await airdrop(rpcClient, subscriptionClient, wallet, sol: 100);
        await airdrop(rpcClient, subscriptionClient, accountCreator, sol: 100);

        final solanaClient = createTestSolanaClient();

        final token = await solanaClient.initializeMint(
          mintAuthority: wallet,
          decimals: 8,
        );

        final tokenAccount = await solanaClient.createAssociatedTokenAccount(
          owner: accountKeyPair.publicKey,
          mint: token.address,
          funder: accountCreator,
        );

        final accounts = await rpcClient.getTokenAccountsByOwner(
          accountKeyPair.address,
          const TokenAccountsFilter.byProgramId(TokenProgram.programId),
          encoding: Encoding.jsonParsed,
        );

        expect(accounts.length, equals(1));
        expect(accounts.first.pubkey, tokenAccount.pubkey);
        expect(accounts.first.account.data, isA<ParsedAccountData>());

        final data = accounts.first.account.data as ParsedAccountData;
        final programData = data as ParsedSplTokenProgramAccountData;
        final parsed = programData.parsed as TokenAccountData;
        expect(parsed.info.mint, token.address.toBase58());
        expect(parsed, isNotNull);
      },
      timeout: const Timeout(Duration(minutes: 4)),
    );
  });

  group('Test informational methods', () {
    late final SubscriptionClient subscriptionClient;
    late final RpcClient rpcClient;
    late final Ed25519HDKeyPair sampleSigner;

    setUpAll(() async {
      rpcClient = RpcClient(devnetRpcUrl);
      subscriptionClient = SubscriptionClient.connect(devnetWebsocketUrl);
      sampleSigner = await Ed25519HDKeyPair.random();

      await airdrop(rpcClient, subscriptionClient, sampleSigner, sol: 10);
    });

    test('Call to getVersion() succeeds and parses the response correctly',
        () async {
      final version = await rpcClient.getVersion();

      expect(version.solanaCore, isNotNull);
      expect(version.solanaCore.codeUnitAt(0), equals(49));
      expect(version.solanaCore.codeUnitAt(1), equals(46));
    });

    test('Call to getSnapshotSlot() succeeds', () async {
      final snapshotSlot = await rpcClient.getSnapshotSlot();
      expect(snapshotSlot, greaterThan(0));
    });

    test('Call to getSlot() succeeds', () async {
      final slot = await rpcClient.getSlot(
        commitment: Commitment.finalized,
      );
      expect(slot, greaterThan(0));
    });

    test('Call to getSupply() succeeds with default parameters', () async {
      final supply =
          await rpcClient.getSupply(commitment: Commitment.finalized);

      expect(supply.total, equals(supply.circulating + supply.nonCirculating));
      expect(supply.nonCirculatingAccounts.length, greaterThan(0));
    });

    test('Call to getSupply() succeeds with circulating accounts list',
        () async {
      final supply = await rpcClient.getSupply(
        commitment: Commitment.finalized,
        excludeNonCirculatingAccountsList: false,
      );

      expect(supply.total, equals(supply.circulating + supply.nonCirculating));
      expect(supply.nonCirculatingAccounts.length, greaterThan(0));
    });

    test('Call to getSupply() succeeds excluding circulating accounts list',
        () async {
      final supply = await rpcClient.getSupply(
        commitment: Commitment.confirmed,
        excludeNonCirculatingAccountsList: true,
      );

      expect(supply.total, equals(supply.circulating + supply.nonCirculating));
      expect(supply.nonCirculatingAccounts.length, equals(0));
    });

    test('Call to getLeaderSchedule() succeeds with default parameters',
        () async {
      // FIXME: should not need the parameter (fix the generator)
      final leaderSchedule = await rpcClient.getLeaderSchedule(null);
      expect(leaderSchedule, isNotNull);
    });

    test('Call to getLargerAccounts() succeeds with default parameters',
        () async {
      final largestAccounts = await rpcClient.getLargestAccounts();
      expect(largestAccounts.length, equals(20));
    });

    test('Call to getLargerAccounts() succeeds with commitment', () async {
      final largestAccounts = await rpcClient.getLargestAccounts(
        commitment: Commitment.processed,
      );
      expect(largestAccounts.length, equals(20));
    });

    test('Call to getLargerAccounts() succeeds with filter: circulating',
        () async {
      final largestAccounts = await rpcClient.getLargestAccounts(
        filter: CirculationStatus.circulating,
      );
      expect(largestAccounts.length, equals(20));
    });

    test('Call to getLargerAccounts() succeeds with filter: non-circulating',
        () async {
      final largestAccounts = await rpcClient.getLargestAccounts(
        filter: CirculationStatus.nonCirculating,
      );
      expect(largestAccounts.length, equals(0));
    });

    test('Call to getMultipleAccounts() succeeds with jsonParsed encoding',
        () async {
      final largestAccounts = await rpcClient.getLargestAccounts();

      final accounts = await rpcClient.getMultipleAccounts(
        largestAccounts.map((l) => l.address).toList(),
        encoding: Encoding.jsonParsed,
      );

      expect(accounts.length, equals(largestAccounts.length));
    });

    test('Call to getMultipleAccounts() succeeds with base64 encoding',
        () async {
      final largestAccounts = await rpcClient.getLargestAccounts();

      final accounts = await rpcClient.getMultipleAccounts(
        largestAccounts.map((l) => l.address).toList(),
        encoding: Encoding.base64,
      );

      expect(accounts.length, equals(largestAccounts.length));
    });

    test('Call to getMultipleAccounts() succeeds with base58 encoding',
        () async {
      final largestAccounts = await rpcClient.getLargestAccounts();

      final future = rpcClient.getMultipleAccounts(
        largestAccounts.map((l) => l.address).toList(),
        encoding: Encoding.base58,
      );

      // It throws because some accounts are too large for base58
      expect(future, throwsA(isA<JsonRpcException>()));
    });

    test('Call to getBlockProduction() succeeds', () async {
      final blockProduction = await rpcClient.getBlockProduction();
      expect(blockProduction, isNotNull);
    });

    test('Call to getGenesisHash() succeeds', () async {
      final genesisHash = await rpcClient.getGenesisHash();
      // TODO(IA): could check if it is a valid base58 string
      expect(genesisHash, isNotNull);
    });

    test('Call to getHealth() succeeds', () async {
      final health = await rpcClient.getHealth();
      expect(health, equals('ok'));
    });

    test('Call to getInflationGovernor() succeeds', () async {
      final inflationGovernor = await rpcClient.getInflationGovernor();
      expect(inflationGovernor, isNotNull);
    });

    test('Call to getInflationGovernor() succeeds with commitment', () async {
      final inflationGovernor = await rpcClient.getInflationGovernor(
        commitment: Commitment.finalized,
      );
      expect(inflationGovernor, isNotNull);
    });

    test('Call to getInflationRate() succeeds', () async {
      final inflationGovernor = await rpcClient.getInflationRate();
      expect(inflationGovernor, isNotNull);
    });

    test(
      'Call to getInflationReward() succeeds',
      () async {
        final inflationReward = await rpcClient.getInflationReward(
          [sampleSigner.address],
        );

        expect(inflationReward.length, greaterThan(0));
      },
      skip: 'Needs too many slots to correctly work',
    );

    test('Call to getClusterNodes() succeeds', () async {
      final clusterNodes = await rpcClient.getClusterNodes();
      expect(clusterNodes.length, equals(1));
    });

    test('Call to getBlockTime() succeeds', () async {
      final blockTime = await rpcClient.getBlockTime(
        await rpcClient.getFirstAvailableBlock(),
      );

      expect(blockTime, greaterThan(0));
    });

    test('Call to getEpochInfo() succeeds', () async {
      final epochInfo = await rpcClient.getEpochInfo();
      expect(epochInfo.absoluteSlot, greaterThan(0));
    });

    test('Call to getEpochInfo() succeeds with commitment', () async {
      final epochInfo = await rpcClient.getEpochInfo(
        commitment: Commitment.finalized,
      );

      expect(epochInfo.absoluteSlot, greaterThan(0));
    });

    test('Call to getEpochSchedule() succeeds', () async {
      final epochInfo = await rpcClient.getEpochSchedule();
      expect(epochInfo.slotsPerEpoch, greaterThan(0));
    });

    test('Call to getFeeCalculatorForBlockhash() succeeds', () async {
      final recentBlockhash = await rpcClient.getRecentBlockhash();
      final feeCalculator = await rpcClient.getFeeCalculatorForBlockhash(
        recentBlockhash.blockhash,
      );

      expect(feeCalculator, isNotNull);
      expect(feeCalculator?.feeCalculator.lamportsPerSignature, greaterThan(0));
    });

    test('Call to getFees() succeeds', () async {
      final fees = await rpcClient.getFees();
      expect(fees.lastValidBlockHeight, greaterThan(0));
    });

    test('Call to getFees() succeeds with commitment', () async {
      final fees = await rpcClient.getFees(
        commitment: Commitment.finalized,
      );

      expect(fees.lastValidBlockHeight, greaterThan(0));
    });

    test('Call to getFirstAvailableBlock() succeeds', () async {
      final block = await rpcClient.getFirstAvailableBlock();
      expect(block, greaterThan(0));
    });

    test('Call to getIdentity() succeeds', () async {
      final identity = await rpcClient.getIdentity();
      expect(identity, isNotNull);
    });

    test('Call to getMaxRetransmitSlot() succeeds', () async {
      final maxRetransmitSlot = await rpcClient.getMaxRetransmitSlot();
      expect(maxRetransmitSlot, isA<int>());
    });

    test('Call to getMaxShredInsertSlot() succeeds', () async {
      final maxRetransmitSlot = await rpcClient.getMaxShredInsertSlot();
      expect(maxRetransmitSlot, isA<int>());
    });

    test('Call to getMinimumBalanceForRentExemption() succeeds', () async {
      final maxRetransmitSlot =
          await rpcClient.getMinimumBalanceForRentExemption(302);
      expect(maxRetransmitSlot, isA<int>());
    });

    test('Call to getProgramAccounts() with jsonParsed encoding succeeds',
        () async {
      final programAccounts = await rpcClient.getProgramAccounts(
        TokenProgram.programId,
        encoding: Encoding.jsonParsed,
      );

      expect(programAccounts.length, greaterThan(0));
    });

    test(
      'Call to getProgramAccounts() with base58 encoding succeeds',
      () async {
        final programAccounts = await rpcClient.getProgramAccounts(
          TokenProgram.programId,
          encoding: Encoding.base58,
        );

        expect(programAccounts.length, greaterThan(0));
      },
      skip:
          'We cannot guess the size of the account, so we cannot test this for now',
    );

    test('Call to getProgramAccounts() with base64 encoding succeeds',
        () async {
      final programAccounts = await rpcClient.getProgramAccounts(
        TokenProgram.programId,
        encoding: Encoding.base64,
      );

      expect(programAccounts.length, greaterThan(0));
    });

    test('Call to getProgramAccounts() with memcmp filter succeeds', () async {
      final programAccounts = await rpcClient.getProgramAccounts(
        TokenProgram.programId,
        encoding: Encoding.jsonParsed,
        filters: [ProgramDataFilter.memcmp(offset: 0, bytes: 'FAIL'.codeUnits)],
      );

      expect(programAccounts.length, equals(0));
    });

    test('Call to getProgramAccounts() with dataSize filter succeeds',
        () async {
      final programAccounts = await rpcClient.getProgramAccounts(
        TokenProgram.programId,
        encoding: Encoding.jsonParsed,
        filters: const [ProgramDataFilter.dataSize(10)],
      );

      expect(programAccounts.length, equals(0));
    });

    test('Call to getSlotLeader() succeeds', () async {
      final slotLeader = await rpcClient.getSlotLeader();
      expect(slotLeader, _validAddressMatcher);
    });

    test(
      'Call to getSlotLeaders() succeeds',
      () async {
        final slotLeaders = await rpcClient.getSlotLeaders(0, 4);

        expect(slotLeaders.length, lessThanOrEqualTo(4));
        expect(slotLeaders.every(isValidAddress), equals(true));
      },
      skip: 'Leader schedule for epoch 0 is unavailable',
    );

    test('Call to getStakeActivation() succeeds', () async {
      final largestAccounts = await rpcClient.getLargestAccounts();
      final accounts = await rpcClient.getMultipleAccounts(
        largestAccounts.map((l) => l.address).toList(growable: false),
        encoding: Encoding.jsonParsed,
      );
      final stakeAccountIndex =
          accounts.indexWhere((a) => a?.data is ParsedStakeProgramAccountData);
      if (stakeAccountIndex == -1) {
        fail('cannot find a staking account');
      }
      final stakeActivation = await rpcClient.getStakeActivation(
        largestAccounts[stakeAccountIndex].address,
      );

      expect(stakeActivation.state, equals(StakeActivationState.active));
    });

    test('Call to getVoteAccounts() succeeds', () async {
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

    test('Call to minimumLedgerSlot() succeeds', () async {
      final minimumLedgerSlot = await rpcClient.minimumLedgerSlot();
      expect(minimumLedgerSlot, greaterThanOrEqualTo(0));
    });

    test(
        'Call to getAccountInfo() succeeds with base58 works for the right data size',
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

    test('Call to getAccountInfo() succeeds with base58 throws for large data',
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

    test('Call to getAccountInfo() succeeds with base64 encoding', () async {
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

Future<int> _createTokenAccount(
  RpcClient rpcClient,
  SubscriptionClient subscriptionClient,
  Ed25519HDKeyPair source,
) async {
  final accountKeyPair = await Ed25519HDKeyPair.fromMnemonic(
    generateMnemonic(),
    account: 0,
  );
  await airdrop(rpcClient, subscriptionClient, source, sol: 10);

  final token = await _createToken(
    decimals: 2,
    supply: 100000000000000,
    transferSomeToAddress: source.publicKey,
    transferSomeToAmount: 1000,
  );
  final rent = await rpcClient.getMinimumBalanceForRentExemption(
    TokenProgram.neededAccountSpace,
    commitment: Commitment.finalized,
  );

  final instructions = TokenInstruction.createAndInitializeAccount(
    mint: token.address,
    owner: source.publicKey,
    address: accountKeyPair.publicKey,
    rent: rent,
    space: TokenProgram.neededAccountSpace,
  );

  final recentBlockhash = await rpcClient.getRecentBlockhash(
    commitment: Commitment.finalized,
  );

  final signedTx = await signTransaction(
    recentBlockhash,
    Message(instructions: instructions),
    [source, accountKeyPair],
  );
  final signature = await rpcClient.sendTransaction(
    signedTx.encode(),
    commitment: Commitment.finalized,
  );
  await subscriptionClient.waitForSignatureStatus(
    signature,
    status: ConfirmationStatus.finalized,
  );

  final fee = recentBlockhash.feeCalculator.lamportsPerSignature;

  return 10 * lamportsPerSol - rent - 2 * fee;
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

  final instruction = SystemInstruction.createAccount(
    fundingAccount: source.publicKey,
    owner: SystemProgram.id,
    newAccount: accountKeyPair.publicKey,
    lamports: await rpcClient.getMinimumBalanceForRentExemption(
      size,
      commitment: Commitment.finalized,
    ),
    space: size,
  );
  final recentBlockhash = await rpcClient.getRecentBlockhash(
    commitment: Commitment.finalized,
  );

  final signedTx = await signTransaction(
    recentBlockhash,
    Message.only(instruction),
    [source, accountKeyPair],
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

Future<Mint> _createToken({
  required int decimals,
  required int supply,
  required Ed25519HDPublicKey transferSomeToAddress,
  required int transferSomeToAmount,
}) async {
  // This is the authority that will create the token and be able to emit
  // currency.
  final tokenMintAuthority = await Ed25519HDKeyPair.random();
  final client = createTestSolanaClient();

  // Put some tokens in the authority wallet.
  await client.requestAirdrop(
    address: tokenMintAuthority.publicKey,
    lamports: 5 * lamportsPerSol,
  );

  // Now we have SOL to create the token.
  final splToken = await client.initializeMint(
    mintAuthority: tokenMintAuthority,
    decimals: decimals,
  );

  // Now lets create an account to store the supply. All SPL token transfer must
  // be done to an associated token account which belongs to the specific token.
  //
  // The mint authority will also, own the total supply of the token.
  final supplyAccount = await findAssociatedTokenAddress(
    owner: tokenMintAuthority.publicKey,
    mint: splToken.address,
  );
  await client.createAssociatedTokenAccount(
    mint: splToken.address,
    funder: tokenMintAuthority,
  );

  // Now we have a spl token, let's add the supply to it.
  await client.mintTo(
    authority: tokenMintAuthority,
    destination: supplyAccount,
    amount: supply,
    mint: splToken.address,
  );

  // We must check if the recipient has an associated token account, if not we
  // have to create it.
  await client.getAssociatedTokenAccount(
        mint: splToken.address,
        owner: transferSomeToAddress,
      ) ??
      await client.createAssociatedTokenAccount(
        mint: splToken.address,
        funder: tokenMintAuthority,
        owner: transferSomeToAddress,
      );

  // And finally transfer them from the supply account to the destination
  // account, this is similar to what a faucet does.
  await client.transferSplToken(
    owner: tokenMintAuthority,
    destination: transferSomeToAddress,
    amount: transferSomeToAmount,
    mint: splToken.address,
  );

  return client.getMint(address: splToken.address);
}
