import 'package:solana/dto.dart';
import 'package:solana/solana.dart';
import 'package:test/test.dart';

import '../../config.dart';

void main() {
  final RpcClient rpcClient = RpcClient(devnetRpcUrl);
  final SubscriptionClient subscriptionClient =
      SubscriptionClient.connect(devnetWebsocketUrl);
  const int stakeAmount = 2 * lamportsPerSol;

  test('Create Account', () async {
    final rent = await rpcClient
        .getMinimumBalanceForRentExemption(StakeProgram.neededAccountSpace);
    final fromKey = await _createFundedKey(rpcClient, subscriptionClient);
    final account = await Ed25519HDKeyPair.random();
    final staker = await Ed25519HDKeyPair.random();
    final withdrawer = await Ed25519HDKeyPair.random();
    final instructions = StakeInstruction.createAndInitializeAccount(
      fundingAccount: fromKey.publicKey,
      newAccount: account.publicKey,
      authorized: Authorized(
        staker: staker.address,
        withdrawer: withdrawer.address,
      ),
      lamports: rent + stakeAmount,
    );

    final signature = await rpcClient.signAndSendTransaction(
      Message(instructions: instructions),
      [fromKey, account],
      commitment: Commitment.confirmed,
    );
    expect(
      subscriptionClient.waitForSignatureStatus(
        signature,
        status: ConfirmationStatus.confirmed,
      ),
      completes,
    );
  });

  test('Create Account: with seed', () async {
    final fromKey = await _createFundedKey(rpcClient, subscriptionClient);
    final staker = await Ed25519HDKeyPair.random();
    final withdrawer = await Ed25519HDKeyPair.random();
    final stakeKey = await Ed25519HDKeyPair.random();
    final lamports = await rpcClient
        .getMinimumBalanceForRentExemption(StakeProgram.neededAccountSpace);

    final signature = await rpcClient.requestAirdrop(
      fromKey.address,
      100 * lamportsPerSol,
      commitment: Commitment.confirmed,
    );
    await subscriptionClient.waitForSignatureStatus(
      signature,
      status: ConfirmationStatus.confirmed,
    );

    const seed = 'seed';
    final derivedPubKey = await Ed25519HDPublicKey.createWithSeed(
      fromPublicKey: stakeKey.publicKey,
      seed: seed,
      programId: Ed25519HDPublicKey.fromBase58(StakeProgram.programId),
    );
    const stakeAmount = 50 * lamportsPerSol;

    final instructions = StakeInstruction.createAndInitializeAccountWithSeed(
      fundingAccount: fromKey.publicKey,
      newAccount: derivedPubKey,
      authorized: Authorized(
        withdrawer: withdrawer.address,
        staker: staker.address,
      ),
      base: stakeKey.publicKey,
      seed: seed,
      lamports: lamports + stakeAmount,
    );

    expect(
      rpcClient.signAndSendTransaction(
        Message(instructions: instructions),
        [fromKey, stakeKey],
        commitment: Commitment.confirmed,
      ),
      completes,
    );
  });

  test('Authorize Staker', () async {
    final staker = await Ed25519HDKeyPair.random();
    final withdrawer = await Ed25519HDKeyPair.random();
    final account = await Ed25519HDKeyPair.random();
    final fromKey = await _newAccount(
      rpcClient,
      subscriptionClient,
      staker,
      withdrawer,
      account,
    );
    final newStaker = await Ed25519HDKeyPair.random();
    final instruction = StakeInstruction.authorize(
      stake: account.publicKey,
      authority: staker.publicKey,
      authorize: StakeAuthorize.staker(newStaker.publicKey),
    );

    expect(
      rpcClient.signAndSendTransaction(
        Message.only(instruction),
        [fromKey, staker],
        commitment: Commitment.confirmed,
      ),
      completes,
    );
  });

  test('Authorize Withdrawer', () async {
    final staker = await Ed25519HDKeyPair.random();
    final withdrawer = await Ed25519HDKeyPair.random();
    final account = await Ed25519HDKeyPair.random();
    final fromKey = await _newAccount(
      rpcClient,
      subscriptionClient,
      staker,
      withdrawer,
      account,
    );
    final newWithdrawer = await Ed25519HDKeyPair.random();
    final instruction = StakeInstruction.authorize(
      stake: account.publicKey,
      authority: withdrawer.publicKey,
      authorize: StakeAuthorize.withdrawer(newWithdrawer.publicKey),
    );

    expect(
      rpcClient.signAndSendTransaction(
        Message.only(instruction),
        [fromKey, withdrawer],
        commitment: Commitment.confirmed,
      ),
      completes,
    );
  });

  test(
    'Split',
    () async {
      final staker = await Ed25519HDKeyPair.random();
      final withdrawer = await Ed25519HDKeyPair.random();
      final account = await Ed25519HDKeyPair.random();
      final fromKey = await _newAccount(
        rpcClient,
        subscriptionClient,
        staker,
        withdrawer,
        account,
      );
      final newAccount = await Ed25519HDKeyPair.random();
      final lamports = await rpcClient
          .getMinimumBalanceForRentExemption(StakeProgram.neededAccountSpace);
      final instruction = SystemInstruction.createAccount(
        lamports: lamports,
        newAccount: newAccount.publicKey,
        fundingAccount: fromKey.publicKey,
        owner: StakeProgram.id,
        space: StakeProgram.neededAccountSpace,
      );
      final signature = await rpcClient.signAndSendTransaction(
        Message.only(instruction),
        [fromKey, newAccount],
        commitment: Commitment.confirmed,
      );
      await subscriptionClient.waitForSignatureStatus(
        signature,
        status: ConfirmationStatus.confirmed,
      );

      final splitInstruction = StakeInstruction.split(
        amount: lamportsPerSol,
        destinationStake: newAccount.publicKey,
        sourceStake: account.publicKey,
        authority: staker.publicKey,
      );

      expect(
        rpcClient.signAndSendTransaction(
          Message.only(splitInstruction),
          [fromKey, staker],
          commitment: Commitment.confirmed,
        ),
        completes,
      );
    },
    timeout: const Timeout(Duration(minutes: 2)),
  );

  test('Withdraw', () async {
    final staker = await Ed25519HDKeyPair.random();
    final withdrawer = await Ed25519HDKeyPair.random();
    final account = await Ed25519HDKeyPair.random();
    final fromKey = await _newAccount(
      rpcClient,
      subscriptionClient,
      staker,
      withdrawer,
      account,
    );
    final instruction = StakeInstruction.withdraw(
      lamports: 100,
      authority: withdrawer.publicKey,
      stake: account.publicKey,
      recipient: fromKey.publicKey,
    );

    expect(
      rpcClient.signAndSendTransaction(
        Message.only(instruction),
        [fromKey, withdrawer],
        commitment: Commitment.confirmed,
      ),
      completes,
    );
  });

  test(
    'Merge',
    () async {
      final staker = await Ed25519HDKeyPair.random();
      final withdrawer = await Ed25519HDKeyPair.random();
      final account1 = await Ed25519HDKeyPair.random();
      final account2 = await Ed25519HDKeyPair.random();
      final fromKey = await _newAccount(
        rpcClient,
        subscriptionClient,
        staker,
        withdrawer,
        account1,
      );
      await _newAccount(
        rpcClient,
        subscriptionClient,
        staker,
        withdrawer,
        account2,
      );
      final instruction = StakeInstruction.merge(
        authority: staker.publicKey,
        sourceStake: account2.publicKey,
        destinationStake: account1.publicKey,
      );

      expect(
        rpcClient.signAndSendTransaction(
          Message.only(instruction),
          [fromKey, staker],
          commitment: Commitment.confirmed,
        ),
        completes,
      );
    },
    timeout: const Timeout(Duration(minutes: 1)),
  );
}

Future<Ed25519HDKeyPair> _createFundedKey(
  RpcClient rpcClient,
  SubscriptionClient subscriptionClient,
) async {
  final keyPair = await Ed25519HDKeyPair.random();
  final signature = await rpcClient.requestAirdrop(
    keyPair.address,
    100 * lamportsPerSol,
  );
  await subscriptionClient.waitForSignatureStatus(
    signature,
    status: ConfirmationStatus.confirmed,
  );

  return keyPair;
}

Future<Ed25519HDKeyPair> _newAccount(
  RpcClient rpcClient,
  SubscriptionClient subscriptionClient,
  Ed25519HDKeyPair staker,
  Ed25519HDKeyPair withdrawer,
  Ed25519HDKeyPair stakeKey,
) async {
  final fromKey = await _createFundedKey(rpcClient, subscriptionClient);
  final rent = await rpcClient
      .getMinimumBalanceForRentExemption(StakeProgram.neededAccountSpace);
  final instructions = StakeInstruction.createAndInitializeAccount(
    fundingAccount: fromKey.publicKey,
    newAccount: stakeKey.publicKey,
    authorized: Authorized(
      staker: staker.address,
      withdrawer: withdrawer.address,
    ),
    lamports: rent + 50 * lamportsPerSol,
  );

  final signature = await rpcClient.signAndSendTransaction(
    Message(instructions: instructions),
    [fromKey, stakeKey],
    commitment: Commitment.confirmed,
  );
  await subscriptionClient.waitForSignatureStatus(
    signature,
    status: ConfirmationStatus.confirmed,
  );

  return fromKey;
}
