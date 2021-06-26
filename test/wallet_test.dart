import 'dart:io';

import 'package:solana/solana.dart';
import 'package:solana/src/exceptions/exceptions.dart';
import 'package:solana/src/hd_keypair.dart';
import 'package:solana/src/spl_token/spl_token.dart';
import 'package:solana/src/wallet.dart';
import 'package:test/test.dart';

final _devnetRpcUrl =
    Platform.environment['DEVNET_RPC_URL'] ?? 'http://127.0.0.1:8899';

void main() {
  late final RPCClient rpcClient;
  late final Wallet source;
  late final Wallet destination;
  late SplToken token;

  setUpAll(() async {
    final signer = await HDKeyPair.random();
    rpcClient = RPCClient(_devnetRpcUrl);
    source = Wallet(signer: signer, rpcClient: rpcClient);
    destination =
        Wallet(signer: await HDKeyPair.random(), rpcClient: rpcClient);
    // Add tokens to the sender
    await source.requestAirdrop(100 * lamportsPerSol);
    token = await rpcClient.initializeMint(
      owner: signer,
      decimals: 2,
    );
  });

  test('Get wallet lamports', () async {
    expect(await source.getLamports(), greaterThan(0));
  });

  test('Transfer SOL', () async {
    final signature = await source.transfer(
      destination: destination.address,
      lamports: lamportsPerSol,
    );
    expect(signature, isNotNull);
    expect(await destination.getLamports(), equals(lamportsPerSol));
  });

  test('Transfer SOL with memo', () async {
    const memoText = 'Memo test string...';

    final signature = await source.transferWithMemo(
      destination: destination.address,
      lamports: 1000,
      memo: memoText,
    );
    expect(signature, isNotNull);

    final result =
        await rpcClient.getConfirmedTransaction(signature.toString());
    expect(result, isNotNull);
    expect(result?.transaction, isNotNull);
    final transaction = result!.transaction;
    expect(transaction.message, isNotNull);
    final txMessage = transaction.message!;
    expect(txMessage.instructions, isNotNull);
    final instructions = txMessage.instructions;
    expect(instructions.length, equals(2));
    expect(instructions[0], const TypeMatcher<TxSystemInstruction>());
    expect(instructions[1], const TypeMatcher<TxMemoInstruction>());
    final memoInstruction = instructions[1] as TxMemoInstruction;
    expect(memoInstruction.memo, equals(memoText));
  });

  test('Throws exception when token is not loaded', () {
    expect(
      () => source.getTokenBalance(mint: token.mint),
      throwsA(isA<BadStateException>()),
    );
  });

  test('Load a token into a wallet', () async {
    final wallet = Wallet(
      signer: await HDKeyPair.random(),
      rpcClient: rpcClient,
    );
    await wallet.addSplToken(mint: token.mint);
    expect(wallet.hasAssociatedTokenAccount(mint: token.mint), equals(false));
  });

  test('Get a token balance', () async {
    await source.addSplToken(mint: token.mint);
    expect(source.hasAssociatedTokenAccount(mint: token.mint), equals(false));

    await source.createAssociatedTokenAccount(mint: token.mint);

    var tokenBalance = await source.getTokenBalance(mint: token.mint);
    expect(tokenBalance.decimals, equals(token.decimals));
    expect(tokenBalance.amount, equals('0'));
    final associatedAccount =
        source.getAssociatedTokenAccountAddress(mint: token.mint);
    // Add some tokens
    await token.mintTo(destination: associatedAccount, amount: 1000);

    tokenBalance = await source.getTokenBalance(mint: token.mint);
    expect(tokenBalance.decimals, equals(token.decimals));
    expect(tokenBalance.amount, equals('1000'));
  }, timeout: const Timeout(Duration(minutes: 2)));

  test('Fails SPL transfer if recipient has no associated token account',
      () async {
    final wallet = Wallet(
      signer: await HDKeyPair.random(),
      rpcClient: rpcClient,
    );
    await wallet.addSplToken(mint: token.mint);
    expect(
      source.transferSplToken(
        destination: wallet.address,
        amount: 100,
        mint: token.mint,
      ),
      throwsA(isA<NoAssociatedTokenAccountException>()),
    );
  });

  test('Transfer SPL successfully', () async {
    await destination.addSplToken(mint: token.mint);
    await destination.createAssociatedTokenAccount(mint: token.mint);
    final signature = await source.transferSplToken(
      destination: destination.address,
      amount: 100,
      mint: token.mint,
    );
    expect(signature, isNotNull);

    final tokenBalance = await destination.getTokenBalance(mint: token.mint);
    expect(tokenBalance.amount, equals('100'));
  }, timeout: const Timeout(Duration(minutes: 2)));
}
