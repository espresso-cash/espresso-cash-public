import 'package:solana/dto.dart' hide Instruction;
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';
import 'package:test/test.dart';

import 'config.dart';

void main() {
  group('Initialize tokens:', () {
    late final Ed25519HDKeyPair owner;
    late final SolanaClient solanaClient;

    setUpAll(() async {
      solanaClient = createTestSolanaClient();
      owner = await Ed25519HDKeyPair.random();
      await solanaClient.requestAirdrop(
        lamports: lamportsPerSol,
        address: owner.publicKey,
      );
    });

    test('Creates a new mint without freeze authority', () async {
      final token = await solanaClient.initializeMint(
        owner: owner,
        decimals: 2,
      );

      expect(token.supply, BigInt.zero);
      expect(token.decimals, 2);
      expect(token.owner, owner);
    });

    test('Creates a new mint with freeze authority', () async {
      final freezeAuthority = await Ed25519HDKeyPair.random();

      final token = await solanaClient.initializeMint(
        owner: owner,
        freezeAuthority: freezeAuthority.publicKey,
        decimals: 2,
      );

      expect(token.supply, BigInt.zero);
      expect(token.decimals, 2);
      expect(token.owner, owner);
    });
  });

  group('SolanaClient for SPL tokens', () {
    late final SplToken newToken;
    late final Ed25519HDKeyPair owner;
    late final SolanaClient solanaClient;

    setUpAll(() async {
      solanaClient = createTestSolanaClient();
      owner = await Ed25519HDKeyPair.random();
      await solanaClient.requestAirdrop(
        lamports: 100 * lamportsPerSol,
        address: owner.publicKey,
      );
    });

    test('Create a new mint', () async {
      final token = await solanaClient.initializeMint(
        owner: owner,
        decimals: 2,
      );

      expect(token.supply, equals(BigInt.zero));
      expect(token.decimals, equals(2));

      newToken = token;
    });

    test(
      'Create an account with',
      () async {
        final creator = await Ed25519HDKeyPair.random();
        final account = await Ed25519HDKeyPair.random();
        await solanaClient.requestAirdrop(
          lamports: 100 * lamportsPerSol,
          address: creator.publicKey,
        );
        await solanaClient.createTokenAccount(
          account: account,
          creator: creator,
          mint: newToken.mint,
        );
      },
      timeout: const Timeout(Duration(minutes: 2)),
    );

    test('Create an associated token account', () async {
      var accounts = await solanaClient.rpcClient.getTokenAccountsByOwner(
        owner.address,
        TokenAccountsFilter.byMint(newToken.mint.toBase58()),
      );
      expect(accounts, isNot(null));
      expect(accounts.length, equals(0));

      final newAccount = await solanaClient.createAssociatedTokenAccount(
        funder: owner,
        mint: newToken.mint,
      );

      accounts = await solanaClient.rpcClient.getTokenAccountsByOwner(
        owner.address,
        TokenAccountsFilter.byMint(newToken.mint.toBase58()),
        encoding: Encoding.jsonParsed,
      );
      expect(accounts, isNot(null));
      expect(accounts.length, equals(1));
      expect(
        accounts.where((a) => a.pubkey == newAccount.pubkey),
        isNot(null),
      );
    });

    test('Mint the newly created token and account', () async {
      final accounts = await solanaClient.rpcClient.getTokenAccountsByOwner(
        owner.address,
        TokenAccountsFilter.byMint(newToken.mint.toBase58()),
        encoding: Encoding.jsonParsed,
      );
      await solanaClient.transferMint(
        destination: Ed25519HDPublicKey.fromBase58(accounts.first.pubkey),
        amount: _totalSupply,
        mint: newToken.mint,
        owner: owner,
      );

      final token = await solanaClient.createReadWriteToken(
        owner: owner,
        mint: newToken.mint,
      );

      expect(token.supply, equals(BigInt.from(_totalSupply)));
      expect(token.decimals, equals(2));
    });

    test('Get spl_token supply', () async {
      final TokenAmount tokenSupply =
          await solanaClient.rpcClient.getTokenSupply(newToken.mint.toBase58());

      expect(int.parse(tokenSupply.amount), equals(_totalSupply));
    });

    test(
      'Transfer tokens succeeds when associated accounts exist',
      () async {
        final recipient = await Ed25519HDKeyPair.random();
        // The account does not exist, so create it
        final account = await solanaClient.createAssociatedTokenAccount(
          owner: recipient.publicKey,
          funder: owner,
          mint: newToken.mint,
        );
        expect(account, isA<ProgramAccount>());
        // Send to the newly created account
        final signature = await solanaClient.transferSplToken(
          source: owner,
          destination: recipient.publicKey,
          amount: 100,
          mint: newToken.mint,
        );

        expect(signature, isNot(null));
      },
      timeout: const Timeout(Duration(minutes: 2)),
    );

    test(
      'Transfer tokens succeeds with fee payer',
      () async {
        final recipient = await Ed25519HDKeyPair.random();
        final feePayer = await Ed25519HDKeyPair.random();
        // Add some tokens to pay for fees
        await solanaClient.requestAirdrop(
          lamports: 100 * lamportsPerSol,
          address: feePayer.publicKey,
        );

        // The account does not exist, so create it
        final account = await solanaClient.createAssociatedTokenAccount(
          owner: recipient.publicKey,
          funder: owner,
          mint: newToken.mint,
        );
        // A sender must have the appropriate associated account, in case they
        // don't it's an error and we should throw an exception.
        final sourceAssociatedTokenAddress =
            await solanaClient.getAssociatedTokenAccount(
          mint: newToken.mint,
          owner: owner.publicKey,
        );
        // A recipient needs an associated account as well
        final destinationAssociatedTokenAddress =
            await solanaClient.getAssociatedTokenAccount(
          mint: newToken.mint,
          owner: recipient.publicKey,
        );
        expect(sourceAssociatedTokenAddress, isNotNull);
        expect(destinationAssociatedTokenAddress, isNotNull);

        expect(account, isA<ProgramAccount>());
        // Send to the newly created account
        final instruction = TokenInstruction.transfer(
            source: Ed25519HDPublicKey.fromBase58(
              sourceAssociatedTokenAddress!.pubkey,
            ),
            destination: Ed25519HDPublicKey.fromBase58(
              destinationAssociatedTokenAddress!.pubkey,
            ),
            amount: 100,
            owner: owner.publicKey);

        final signature = await solanaClient.rpcClient.signAndSendTransaction(
          Message.only(instruction),
          [feePayer, owner],
        );
        await solanaClient.waitForSignatureStatus(
          signature,
          status: ConfirmationStatus.finalized,
        );

        expect(signature, isNot(null));
      },
      timeout: const Timeout(Duration(minutes: 2)),
    );

    test(
        'Fails to transfer tokens if the recipient has no associated token account',
        () async {
      final recipient = await Ed25519HDKeyPair.random();
      // Send to the newly created account
      expect(
        solanaClient.transferSplToken(
          source: owner,
          destination: recipient.publicKey,
          amount: 100,
          mint: newToken.mint,
        ),
        throwsA(isA<NoAssociatedTokenAccountException>()),
      );
    });

    test(
      'Fails to transfer tokens if the sender has no associated token account',
      () async {
        final sender = await Ed25519HDKeyPair.random();
        // Send to the newly created account
        expect(
          solanaClient.transferSplToken(
            source: sender,
            destination: owner.publicKey,
            amount: 100,
            mint: newToken.mint,
          ),
          throwsA(isA<NoAssociatedTokenAccountException>()),
        );
      },
    );

    test(
      'Send transfer instruction in an existing transaction',
      () async {
        final destination = await Ed25519HDKeyPair.random();
        final token = await solanaClient.createReadonlyToken(
          mint: newToken.mint,
        );
        final associatedSourceAddress = await findAssociatedTokenAddress(
          owner: owner.publicKey,
          mint: newToken.mint,
        );
        final destinationAccount = await solanaClient.createTokenAccount(
          account: destination,
          creator: owner,
          mint: token.mint,
        );

        final instructions = <Instruction>[
          SystemInstruction.transfer(
            source: owner.publicKey,
            destination: destination.publicKey,
            lamports: lamportsPerSol,
          ),
          TokenInstruction.transfer(
            source: associatedSourceAddress,
            destination:
                Ed25519HDPublicKey.fromBase58(destinationAccount.owner),
            owner: owner.publicKey,
            amount: 10,
          ),
          MemoInstruction(
            memo: 'Nice, it works with many more instructions too',
            signers: [owner.publicKey],
          ),
        ];
        final message = Message(instructions: instructions);

        final signature = await solanaClient.rpcClient
            .signAndSendTransaction(message, [owner]);
        await solanaClient.waitForSignatureStatus(
          signature,
          status: ConfirmationStatus.finalized,
        );
      },
      timeout: const Timeout(Duration(minutes: 2)),
    );
  });
}

const _totalSupply = 1000000000000;
