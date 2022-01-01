import 'package:solana/src/constants.dart';
import 'package:solana/src/crypto/ed25519_hd_keypair.dart';
import 'package:solana/src/exceptions/json_rpc_exception.dart';
import 'package:solana/src/helpers.dart';
import 'package:solana/src/programs/system_program/system_program.dart';
import 'package:solana/src/rpc/client.dart';
import 'package:solana/src/rpc/dto/commitment.dart';
import 'package:solana/src/rpc/dto/confirmation_status.dart';
import 'package:solana/src/subscription_client/subscription_client.dart';
import 'package:test/test.dart';

import 'config.dart';

void main() {
  late final RpcClient rpcClient;
  late final SubscriptionClient subscriptionClient;

  setUpAll(() async {
    rpcClient = RpcClient(devnetRpcUrl);
    subscriptionClient = await SubscriptionClient.connect(devnetWebsocketUrl);
  });

  test('Create account', () async {
    final fromKey = await _createFundedKey(rpcClient, subscriptionClient);
    final accountKey = await Ed25519HDKeyPair.random();
    final program = SystemProgram.createAccount(
      pubKey: accountKey.address,
      fromPubKey: fromKey.address,
      lamports: 0,
      owner: SystemProgram.programId,
      space: 0,
    );

    final future = rpcClient.signAndSendTransaction(
      program,
      [fromKey, accountKey],
    );

    expect(future, completes);
  });

  test('Assign', () async {
    final fromKey = await _createFundedKey(rpcClient, subscriptionClient);
    final recipient = await Ed25519HDKeyPair.random();
    final program = SystemProgram.assign(
      pubKey: fromKey.address,
      owner: recipient.address,
    );
    final future = rpcClient.signAndSendTransaction(
      program,
      [fromKey],
    );

    expect(future, completes);
  });

  test('Transfer', () async {
    final fromKey = await _createFundedKey(rpcClient, subscriptionClient);
    final recipient = await Ed25519HDKeyPair.random();
    final lamports = lamportsPerSol;
    final program = SystemProgram.transfer(
      source: fromKey.address,
      destination: recipient.address,
      lamports: lamports,
    );
    final future = rpcClient.signAndSendTransaction(
      program,
      [fromKey],
    );

    expect(future, completes);
  });

  test('Create account with seed', () async {
    final fromKey = await _createFundedKey(rpcClient, subscriptionClient);
    final accountKey = await Ed25519HDKeyPair.random();
    final programId = SystemProgram.programId;
    final seed = '1234';
    final derivedAddress = await computePubKeyWithSeed(
      base: accountKey.address,
      seed: seed,
      programId: programId,
    );
    final program = SystemProgram.createAccountWithSeed(
      fromPubKey: fromKey.address,
      pubKey: derivedAddress,
      base: accountKey.address,
      seed: seed,
      lamports: 0,
      space: 0,
      owner: programId,
    );

    final future = rpcClient.signAndSendTransaction(
      program,
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

    final program = SystemProgram.createNonceAccount(
      fromPubKey: fromKey.address,
      noncePubKey: nonceKey.address,
      noceAuthorityPubKey: authorized.address,
      lamports: lamports,
    );

    expect(program.instructions.length, equals(2));
    final instruction = program.instructions[0];
    expect(instruction.programId, equals(SystemProgram.programId));
    final accounts = instruction.accounts;
    expect(
      accounts.firstWhere((a) => a.pubKey == fromKey.address),
      isNotNull,
    );
    expect(
      accounts.firstWhere((a) => a.pubKey == nonceKey.address),
      isNotNull,
    );
    final future = rpcClient.signAndSendTransaction(
      program,
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

    final program = SystemProgram.createNonceAccount(
      fromPubKey: fromKey.address,
      noncePubKey: nonceKey.address,
      noceAuthorityPubKey: authorized.address,
      lamports: lamports - 1,
    );
    final future = rpcClient.signAndSendTransaction(
      program,
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

    final program = SystemProgram.advanceNonceAccount(
      nonceAuthorityPubKey: nonceKey.address,
      authorizedPubKey: fromKey.address,
    );

    expect(
      rpcClient.signAndSendTransaction(program, [fromKey]),
      completes,
    );
  });

  test('Transfer with seed', () async {
    final fromKey = await _createFundedKey(rpcClient, subscriptionClient);
    final recipient = await Ed25519HDKeyPair.random();
    final lamports = lamportsPerSol;
    final programId = SystemProgram.programId;
    final base = fromKey.address;
    final seed = '1234';
    final derivedAddress = await computePubKeyWithSeed(
      base: fromKey.address,
      seed: seed,
      programId: programId,
    );
    final signature = await rpcClient.requestAirdrop(
      derivedAddress,
      2 * lamportsPerSol,
      commitment: Commitment.confirmed,
    );
    await subscriptionClient.waitForSignatureStatus(
      signature,
      status: ConfirmationStatus.finalized,
    );
    final program = SystemProgram.transferWithSeed(
      source: derivedAddress,
      destination: recipient.address,
      lamports: lamports,
      base: base,
      seed: seed,
      owner: programId,
    );
    final future = rpcClient.signAndSendTransaction(
      program,
      [fromKey],
    );

    expect(future, completes);
  });

  test('Assign with seed', () async {
    final fromKey = await _createFundedKey(rpcClient, subscriptionClient);
    final recipient = await Ed25519HDKeyPair.random();
    final programId = SystemProgram.programId;
    final seed = '1234';
    final derivedAddress = await computePubKeyWithSeed(
      base: recipient.address,
      seed: seed,
      programId: programId,
    );
    final program = SystemProgram.assignWithSeed(
      pubKey: derivedAddress,
      base: recipient.address,
      owner: programId,
      seed: seed,
    );
    final future = rpcClient.signAndSendTransaction(
      program,
      [fromKey, recipient],
    );

    expect(future, completes);
  });

  test('Allocate', () async {
    final fromKey = await _createFundedKey(rpcClient, subscriptionClient);
    final program = SystemProgram.allocate(
      pubKey: fromKey.address,
      space: 100,
    );
    final future = rpcClient.signAndSendTransaction(
      program,
      [fromKey],
    );

    expect(future, completes);
  });

  test('Allocate with seed', () async {
    final fromKey = await _createFundedKey(rpcClient, subscriptionClient);
    final programId = SystemProgram.programId;
    final seed = '1234';
    final derivedAddress = await computePubKeyWithSeed(
      base: fromKey.address,
      seed: seed,
      programId: programId,
    );
    final program = SystemProgram.allocateWithSeed(
      pubKey: derivedAddress,
      space: 100,
      base: fromKey.address,
      owner: programId,
      seed: seed,
    );
    final future = rpcClient.signAndSendTransaction(
      program,
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

    final program = SystemProgram.withdrawNonceAccount(
      noncePubKey: nonceKey.address,
      authorizedPubKey: fromKey.address,
      toPubKey: toKey.address,
      lamports: 100,
    );

    expect(
      rpcClient.signAndSendTransaction(
        program,
        [fromKey],
      ),
      completes,
    );
  });

  test('Authorize nonce account', () async {
    final fromKey = await _createFundedKey(rpcClient, subscriptionClient);
    final nonceKey =
        await _createNonceAccount(fromKey, rpcClient, subscriptionClient);
    final newAuthority = await Ed25519HDKeyPair.random();

    final program = SystemProgram.authorizeNonceAccount(
      noncePubKey: nonceKey.address,
      authorizedPubKey: fromKey.address,
      newAuthority: newAuthority.address,
    );

    expect(
      rpcClient.signAndSendTransaction(
        program,
        [fromKey],
      ),
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

  var program = SystemProgram.createNonceAccount(
    fromPubKey: nonceAuthority.address,
    noncePubKey: nonceKey.address,
    noceAuthorityPubKey: nonceAuthority.address,
    lamports: lamports + extraLamports,
  );
  final signature = await rpcClient.signAndSendTransaction(
    program,
    [nonceAuthority, nonceKey],
  );
  await subscriptionClient.waitForSignatureStatus(
    signature,
    status: ConfirmationStatus.finalized,
  );

  return nonceKey;
}
