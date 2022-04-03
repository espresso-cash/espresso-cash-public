// ignore_for_file: prefer-first

import 'package:solana/dto.dart';
import 'package:solana/solana.dart';
import 'package:test/test.dart';

import 'config.dart';

void main() {
  late final SolanaClient solanaClient;
  late final Wallet source;
  late final Wallet destination;
  late Mint token;

  setUpAll(() async {
    source = await Ed25519HDKeyPair.random();
    solanaClient = createTestSolanaClient();
    destination = await Ed25519HDKeyPair.random();
    // Add tokens to the sender
    await solanaClient.requestAirdrop(
      lamports: 100 * lamportsPerSol,
      address: source.publicKey,
    );
    token = await solanaClient.initializeMint(
      mintAuthority: source,
      decimals: 2,
    );
    final associatedAccount = await solanaClient.createAssociatedTokenAccount(
      mint: token.address,
      funder: source,
    );
    await solanaClient.mintTo(
      destination: Ed25519HDPublicKey.fromBase58(associatedAccount.pubkey),
      amount: _tokenMintAmount,
      mint: token.address,
      authority: source,
    );
  });

  test('Get wallet lamports', () async {
    expect(
      await solanaClient.rpcClient.getBalance(source.address),
      greaterThan(0),
    );
  });

  test('Transfer SOL', () async {
    final signature = await solanaClient.transferLamports(
      destination: destination.publicKey,
      lamports: lamportsPerSol,
      source: source,
    );
    expect(signature, isNotNull);
    expect(
      await solanaClient.rpcClient.getBalance(destination.address),
      equals(lamportsPerSol),
    );
  });

  test('Transfer SOL with memo', () async {
    const memoText = 'Memo test string...';

    final signature = await solanaClient.transferLamports(
      destination: destination.publicKey,
      lamports: _lamportsTransferAmount,
      memo: memoText,
      source: source,
    );
    expect(signature, isNotNull);

    // FIXME: check that it actual is this type
    final result = await solanaClient.rpcClient.getTransaction(
      signature.toString(),
      encoding: Encoding.jsonParsed,
    );

    expect(result, isNotNull);
    expect(result?.transaction, isNotNull);
    final transaction = result!.transaction;
    expect(transaction.message, isNotNull);
    final txMessage = transaction.message;
    expect(txMessage.instructions, isNotNull);
    final instructions = txMessage.instructions;
    expect(instructions.length, equals(2));
    expect(instructions.first, const TypeMatcher<ParsedInstructionSystem>());
    final parsedInstructionSystem =
        instructions.first as ParsedInstructionSystem;
    expect(
      parsedInstructionSystem.parsed,
      isA<ParsedSystemTransferInstruction>(),
    );
    final parsedTransferInstruction =
        parsedInstructionSystem.parsed as ParsedSystemTransferInstruction;
    expect(
      parsedTransferInstruction.info.lamports,
      equals(_lamportsTransferAmount),
    );
    expect(instructions[1], const TypeMatcher<ParsedInstructionMemo>());
    final memoInstruction = instructions[1] as ParsedInstructionMemo;
    expect(memoInstruction.memo, equals(memoText));
  });

  test(
    'Get a token balance',
    () async {
      final wallet = await Ed25519HDKeyPair.random();
      expect(
        solanaClient.hasAssociatedTokenAccount(
          mint: token.address,
          owner: wallet.publicKey,
        ),
        completion(equals(false)),
      );

      final signature = await solanaClient.requestAirdrop(
        lamports: lamportsPerSol,
        commitment: Commitment.finalized,
        address: wallet.publicKey,
      );
      expect(signature, isNotNull);
      expect(
        await solanaClient.rpcClient.getBalance(wallet.address),
        equals(lamportsPerSol),
      );

      await solanaClient.createAssociatedTokenAccount(
        mint: token.address,
        funder: wallet,
      );
      final hasAssociatedTokenAccount =
          await solanaClient.hasAssociatedTokenAccount(
        mint: token.address,
        owner: wallet.publicKey,
      );

      expect(hasAssociatedTokenAccount, equals(true));

      final tokenBalance = await solanaClient.getTokenBalance(
        mint: token.address,
        owner: wallet.publicKey,
      );
      expect(tokenBalance.decimals, equals(token.decimals));
      expect(tokenBalance.amount, equals('0'));
    },
    timeout: const Timeout(Duration(minutes: 2)),
  );

  test(
    'Fails SPL transfer if recipient has no associated token account',
    () async {
      final wallet = await Ed25519HDKeyPair.random();
      expect(
        solanaClient.transferSplToken(
          destination: wallet.publicKey,
          amount: 100,
          mint: token.address,
          owner: source,
        ),
        throwsA(isA<NoAssociatedTokenAccountException>()),
      );
    },
  );

  test(
    'Transfer SPL tokens successfully',
    () async {
      final wallet = await Ed25519HDKeyPair.random();
      await solanaClient.createAssociatedTokenAccount(
        mint: token.address,
        funder: source,
        owner: wallet.publicKey,
      );
      final signature = await solanaClient.transferSplToken(
        destination: wallet.publicKey,
        amount: 40,
        mint: token.address,
        owner: source,
      );
      expect(signature, isNotNull);

      final tokenBalance = await solanaClient.getTokenBalance(
        mint: token.address,
        owner: wallet.publicKey,
      );
      expect(tokenBalance.amount, equals('40'));
    },
    timeout: const Timeout(Duration(minutes: 2)),
  );

  test(
    'Transfer SPL tokens with memo',
    () async {
      final wallet = await Ed25519HDKeyPair.random();
      // Create the associated account for the recipient
      await solanaClient.createAssociatedTokenAccount(
        mint: token.address,
        funder: source,
        owner: wallet.publicKey,
      );
      const memoText = 'Memo test string...';

      final signature = await solanaClient.transferSplToken(
        mint: token.address,
        destination: wallet.publicKey,
        amount: 40,
        memo: memoText,
        owner: source,
      );
      expect(signature, isNotNull);

      // FIXME: check that this is of the correct type
      final result = await solanaClient.rpcClient.getTransaction(
        signature.toString(),
        encoding: Encoding.jsonParsed,
      );

      expect(result, isNotNull);
      expect(result?.transaction, isNotNull);
      final transaction = result!.transaction;
      expect(transaction.message, isNotNull);
      final txMessage = transaction.message;
      expect(txMessage.instructions, isNotNull);
      final instructions = txMessage.instructions;
      expect(instructions.length, equals(2));
      expect(instructions[0], const TypeMatcher<ParsedInstructionSplToken>());
      expect(instructions[1], const TypeMatcher<ParsedInstructionMemo>());
      final memoInstruction = instructions[1] as ParsedInstructionMemo;
      expect(memoInstruction.memo, equals(memoText));
      final splTokenInstruction = instructions[0] as ParsedInstructionSplToken;
      expect(
        splTokenInstruction.parsed,
        isA<ParsedSplTokenTransferInstruction>(),
      );
      final parsedSplTokenInstruction =
          splTokenInstruction.parsed as ParsedSplTokenTransferInstruction;
      expect(parsedSplTokenInstruction.type, equals('transfer'));
      expect(parsedSplTokenInstruction.info, isA<SplTokenTransferInfo>());
      expect(parsedSplTokenInstruction.info.amount, '40');
      final tokenBalance = await solanaClient.getTokenBalance(
        mint: token.address,
        owner: wallet.publicKey,
      );
      expect(tokenBalance.amount, equals('40'));
    },
    timeout: const Timeout(Duration(minutes: 2)),
  );
}

const _tokenMintAmount = 1000;
const _lamportsTransferAmount = 5 * lamportsPerSol;
