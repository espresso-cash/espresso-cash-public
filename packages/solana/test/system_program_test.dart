import 'package:solana/dto.dart';
import 'package:solana/solana.dart';
import 'package:test/test.dart';

import 'config.dart';

void main() {
  late final RpcClient rpcClient;
  late final SubscriptionClient subscriptionClient;

  setUpAll(() async {
    rpcClient = RpcClient(devnetRpcUrl);
    subscriptionClient = SubscriptionClient.connect(devnetWebsocketUrl);
  });

  test('Create account', () async {
    final fromKey = await _createFundedKey(rpcClient, subscriptionClient);
    final accountKey = await Ed25519HDKeyPair.random();
    final instruction = SystemInstruction.createAccount(
      newAccount: accountKey.publicKey,
      fundingAccount: fromKey.publicKey,
      lamports: 0,
      owner: SystemProgram.id,
      space: 0,
    );

    final future = rpcClient.signAndSendTransaction(
      Message.only(instruction),
      [fromKey, accountKey],
    );

    expect(future, completes);
  });

  test('Assign', () async {
    final fromKey = await _createFundedKey(rpcClient, subscriptionClient);
    final recipient = await Ed25519HDKeyPair.random();
    final instruction = SystemInstruction.assign(
      assignedAccount: fromKey.publicKey,
      owner: recipient.publicKey,
    );
    final future = rpcClient.signAndSendTransaction(
      Message.only(instruction),
      [fromKey],
    );

    expect(future, completes);
  });

  test('Transfer', () async {
    final fromKey = await _createFundedKey(rpcClient, subscriptionClient);
    final recipient = await Ed25519HDKeyPair.random();
    const lamports = lamportsPerSol;
    final instruction = SystemInstruction.transfer(
      fundingAccount: fromKey.publicKey,
      recipientAccount: recipient.publicKey,
      lamports: lamports,
    );
    final future = rpcClient.signAndSendTransaction(
      Message.only(instruction),
      [fromKey],
    );

    expect(future, completes);
  });

  test('Create account with seed', () async {
    final fromKey = await _createFundedKey(rpcClient, subscriptionClient);
    final accountKey = await Ed25519HDKeyPair.random();
    const seed = '1234';
    final derivedAddress = await Ed25519HDPublicKey.createWithSeed(
      fromPublicKey: accountKey.publicKey,
      seed: seed,
      programId: SystemProgram.id,
    );
    final instruction = SystemInstruction.createAccountWithSeed(
      fundingAccount: fromKey.publicKey,
      newAccount: derivedAddress,
      base: accountKey.publicKey,
      seed: seed,
      lamports: 0,
      space: 0,
      owner: SystemProgram.id,
    );

    final future = rpcClient.signAndSendTransaction(
      Message.only(instruction),
      [fromKey, accountKey],
    );

    expect(future, completes);
  });

  test('Create nonce account', () async {
    final fromKey = await Ed25519HDKeyPair.random();
    final nonceKey = await Ed25519HDKeyPair.random();
    final authorized = nonceKey;
    final lamports = await rpcClient.getMinimumBalanceForRentExemption(
      SystemProgram.nonceAccountSize,
    );

    final signature = await rpcClient.requestAirdrop(
      fromKey.address,
      5 * lamportsPerSol,
    );
    await subscriptionClient.waitForSignatureStatus(
      signature,
      status: ConfirmationStatus.finalized,
    );

    final instructions = SystemInstruction.createAndInitializeNonceAccount(
      fromPubKey: fromKey.publicKey,
      noncePubKey: nonceKey.publicKey,
      noceAuthorityPubKey: authorized.publicKey,
      lamports: lamports,
    );

    final future = rpcClient.signAndSendTransaction(
      Message(instructions: instructions),
      [fromKey, nonceKey],
    );

    expect(future, completes);
  });

  test('Create nonce account fails for insufficient lamports', () async {
    final nonceKey = await Ed25519HDKeyPair.random();
    final fromKey = await _createFundedKey(rpcClient, subscriptionClient);
    final authorized = fromKey;
    final lamports = await rpcClient.getMinimumBalanceForRentExemption(
      SystemProgram.nonceAccountSize,
    );

    final instructions = SystemInstruction.createAndInitializeNonceAccount(
      fromPubKey: fromKey.publicKey,
      noncePubKey: nonceKey.publicKey,
      noceAuthorityPubKey: authorized.publicKey,
      lamports: lamports - 1,
    );
    final future = rpcClient.signAndSendTransaction(
      Message(instructions: instructions),
      [fromKey, nonceKey],
    );

    expect(future, throwsA(isA<JsonRpcException>()));
  });

  test('Advance nonce account', () async {
    final fromKey = await _createFundedKey(rpcClient, subscriptionClient);
    final nonceKey = await _createNonceAccount(
      fromKey,
      rpcClient,
      subscriptionClient,
    );

    final instruction = SystemInstruction.advanceNonceAccount(
      nonce: nonceKey.publicKey,
      nonceAuthority: fromKey.publicKey,
    );

    expect(
      rpcClient.signAndSendTransaction(Message.only(instruction), [fromKey]),
      completes,
    );
  });

  test('Transfer with seed', () async {
    final fromKey = await _createFundedKey(rpcClient, subscriptionClient);
    final recipient = await Ed25519HDKeyPair.random();
    const lamports = lamportsPerSol;
    final derivedAddress = await Ed25519HDPublicKey.createWithSeed(
      fromPublicKey: fromKey.publicKey,
      seed: '1234',
      programId: SystemProgram.id,
    );
    final signature = await rpcClient.requestAirdrop(
      derivedAddress.toBase58(),
      2 * lamportsPerSol,
      commitment: Commitment.confirmed,
    );
    await subscriptionClient.waitForSignatureStatus(
      signature,
      status: ConfirmationStatus.finalized,
    );
    final instruction = SystemInstruction.transferWithSeed(
      fundingAccount: derivedAddress,
      recipientAccount: recipient.publicKey,
      lamports: lamports,
      base: fromKey.publicKey,
      seed: '1234',
      owner: SystemProgram.id,
    );
    final future = rpcClient.signAndSendTransaction(
      Message.only(instruction),
      [fromKey],
    );

    expect(future, completes);
  });

  test('Assign with seed', () async {
    final fromKey = await _createFundedKey(rpcClient, subscriptionClient);
    final recipient = await Ed25519HDKeyPair.random();
    const seed = '1234';
    final derivedAddress = await Ed25519HDPublicKey.createWithSeed(
      fromPublicKey: recipient.publicKey,
      seed: seed,
      programId: SystemProgram.id,
    );
    final instruction = SystemInstruction.assignWithSeed(
      account: derivedAddress,
      base: recipient.publicKey,
      owner: SystemProgram.id,
      seed: seed,
    );
    final future = rpcClient.signAndSendTransaction(
      Message.only(instruction),
      [fromKey, recipient],
    );

    expect(future, completes);
  });

  test('Allocate', () async {
    final fromKey = await _createFundedKey(rpcClient, subscriptionClient);
    final instruction = SystemInstruction.allocate(
      account: fromKey.publicKey,
      space: 100,
    );
    final future = rpcClient.signAndSendTransaction(
      Message.only(instruction),
      [fromKey],
    );

    expect(future, completes);
  });

  test('Allocate with seed', () async {
    final fromKey = await _createFundedKey(rpcClient, subscriptionClient);
    final derivedAddress = await Ed25519HDPublicKey.createWithSeed(
      fromPublicKey: fromKey.publicKey,
      seed: '1234',
      programId: SystemProgram.id,
    );
    final instruction = SystemInstruction.allocateWithSeed(
      account: derivedAddress,
      space: 100,
      base: fromKey.publicKey,
      owner: SystemProgram.id,
      seed: '1234',
    );
    final future = rpcClient.signAndSendTransaction(
      Message.only(instruction),
      [fromKey],
    );

    expect(future, completes);
  });

  test('Withdraw nonce account', () async {
    final fromKey = await _createFundedKey(rpcClient, subscriptionClient);
    final nonceKey = await _createNonceAccount(
      fromKey,
      rpcClient,
      subscriptionClient,
      extraLamports: 100,
    );
    final toKey = await Ed25519HDKeyPair.random();

    final instruction = SystemInstruction.withdrawNonceAccount(
      nonce: nonceKey.publicKey,
      nonceAuthority: fromKey.publicKey,
      recipient: toKey.publicKey,
      lamports: 100,
    );

    expect(
      rpcClient.signAndSendTransaction(Message.only(instruction), [fromKey]),
      completes,
    );
  });

  test('Authorize nonce account', () async {
    final fromKey = await _createFundedKey(rpcClient, subscriptionClient);
    final nonceKey =
        await _createNonceAccount(fromKey, rpcClient, subscriptionClient);
    final newAuthority = await Ed25519HDKeyPair.random();

    final instruction = SystemInstruction.authorizeNonceAccount(
      nonce: nonceKey.publicKey,
      nonceAuthority: fromKey.publicKey,
      newAuthority: newAuthority.publicKey,
    );

    expect(
      rpcClient.signAndSendTransaction(Message.only(instruction), [fromKey]),
      completes,
    );
  });
}

Future<Ed25519HDKeyPair> _createFundedKey(
  RpcClient rpcClient,
  SubscriptionClient subscriptionClient,
) async {
  final key = await Ed25519HDKeyPair.random();

  final signature =
      await rpcClient.requestAirdrop(key.address, 100 * lamportsPerSol);

  await subscriptionClient.waitForSignatureStatus(
    signature,
    status: ConfirmationStatus.finalized,
  );

  return key;
}

Future<Ed25519HDKeyPair> _createNonceAccount(
  Ed25519HDKeyPair nonceAuthority,
  RpcClient rpcClient,
  SubscriptionClient subscriptionClient, {
  int extraLamports = 0,
}) async {
  final nonceKey = await Ed25519HDKeyPair.random();
  final lamports = await rpcClient.getMinimumBalanceForRentExemption(
    SystemProgram.nonceAccountSize,
  );

  final instructions = SystemInstruction.createAndInitializeNonceAccount(
    fromPubKey: nonceAuthority.publicKey,
    noncePubKey: nonceKey.publicKey,
    noceAuthorityPubKey: nonceAuthority.publicKey,
    lamports: lamports + extraLamports,
  );
  final signature = await rpcClient.signAndSendTransaction(
    Message(instructions: instructions),
    [nonceAuthority, nonceKey],
  );
  await subscriptionClient.waitForSignatureStatus(
    signature,
    status: ConfirmationStatus.finalized,
  );

  return nonceKey;
}
