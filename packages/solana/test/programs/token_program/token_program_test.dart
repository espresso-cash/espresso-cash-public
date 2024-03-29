// ignore_for_file: avoid-unnecessary-late

import 'package:solana/dto.dart';
import 'package:solana/solana.dart';
import 'package:test/test.dart';

import '../../config.dart';

void main() {
  late final Ed25519HDKeyPair mint;
  late final Ed25519HDKeyPair freezeAuthority;
  late final Ed25519HDKeyPair mintAuthority;
  late final Ed25519HDKeyPair tokensHolder;
  late final Ed25519HDKeyPair randomRecipient;
  late final Ed25519HDKeyPair newAuthority;

  final client = createTestSolanaClient();

  setUpAll(() async {
    mint = await Ed25519HDKeyPair.random();
    freezeAuthority = await Ed25519HDKeyPair.random();
    mintAuthority = await Ed25519HDKeyPair.random();
    tokensHolder = await Ed25519HDKeyPair.random();
    randomRecipient = await Ed25519HDKeyPair.random();
    newAuthority = await Ed25519HDKeyPair.random();

    await client.requestAirdrop(
      address: mintAuthority.publicKey,
      lamports: lamportsPerSol,
      commitment: Commitment.confirmed,
    );
    await client.requestAirdrop(
      address: newAuthority.publicKey,
      lamports: lamportsPerSol,
      commitment: Commitment.confirmed,
    );
  });

  Future<void> sendMessage(
    Message message,
    List<Ed25519HDKeyPair> signers,
  ) async {
    await client.sendAndConfirmTransaction(
      message: message,
      signers: signers,
      commitment: Commitment.confirmed,
    );
  }

  test('Initialize Mint', () async {
    final rent = await client.rpcClient
        .getMinimumBalanceForRentExemption(TokenProgram.neededMintAccountSpace);
    // Not throwing is sufficient as test, we need the mint to exist
    final instructions = TokenInstruction.createAccountAndInitializeMint(
      mint: mint.publicKey,
      mintAuthority: mintAuthority.publicKey,
      freezeAuthority: freezeAuthority.publicKey,
      rent: rent,
      space: TokenProgram.neededMintAccountSpace,
      decimals: 5,
    );
    await sendMessage(
      Message(instructions: instructions),
      [mintAuthority, mint],
    );
  });

  test('Create Account', () async {
    final rent = await client.rpcClient
        .getMinimumBalanceForRentExemption(TokenProgram.neededAccountSpace);
    final instructions = TokenInstruction.createAndInitializeAccount(
      mint: mint.publicKey,
      address: tokensHolder.publicKey,
      owner: mintAuthority.publicKey,
      rent: rent,
      space: TokenProgram.neededAccountSpace,
    );

    expect(
      sendMessage(
        Message(instructions: instructions),
        [mintAuthority, tokensHolder],
      ),
      completes,
    );
  });

  test('Mint To', () {
    final instruction = TokenInstruction.mintTo(
      mint: mint.publicKey,
      destination: tokensHolder.publicKey,
      authority: mintAuthority.publicKey,
      amount: 10000000000,
    );

    expect(
      sendMessage(Message.only(instruction), [mintAuthority]),
      completes,
    );
  });

  test('Mint To Checked', () {
    final instruction = TokenInstruction.mintToChecked(
      mint: mint.publicKey,
      destination: tokensHolder.publicKey,
      authority: mintAuthority.publicKey,
      amount: 10000000000,
      decimals: 5,
    );

    expect(
      sendMessage(Message.only(instruction), [mintAuthority]),
      completes,
    );
  });

  test('Transfer', () {
    final instruction = TokenInstruction.transfer(
      source: tokensHolder.publicKey,
      destination: tokensHolder.publicKey,
      owner: mintAuthority.publicKey,
      amount: 100000,
    );

    expect(
      sendMessage(Message.only(instruction), [mintAuthority]),
      completes,
    );
  });

  test('Transfer Checked', () {
    final instruction = TokenInstruction.transferChecked(
      source: tokensHolder.publicKey,
      destination: tokensHolder.publicKey,
      owner: mintAuthority.publicKey,
      amount: 100000,
      decimals: 5,
      mint: mint.publicKey,
    );

    expect(
      sendMessage(Message.only(instruction), [mintAuthority]),
      completes,
    );
  });

  test('Approve', () {
    final instruction = TokenInstruction.approve(
      amount: 1000000,
      source: tokensHolder.publicKey,
      delegate: randomRecipient.publicKey,
      sourceOwner: mintAuthority.publicKey,
    );

    expect(
      sendMessage(Message.only(instruction), [mintAuthority]),
      completes,
    );
  });

  test('Revoke', () {
    final instruction = TokenInstruction.revoke(
      source: tokensHolder.publicKey,
      sourceOwner: mintAuthority.publicKey,
    );

    expect(
      sendMessage(Message.only(instruction), [mintAuthority]),
      completes,
    );
  });

  test('Approve Checked', () {
    final instruction = TokenInstruction.approveChecked(
      amount: 1000000,
      decimals: 5,
      source: tokensHolder.publicKey,
      delegate: randomRecipient.publicKey,
      sourceOwner: mintAuthority.publicKey,
      mint: mint.publicKey,
    );

    expect(
      sendMessage(Message.only(instruction), [mintAuthority]),
      completes,
    );
  });

  test('Burn', () {
    final instruction = TokenInstruction.burn(
      amount: 100000,
      accountToBurnFrom: tokensHolder.publicKey,
      mint: mint.publicKey,
      owner: mintAuthority.publicKey,
    );

    expect(
      sendMessage(Message.only(instruction), [mintAuthority]),
      completes,
    );
  });

  test('Burn Checked', () {
    final instruction = TokenInstruction.burnChecked(
      amount: 100000,
      accountToBurnFrom: tokensHolder.publicKey,
      mint: mint.publicKey,
      owner: mintAuthority.publicKey,
      decimals: 5,
    );

    expect(
      sendMessage(Message.only(instruction), [mintAuthority]),
      completes,
    );
  });

  test('Freeze Account', () {
    final instruction = TokenInstruction.freezeAccount(
      account: tokensHolder.publicKey,
      mint: mint.publicKey,
      freezeAuthority: freezeAuthority.publicKey,
    );

    expect(
      sendMessage(Message.only(instruction), [mintAuthority, freezeAuthority]),
      completes,
    );
  });

  test('Thaw Account', () {
    final instruction = TokenInstruction.thawAccount(
      account: tokensHolder.publicKey,
      mint: mint.publicKey,
      freezeAuthority: freezeAuthority.publicKey,
    );

    expect(
      sendMessage(Message.only(instruction), [mintAuthority, freezeAuthority]),
      completes,
    );
  });

  test('Set Authority', () async {
    final instruction = TokenInstruction.setAuthority(
      mintOrAccount: mint.publicKey,
      authorityType: AuthorityType.mintTokens,
      currentAuthority: mintAuthority.publicKey,
      newAuthority: newAuthority.publicKey,
    );

    await sendMessage(Message.only(instruction), [mintAuthority]);

    final accountInfo = await client.rpcClient
        .getAccountInfo(
          mint.publicKey.toBase58(),
          commitment: Commitment.confirmed,
          encoding: Encoding.jsonParsed,
        )
        .value;

    expect(accountInfo?.data, _hasMintAuthority(newAuthority.address));
  });

  test('Set Authority having no new authority', () async {
    final instruction = TokenInstruction.setAuthority(
      mintOrAccount: mint.publicKey,
      authorityType: AuthorityType.mintTokens,
      currentAuthority: newAuthority.publicKey,
    );

    await sendMessage(Message.only(instruction), [newAuthority]);

    final accountInfo = await client.rpcClient
        .getAccountInfo(
          mint.publicKey.toBase58(),
          commitment: Commitment.confirmed,
          encoding: Encoding.jsonParsed,
        )
        .value;

    expect(accountInfo?.data, _hasMintAuthority(null));
  });
}

Matcher _hasMintAuthority(String? address) =>
    isA<ParsedSplTokenProgramAccountData>().having(
      (it) => it.parsed,
      'parsed',
      isA<MintAccountData>().having(
        (it) => it.info.mintAuthority,
        'mintAuthority',
        address,
      ),
    );
