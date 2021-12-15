import 'package:solana/src/crypto/ed25519_hd_keypair.dart';
import 'package:solana/src/exceptions/json_rpc_exception.dart';
import 'package:solana/src/helpers.dart';
import 'package:solana/src/rpc/client.dart';
import 'package:solana/src/subscription_client/subscription_client.dart';
import 'package:solana/src/system_program/system_program.dart';
import 'package:test/test.dart';

import 'airdrop.dart';
import 'config.dart';

void main() {
  late final RpcClient rpcClient;
  late final SubscriptionClient subscriptionClient;
  late final Ed25519HDKeyPair creatorKey;

  setUpAll(() async {
    rpcClient = RpcClient(devnetRpcUrl);
    subscriptionClient = await SubscriptionClient.connect(devnetWebsocketUrl);
    creatorKey = await Ed25519HDKeyPair.random();
    await airdrop(rpcClient, subscriptionClient, creatorKey, sol: 10);
  });

  test('Create account succeeds', () async {
    final accountKey = await Ed25519HDKeyPair.random();
    final lamports = await rpcClient.getMinimumBalanceForRentExemption(16);
    final program = SystemProgram.createAccount(
      pubKey: accountKey.address,
      creator: creatorKey.address,
      lamports: lamports,
      owner: SystemProgram.programId,
      space: 16,
    );

    final future = rpcClient.signAndSendTransaction(
      program,
      [creatorKey, accountKey],
    );

    expect(future, completes);
  });

  test('Create account with seed succeeds', () async {
    final accountKey = await Ed25519HDKeyPair.random();
    final lamports = await rpcClient.getMinimumBalanceForRentExemption(16);
    final programId = SystemProgram.programId;
    final base = accountKey.address;
    final seed = '1234';
    final program = SystemProgram.createAccountWithSeed(
      creator: creatorKey.address,
      pubKey: await newPubKeyWithSeed(
        base: base,
        seed: seed,
        programId: programId,
      ),
      seed: seed,
      base: base,
      lamports: lamports,
      owner: programId,
      space: 16,
    );

    final future = rpcClient.signAndSendTransaction(
      program,
      [creatorKey, accountKey],
    );

    expect(future, completes);
  });

  test('Create nonce account succeeds', () async {
    final nonceKey = await Ed25519HDKeyPair.random();
    final authorized = nonceKey;
    final lamports = await rpcClient.getMinimumBalanceForRentExemption(
      SystemProgram.nonceAccountSize,
    );
    final program = SystemProgram.createNonceAccount(
      creator: creatorKey.address,
      noncePubKey: nonceKey.address,
      authority: authorized.address,
      lamports: lamports,
    );

    expect(program.instructions.length, equals(2));
    final instruction = program.instructions[0];
    expect(instruction.programId, equals(SystemProgram.programId));
    final accounts = instruction.accounts;
    expect(
      accounts.firstWhere((a) => a.pubKey == creatorKey.address),
      isNotNull,
    );
    expect(
      accounts.firstWhere((a) => a.pubKey == nonceKey.address),
      isNotNull,
    );
    final future = rpcClient.signAndSendTransaction(
      program,
      [creatorKey, nonceKey],
    );

    expect(future, completes);
  });

  test('Create nonce account fails for insufficient lamports', () async {
    final nonceKey = await Ed25519HDKeyPair.random();
    final authorized = nonceKey;
    final lamports = await rpcClient.getMinimumBalanceForRentExemption(
      SystemProgram.nonceAccountSize,
    );
    final program = SystemProgram.createNonceAccount(
      creator: creatorKey.address,
      noncePubKey: nonceKey.address,
      authority: authorized.address,
      lamports: lamports - 1,
    );
    final future = rpcClient.signAndSendTransaction(
      program,
      [creatorKey, nonceKey],
    );

    expect(future, throwsA(isA<JsonRpcException>()));
  });
}
