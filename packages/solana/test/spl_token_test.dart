import 'package:solana/src/constants.dart';
import 'package:solana/src/crypto/ed25519_hd_keypair.dart';
import 'package:solana/src/encoder/instruction.dart';
import 'package:solana/src/encoder/message.dart';
import 'package:solana/src/exceptions/no_associated_token_account_exception.dart';
import 'package:solana/src/memo_program/memo_instruction.dart';
import 'package:solana/src/rpc/client.dart';
import 'package:solana/src/rpc/dto/confirmation_status.dart';
import 'package:solana/src/rpc/dto/encoding.dart';
import 'package:solana/src/rpc/dto/program_account.dart';
import 'package:solana/src/rpc/dto/token_accounts_filter.dart';
import 'package:solana/src/rpc/dto/token_amount.dart';
import 'package:solana/src/spl_token/spl_token.dart';
import 'package:solana/src/subscription_client/subscription_client.dart';
import 'package:solana/src/system_program/system_instruction.dart';
import 'package:solana/src/token_program/token_program.dart';
import 'package:test/test.dart';

import 'airdrop.dart';
import 'config.dart';

void main() {
  group('Test spl tokens', () {
    final RpcClient rpcClient = RpcClient(devnetRpcUrl);
    late final SubscriptionClient subscriptionClient;
    late final String newTokenMint;
    late final Ed25519HDKeyPair owner;

    setUpAll(() async {
      subscriptionClient = await SubscriptionClient.connect(devnetWebsocketUrl);
      owner = await Ed25519HDKeyPair.random();
      await airdrop(rpcClient, subscriptionClient, owner, sol: 100);
    });

    test('Create a new mint', () async {
      final token = await rpcClient.initializeMint(
        owner: owner,
        subscriptionClient: subscriptionClient,
        decimals: 2,
      );

      expect(token.supply, equals(BigInt.zero));
      expect(token.decimals, equals(2));

      newTokenMint = token.mint;
    });

    test('Create an account with', () async {
      final creator = await Ed25519HDKeyPair.random();
      final account = await Ed25519HDKeyPair.random();
      await airdrop(rpcClient, subscriptionClient, creator, sol: 100);
      final token = await SplToken.readonly(
        mint: newTokenMint,
        rpcClient: rpcClient,
        subscriptionClient: subscriptionClient,
      );
      await token.createAccount(
        account: account,
        creator: creator,
      );
    }, timeout: const Timeout(Duration(minutes: 2)));

    test('Create an associated token account', () async {
      final token = await SplToken.readWrite(
        owner: owner,
        mint: newTokenMint,
        rpcClient: rpcClient,
        subscriptionClient: subscriptionClient,
      );
      List<ProgramAccount> accounts = await rpcClient.getTokenAccountsByOwner(
        owner.address,
        TokenAccountsFilter.byMint(token.mint),
      );
      expect(accounts, isNot(null));
      expect(accounts.length, equals(0));

      final newAccount = await token.createAssociatedAccount(
        owner: owner.address,
        funder: owner,
      );

      accounts = await rpcClient.getTokenAccountsByOwner(
        owner.address,
        TokenAccountsFilter.byMint(token.mint),
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
      var token = await SplToken.readWrite(
        owner: owner,
        mint: newTokenMint,
        rpcClient: rpcClient,
        subscriptionClient: subscriptionClient,
      );
      final accounts = await rpcClient.getTokenAccountsByOwner(
        owner.address,
        TokenAccountsFilter.byMint(token.mint),
        encoding: Encoding.jsonParsed,
      );
      await token.mintTo(
        destination: accounts.first.pubkey,
        amount: _totalSupply,
      );
      // Reload it
      token = await SplToken.readWrite(
        owner: owner,
        mint: newTokenMint,
        rpcClient: rpcClient,
        subscriptionClient: subscriptionClient,
      );

      expect(token.supply, equals(BigInt.from(_totalSupply)));
      expect(token.decimals, equals(2));
    });

    test('Get spl_token supply', () async {
      final TokenAmount tokenSupply = await rpcClient.getTokenSupply(
        newTokenMint,
      );

      expect(int.parse(tokenSupply.amount), equals(_totalSupply));
    });

    test('Transfer tokens succeeds when associated accounts exist', () async {
      final recipient = await Ed25519HDKeyPair.random();
      final token = await SplToken.readWrite(
        owner: owner,
        mint: newTokenMint,
        rpcClient: rpcClient,
        subscriptionClient: subscriptionClient,
      );
      // The account does not exist, so create it
      final account = await token.createAssociatedAccount(
        owner: recipient.address,
        funder: owner,
      );
      expect(account, isA<ProgramAccount>());
      // Send to the newly created account
      final signature = await token.transfer(
        source: owner.address,
        destination: recipient.address,
        amount: 100,
        owner: owner,
      );

      expect(signature, isNot(null));
    }, timeout: const Timeout(Duration(minutes: 2)));

    test('Transfer tokens succeeds with fee payer', () async {
      final recipient = await Ed25519HDKeyPair.random();
      final token = await SplToken.readWrite(
        owner: owner,
        mint: newTokenMint,
        rpcClient: rpcClient,
        subscriptionClient: subscriptionClient,
      );
      final feePayer = await Ed25519HDKeyPair.random();
      // Add some tokens to pay for fees
      await airdrop(rpcClient, subscriptionClient, feePayer, sol: 10);

      // The account does not exist, so create it
      final account = await token.createAssociatedAccount(
        owner: recipient.address,
        funder: owner,
      );
      // A sender must have the appropriate associated account, in case they
      // don't it's an error and we should throw an exception.
      final sourceAssociatedTokenAddress =
          await token.getAssociatedAccount(owner.address);
      // A recipient needs an associated account as well
      final destinationAssociatedTokenAddress =
          await token.getAssociatedAccount(recipient.address);
      expect(sourceAssociatedTokenAddress, isNotNull);
      expect(destinationAssociatedTokenAddress, isNotNull);

      expect(account, isA<ProgramAccount>());
      // Send to the newly created account
      final message = TokenProgram.transfer(
        source: sourceAssociatedTokenAddress!.pubkey,
        destination: destinationAssociatedTokenAddress!.pubkey,
        amount: 100,
        owner: owner.address,
      );

      final signature = await rpcClient.signAndSendTransaction(
        message,
        [
          feePayer,
          owner,
        ],
      );
      await subscriptionClient.waitForSignatureStatus(
        signature,
        status: ConfirmationStatus.finalized,
      );

      expect(signature, isNot(null));
    }, timeout: const Timeout(Duration(minutes: 2)));

    test(
        'Fails to transfer tokens if the recipient has no associated token account',
        () async {
      final recipient = await Ed25519HDKeyPair.random();
      final token = await SplToken.readWrite(
        owner: owner,
        mint: newTokenMint,
        rpcClient: rpcClient,
        subscriptionClient: subscriptionClient,
      );
      // Send to the newly created account
      expect(
        token.transfer(
          source: owner.address,
          destination: recipient.address,
          amount: 100,
          owner: owner,
        ),
        throwsA(isA<NoAssociatedTokenAccountException>()),
      );
    });

    test(
        'Fails to transfer tokens if the sender has no associated token account',
        () async {
      final sender = await Ed25519HDKeyPair.random();
      final token = await SplToken.readWrite(
        owner: owner,
        mint: newTokenMint,
        rpcClient: rpcClient,
        subscriptionClient: subscriptionClient,
      );
      // Send to the newly created account
      expect(
        token.transfer(
          source: sender.address,
          destination: owner.address,
          amount: 100,
          owner: owner,
        ),
        throwsA(isA<NoAssociatedTokenAccountException>()),
      );
    });

    test('Send transfer instruction in an existing transaction', () async {
      final destination = await Ed25519HDKeyPair.random();
      final token = await SplToken.readonly(
        mint: newTokenMint,
        rpcClient: rpcClient,
        subscriptionClient: subscriptionClient,
      );
      final associatedSourceAddress =
          await token.computeAssociatedAddress(owner: owner.address);
      final destinationAccount = await token.createAccount(
        account: destination,
        creator: owner,
      );

      final instructions = <Instruction>[
        SystemInstruction.transfer(
          source: owner.address,
          destination: destination.address,
          lamports: lamportsPerSol,
        ),
        TokenInstruction.transfer(
          source: associatedSourceAddress,
          destination: destinationAccount.owner,
          owner: owner.address,
          amount: 10,
        ),
        MemoInstruction(
          memo: 'Nice, it works with many more instructions too',
          signers: [owner.address],
        ),
      ];
      final message = Message(instructions: instructions);

      final signature =
          await rpcClient.signAndSendTransaction(message, [owner]);
      await subscriptionClient.waitForSignatureStatus(
        signature,
        status: ConfirmationStatus.finalized,
      );
    }, timeout: const Timeout(Duration(minutes: 2)));
  });
}

const _totalSupply = 1000000000000;
