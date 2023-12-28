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
      commitment: Commitment.confirmed,
    );
    token = await solanaClient.initializeMint(
      mintAuthority: source,
      decimals: 2,
      commitment: Commitment.confirmed,
    );
    final associatedAccount = await solanaClient.createAssociatedTokenAccount(
      mint: token.address,
      funder: source,
      commitment: Commitment.confirmed,
    );

    await solanaClient.mintTo(
      destination: Ed25519HDPublicKey.fromBase58(associatedAccount.pubkey),
      amount: _tokenMintAmount,
      mint: token.address,
      authority: source,
      commitment: Commitment.confirmed,
    );
  });

  group('SplTokenTransferCheckedInfo test', () {
    test('authority is not available', () {
      // TODO
    });

    test('authority is available', () async {
      final wallet = await Ed25519HDKeyPair.random();
      final programAccount = await solanaClient.createAssociatedTokenAccount(
        mint: token.address,
        funder: source,
        owner: wallet.publicKey,
        commitment: Commitment.confirmed,
      );
      final senderTokenAccounts =
          await solanaClient.rpcClient.getTokenAccountsByOwner(
        source.address,
        const TokenAccountsFilterByProgramId(TokenProgram.programId),
        encoding: Encoding.jsonParsed,
        commitment: Commitment.confirmed,
      );

      await solanaClient.sendAndConfirmTransaction(
        message: Message.only(
          TokenInstruction.transferChecked(
            amount: 10,
            decimals: 2,
            source:
                Ed25519HDPublicKey.fromBase58(senderTokenAccounts[0].pubkey),
            mint: token.address,
            destination: wallet.publicKey,
            owner: source.publicKey,
          ),
        ),
        signers: [source],
        commitment: Commitment.finalized,
      );
      final signature = await solanaClient.transferSplToken(
        mint: token.address,
        destination: wallet.publicKey,
        amount: 10,
        owner: source,
        commitment: Commitment.confirmed,
      );

      final result = await solanaClient.rpcClient.getTransaction(
        signature.toString(),
        encoding: Encoding.jsonParsed,
        commitment: Commitment.confirmed,
      );

      // ignore: avoid-non-null-assertion, cannot be null here
      final splTokenInstruction = result!.transaction.message.instructions[0]
          as ParsedInstructionSplToken;
      final parsedSplTokenInstruction = splTokenInstruction.parsed
          as ParsedSplTokenTransferCheckedInstruction;
      // TODO
    });
  });

  group('SplTokenTransferInfo test', () {
    test('authority is not available', () {
      // TODO
    });

    test('authority is available', () async {
      final wallet = await Ed25519HDKeyPair.random();
      final programAccount = await solanaClient.createAssociatedTokenAccount(
        mint: token.address,
        funder: source,
        owner: wallet.publicKey,
        commitment: Commitment.confirmed,
      );

      final signature = await solanaClient.transferSplToken(
        mint: token.address,
        destination: wallet.publicKey,
        amount: 10,
        owner: source,
        commitment: Commitment.confirmed,
      );

      final result = await solanaClient.rpcClient.getTransaction(
        signature.toString(),
        encoding: Encoding.jsonParsed,
        commitment: Commitment.confirmed,
      );

      // ignore: avoid-non-null-assertion, cannot be null here
      final splTokenInstruction = result!.transaction.message.instructions[0]
          as ParsedInstructionSplToken;
      final parsedSplTokenInstruction =
          splTokenInstruction.parsed as ParsedSplTokenTransferInstruction;
      final splTokenTransferInfo = parsedSplTokenInstruction.info;
      expect(splTokenTransferInfo.amount, '10');
      final senderTokenAccounts =
          await solanaClient.rpcClient.getTokenAccountsByOwner(
        source.address,
        const TokenAccountsFilterByProgramId(TokenProgram.programId),
        encoding: Encoding.jsonParsed,
        commitment: Commitment.confirmed,
      );
      expect(senderTokenAccounts[0].pubkey, splTokenTransferInfo.source);
      // Make sure that it's the same token
      expect(
        (senderTokenAccounts[0].account.data
                as ParsedSplTokenProgramAccountData)
            .parsed
            .mapOrNull(account: (tokenAccount) => tokenAccount.info.mint),
        token.address.toBase58(),
      );
      expect(splTokenTransferInfo.destination, programAccount.pubkey);
      expect(splTokenTransferInfo.authority, source.address);
      expect(splTokenTransferInfo.multisigAuthority, isNull);
      expect(splTokenTransferInfo.signers, isNull);
      expect(splTokenTransferInfo.singleAuthority, source.address);
    });
  });
}

const _tokenMintAmount = 1000;
const _lamportsTransferAmount = 5 * lamportsPerSol;
