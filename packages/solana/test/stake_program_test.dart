import 'package:solana/dto.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';
import 'package:test/test.dart';

import 'config.dart';

void main() {
  final RpcClient rpcClient = RpcClient(devnetRpcUrl);
  final SubscriptionClient subscriptionClient =
      SubscriptionClient.connect(devnetWebsocketUrl);
  final int stakeAmount = lamportsPerSol;

  test('Create Account', () async {
    final rent = await rpcClient
        .getMinimumBalanceForRentExemption(StakeProgram.neededAccountSpace);
    final fromKey = await _createFundedKey(rpcClient, subscriptionClient);
    final account = await Ed25519HDKeyPair.random();
    final staker = await Ed25519HDKeyPair.random();
    final withdrawer = await Ed25519HDKeyPair.random();
    final program = StakeProgram.createAccount(
      fromPubKey: fromKey.address,
      stakePubKey: account.address,
      authorized: Authorized(
        staker: staker.address,
        withdrawer: withdrawer.address,
      ),
      lamports: rent + stakeAmount,
    );

    final signature = await rpcClient.signAndSendTransaction(
      program,
      [fromKey, account],
    );
    expect(
      subscriptionClient.waitForSignatureStatus(
        signature,
        status: ConfirmationStatus.finalized,
      ),
      completes,
    );
  });

  test('Create Account: with seed', () async {
    Message program;
    String signature;

    final fromKey = await _createFundedKey(rpcClient, subscriptionClient);
    final staker = await Ed25519HDKeyPair.random();
    final withdrawer = await Ed25519HDKeyPair.random();
    final stakeKey = await Ed25519HDKeyPair.random();
    final lamports = await rpcClient
        .getMinimumBalanceForRentExemption(StakeProgram.neededAccountSpace);

    signature = await rpcClient.requestAirdrop(
      fromKey.address,
      100 * lamportsPerSol,
    );
    await subscriptionClient.waitForSignatureStatus(
      signature,
      status: ConfirmationStatus.finalized,
    );

    final seed = 'seed';
    final derivedPubKey = await Ed25519HDPublicKey.createWithSeed(
      fromPublicKey: await stakeKey.extractPublicKey(),
      seed: seed,
      programId: Ed25519HDPublicKey.fromBase58(StakeProgram.programId),
    );
    final stakeAmount = 50 * lamportsPerSol;

    program = StakeProgram.createAccountWithSeed(
      fromPubKey: fromKey.address,
      stakePubKey: derivedPubKey.toBase58(),
      authorized: Authorized(
        withdrawer: withdrawer.address,
        staker: staker.address,
      ),
      base: stakeKey.address,
      seed: seed,
      lamports: lamports + stakeAmount,
    );

    expect(
      rpcClient.signAndSendTransaction(
        program,
        [fromKey, stakeKey],
      ),
      completes,
    );
  });

  test('Authorize Staker', () async {
    final staker = await Ed25519HDKeyPair.random();
    final withdrawer = await Ed25519HDKeyPair.random();
    final account = await Ed25519HDKeyPair.random();
    final fromKey = await _newAccount(
        rpcClient, subscriptionClient, staker, withdrawer, account);
    final newStaker = await Ed25519HDKeyPair.random();
    final program = StakeProgram.authorize(
      stakePubKey: account.address,
      authorityPubKey: staker.address,
      stakeAuthorize: StakeAuthorize.staker(newStaker.address),
    );
    expect(
      rpcClient.signAndSendTransaction(
        program,
        [fromKey, staker],
      ),
      completes,
    );
  });

  test('Authorize Withdrawer', () async {
    final staker = await Ed25519HDKeyPair.random();
    final withdrawer = await Ed25519HDKeyPair.random();
    final account = await Ed25519HDKeyPair.random();
    final fromKey = await _newAccount(
        rpcClient, subscriptionClient, staker, withdrawer, account);
    final newWithdrawer = await Ed25519HDKeyPair.random();
    final program = StakeProgram.authorize(
      stakePubKey: account.address,
      authorityPubKey: withdrawer.address,
      stakeAuthorize: StakeAuthorize.withdrawer(newWithdrawer.address),
    );
    expect(
      rpcClient.signAndSendTransaction(
        program,
        [fromKey, withdrawer],
      ),
      completes,
    );
  });

  test('Split', () async {
    Message program;

    final staker = await Ed25519HDKeyPair.random();
    final withdrawer = await Ed25519HDKeyPair.random();
    final account = await Ed25519HDKeyPair.random();
    final fromKey = await _newAccount(
        rpcClient, subscriptionClient, staker, withdrawer, account);
    final newAccount = await Ed25519HDKeyPair.random();
    final lamports = await rpcClient.getMinimumBalanceForRentExemption(
      StakeProgram.neededAccountSpace,
    );
    program = SystemProgram.createAccount(
      lamports: lamports,
      pubKey: newAccount.address,
      fromPubKey: fromKey.address,
      owner: StakeProgram.programId,
      space: StakeProgram.neededAccountSpace,
    );
    final signature = await rpcClient.signAndSendTransaction(
      program,
      [fromKey, newAccount],
    );
    await subscriptionClient.waitForSignatureStatus(
      signature,
      status: ConfirmationStatus.finalized,
    );

    program = StakeProgram.split(
      lamports: 100,
      destinationStakePubKey: newAccount.address,
      sourceStakePubKey: account.address,
      stakeAuthorityPubKey: staker.address,
    );

    expect(
      rpcClient.signAndSendTransaction(program, [fromKey, staker]),
      completes,
    );
  }, timeout: const Timeout(Duration(minutes: 2)));

  test('Withdraw', () async {
    final staker = await Ed25519HDKeyPair.random();
    final withdrawer = await Ed25519HDKeyPair.random();
    final account = await Ed25519HDKeyPair.random();
    final fromKey = await _newAccount(
        rpcClient, subscriptionClient, staker, withdrawer, account);
    final program = StakeProgram.withdraw(
      lamports: 100,
      authorityPubKey: withdrawer.address,
      stakePubKey: account.address,
      recipientPubKey: fromKey.address,
    );

    expect(
      rpcClient.signAndSendTransaction(program, [fromKey, withdrawer]),
      completes,
    );
  });

  test('Merge', () async {
    final staker = await Ed25519HDKeyPair.random();
    final withdrawer = await Ed25519HDKeyPair.random();
    final account1 = await Ed25519HDKeyPair.random();
    final account2 = await Ed25519HDKeyPair.random();
    final fromKey = await _newAccount(
        rpcClient, subscriptionClient, staker, withdrawer, account1);
    await _newAccount(
      rpcClient,
      subscriptionClient,
      staker,
      withdrawer,
      account2,
    );
    final program = StakeProgram.merge(
      authorityPubKey: staker.address,
      sourceStakePubKey: account2.address,
      destinationStakePubKey: account1.address,
    );

    expect(
      rpcClient.signAndSendTransaction(program, [fromKey, staker]),
      completes,
    );
  }, timeout: const Timeout(Duration(minutes: 1)));
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
    status: ConfirmationStatus.finalized,
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
  final program = StakeProgram.createAccount(
    fromPubKey: fromKey.address,
    stakePubKey: stakeKey.address,
    authorized: Authorized(
      staker: staker.address,
      withdrawer: withdrawer.address,
    ),
    lamports: rent + 50 * lamportsPerSol,
  );

  final signature = await rpcClient.signAndSendTransaction(
    program,
    [fromKey, stakeKey],
  );
  await subscriptionClient.waitForSignatureStatus(
    signature,
    status: ConfirmationStatus.finalized,
  );

  return fromKey;
}
