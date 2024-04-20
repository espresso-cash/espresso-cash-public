import 'package:solana/solana.dart';
import 'package:test/test.dart';

import '../../config.dart';

void main() {
  final client = SolanaClient(
    rpcUrl: Uri.parse(devnetRpcUrl),
    websocketUrl: Uri.parse(devnetWebsocketUrl),
  );

  test('Create account', () async {
    final fromKey = await _createFundedKey(client);
    final accountKey = await Ed25519HDKeyPair.random();
    final instruction = SystemInstruction.createAccount(
      newAccount: accountKey.publicKey,
      fundingAccount: fromKey.publicKey,
      lamports: 0,
      owner: SystemProgram.id,
      space: 0,
    );

    final future = client.sendAndConfirmTransaction(
      message: Message.only(instruction),
      signers: [fromKey, accountKey],
      commitment: Commitment.confirmed,
    );

    expect(future, completes);
  });

  test('Assign', () async {
    final fromKey = await _createFundedKey(client);
    final recipient = await Ed25519HDKeyPair.random();
    final instruction = SystemInstruction.assign(
      assignedAccount: fromKey.publicKey,
      owner: recipient.publicKey,
    );
    final future = client.sendAndConfirmTransaction(
      message: Message.only(instruction),
      signers: [fromKey],
      commitment: Commitment.confirmed,
    );

    expect(future, completes);
  });

  test('Transfer', () async {
    final fromKey = await _createFundedKey(client);
    final recipient = await Ed25519HDKeyPair.random();
    const lamports = lamportsPerSol;
    final instruction = SystemInstruction.transfer(
      fundingAccount: fromKey.publicKey,
      recipientAccount: recipient.publicKey,
      lamports: lamports,
    );
    final future = client.sendAndConfirmTransaction(
      message: Message.only(instruction),
      signers: [fromKey],
      commitment: Commitment.confirmed,
    );

    expect(future, completes);
  });

  test('Create account with seed', () async {
    final fromKey = await _createFundedKey(client);
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

    final future = client.sendAndConfirmTransaction(
      message: Message.only(instruction),
      signers: [fromKey, accountKey],
      commitment: Commitment.confirmed,
    );

    expect(future, completes);
  });

  test('Create nonce account', () async {
    final fromKey = await Ed25519HDKeyPair.random();
    final nonceKey = await Ed25519HDKeyPair.random();
    final authorized = nonceKey;
    final lamports = await client.rpcClient
        .getMinimumBalanceForRentExemption(SystemProgram.nonceAccountSize);

    await client.requestAirdrop(
      address: fromKey.publicKey,
      lamports: 5 * lamportsPerSol,
      commitment: Commitment.confirmed,
    );

    final instructions = SystemInstruction.createAndInitializeNonceAccount(
      fromPubKey: fromKey.publicKey,
      noncePubKey: nonceKey.publicKey,
      noceAuthorityPubKey: authorized.publicKey,
      lamports: lamports,
    );

    final future = client.sendAndConfirmTransaction(
      message: Message(instructions: instructions),
      signers: [fromKey, nonceKey],
      commitment: Commitment.confirmed,
    );

    expect(future, completes);
  });

  test('Create nonce account fails for insufficient lamports', () async {
    final nonceKey = await Ed25519HDKeyPair.random();
    final fromKey = await _createFundedKey(client);
    final authorized = fromKey;
    final lamports = await client.rpcClient
        .getMinimumBalanceForRentExemption(SystemProgram.nonceAccountSize);

    final instructions = SystemInstruction.createAndInitializeNonceAccount(
      fromPubKey: fromKey.publicKey,
      noncePubKey: nonceKey.publicKey,
      noceAuthorityPubKey: authorized.publicKey,
      lamports: lamports - 1,
    );
    final future = client.sendAndConfirmTransaction(
      message: Message(instructions: instructions),
      signers: [fromKey, nonceKey],
      commitment: Commitment.confirmed,
    );

    expect(future, throwsA(isA<JsonRpcException>()));
  });

  test('Advance nonce account', () async {
    final fromKey = await _createFundedKey(client);
    final nonceKey = await _createNonceAccount(
      fromKey,
      client,
    );

    final instruction = SystemInstruction.advanceNonceAccount(
      nonce: nonceKey.publicKey,
      nonceAuthority: fromKey.publicKey,
    );

    expect(
      client.sendAndConfirmTransaction(
        message: Message.only(instruction),
        signers: [fromKey],
        commitment: Commitment.confirmed,
      ),
      completes,
    );
  });

  test('Transfer with seed', () async {
    final fromKey = await _createFundedKey(client);
    final recipient = await Ed25519HDKeyPair.random();
    const lamports = lamportsPerSol;
    final derivedAddress = await Ed25519HDPublicKey.createWithSeed(
      fromPublicKey: fromKey.publicKey,
      seed: '1234',
      programId: SystemProgram.id,
    );
    await client.requestAirdrop(
      address: derivedAddress,
      lamports: 2 * lamportsPerSol,
      commitment: Commitment.confirmed,
    );

    final instruction = SystemInstruction.transferWithSeed(
      fundingAccount: derivedAddress,
      recipientAccount: recipient.publicKey,
      lamports: lamports,
      base: fromKey.publicKey,
      seed: '1234',
      owner: SystemProgram.id,
    );
    final future = client.sendAndConfirmTransaction(
      message: Message.only(instruction),
      signers: [fromKey],
      commitment: Commitment.confirmed,
    );

    expect(future, completes);
  });

  test('Assign with seed', () async {
    final fromKey = await _createFundedKey(client);
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
    final future = client.sendAndConfirmTransaction(
      message: Message.only(instruction),
      signers: [fromKey, recipient],
      commitment: Commitment.confirmed,
    );

    expect(future, completes);
  });

  test('Allocate', () async {
    final fromKey = await _createFundedKey(client);
    final instruction = SystemInstruction.allocate(
      account: fromKey.publicKey,
      space: 100,
    );
    final future = client.sendAndConfirmTransaction(
      message: Message.only(instruction),
      signers: [fromKey],
      commitment: Commitment.confirmed,
    );

    expect(future, completes);
  });

  test('Allocate with seed', () async {
    final fromKey = await _createFundedKey(client);
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
    final future = client.sendAndConfirmTransaction(
      message: Message.only(instruction),
      signers: [fromKey],
      commitment: Commitment.confirmed,
    );

    expect(future, completes);
  });

  test('Withdraw nonce account', () async {
    final fromKey = await _createFundedKey(client);
    final nonceKey = await _createNonceAccount(
      fromKey,
      client,
      extraLamports: 100,
    );
    final toKey = await Ed25519HDKeyPair.random();

    final instruction = SystemInstruction.withdrawNonceAccount(
      nonce: nonceKey.publicKey,
      nonceAuthority: fromKey.publicKey,
      recipient: toKey.publicKey,
      lamports: 100 +
          await client.rpcClient.getMinimumBalanceForRentExemption(
            SystemProgram.nonceAccountSize,
          ),
    );

    expect(
      client.sendAndConfirmTransaction(
        message: Message.only(instruction),
        signers: [fromKey],
        commitment: Commitment.confirmed,
      ),
      completes,
    );
  });

  test('Authorize nonce account', () async {
    final fromKey = await _createFundedKey(client);
    final nonceKey = await _createNonceAccount(fromKey, client);
    final newAuthority = await Ed25519HDKeyPair.random();

    final instruction = SystemInstruction.authorizeNonceAccount(
      nonce: nonceKey.publicKey,
      nonceAuthority: fromKey.publicKey,
      newAuthority: newAuthority.publicKey,
    );

    expect(
      client.sendAndConfirmTransaction(
        message: Message.only(instruction),
        signers: [fromKey],
        commitment: Commitment.confirmed,
      ),
      completes,
    );
  });
}

Future<Ed25519HDKeyPair> _createFundedKey(SolanaClient client) async {
  final key = await Ed25519HDKeyPair.random();

  await client.requestAirdrop(
    address: key.publicKey,
    lamports: 100 * lamportsPerSol,
    commitment: Commitment.confirmed,
  );

  return key;
}

Future<Ed25519HDKeyPair> _createNonceAccount(
  Ed25519HDKeyPair nonceAuthority,
  SolanaClient client, {
  int extraLamports = 0,
}) async {
  final nonceKey = await Ed25519HDKeyPair.random();
  final lamports = await client.rpcClient
      .getMinimumBalanceForRentExemption(SystemProgram.nonceAccountSize);

  final instructions = SystemInstruction.createAndInitializeNonceAccount(
    fromPubKey: nonceAuthority.publicKey,
    noncePubKey: nonceKey.publicKey,
    noceAuthorityPubKey: nonceAuthority.publicKey,
    lamports: lamports + extraLamports,
  );
  await client.sendAndConfirmTransaction(
    message: Message(instructions: instructions),
    signers: [nonceAuthority, nonceKey],
    commitment: Commitment.confirmed,
  );

  return nonceKey;
}
