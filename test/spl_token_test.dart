import 'dart:io';

import 'package:solana/solana.dart';
import 'package:solana/src/hd_keypair.dart';
import 'package:solana/src/spl_token/associated_account.dart';
import 'package:solana/src/spl_token/spl_token.dart';
import 'package:solana/src/spl_token/token_supply.dart';
import 'package:test/test.dart';

import 'airdrop.dart';

void main() {
  final devnetRpcUrl =
      Platform.environment['DEVNET_RPC_URL'] ?? 'http://127.0.0.1:8899';

  group('Test spl tokens', () {
    final RPCClient client = RPCClient(devnetRpcUrl);
    late final String newTokenMint;
    late final HDKeyPair owner;

    setUpAll(() async {
      owner = await HDKeyPair.random();
      await airdrop(client, owner, sol: 100);
    });

    test('Can create a new mint', () async {
      final token = await client.initializeMint(
        owner: owner,
        decimals: 2,
      );

      expect(token.supply, equals(0));
      expect(token.decimals, equals(2));

      newTokenMint = token.mint;
    });

    test('Can create an account with', () async {
      final creator = await HDKeyPair.random();
      final account = await HDKeyPair.random();
      await airdrop(client, creator, sol: 100);
      final token = await SplToken.readonly(
        mint: newTokenMint,
        rpcClient: client,
      );
      await token.createAccount(
        account: account,
        creator: creator,
      );
    }, timeout: const Timeout(Duration(minutes: 2)));

    test('Can create an associated token account', () async {
      final token = await SplToken.readWrite(
        owner: owner,
        mint: newTokenMint,
        rpcClient: client,
      );
      List<AssociatedTokenAccount> accounts =
          await token.getAssociatedAccountsFor(owner: owner.address);
      expect(accounts, isNot(null));
      expect(accounts.length, equals(0));

      final newAccount = await token.createAssociatedAccount(
        owner: owner.address,
        funder: owner,
      );

      accounts = await token.getAssociatedAccountsFor(owner: owner.address);
      expect(accounts, isNot(null));
      expect(accounts.length, equals(1));
      expect(
        accounts.where((a) => a.address == newAccount.address),
        isNot(null),
      );
    });

    test('Can mint the newly created token and account', () async {
      var token = await SplToken.readWrite(
        owner: owner,
        mint: newTokenMint,
        rpcClient: client,
      );
      final accounts =
          await token.getAssociatedAccountsFor(owner: owner.address);
      await token.mintTo(
          destination: accounts[0].address, amount: _totalSupply);
      // Reload it
      token = await SplToken.readWrite(
        owner: owner,
        mint: newTokenMint,
        rpcClient: client,
      );

      expect(token.supply, equals(_totalSupply));
      expect(token.decimals, equals(2));
    });

    test('Can get spl_token supply', () async {
      final TokenSupplyResult supplyResult = await client.getTokenSupply(
        newTokenMint,
      );
      final TokenSupply tokenSupply = supplyResult.value;

      expect(int.parse(tokenSupply.amount), equals(_totalSupply));
    });

    test('Can transfer tokens succeeds when associated accounts exist',
        () async {
      final recipient = await HDKeyPair.random();
      final token = await SplToken.readWrite(
        owner: owner,
        mint: newTokenMint,
        rpcClient: client,
      );
      final associatedAddress =
          await token.getAssociatedTokenAddress(owner: recipient.address);
      expect(associatedAddress, isA<String>());
      // The account does not exist, so create it
      final recipientAddress = await token.createAssociatedAccount(
        owner: recipient.address,
        funder: owner,
      );
      expect(recipientAddress, isA<AssociatedTokenAccount>());
      // Send to the newly created account
      final signature = await token.transfer(
        source: owner.address,
        destination: recipient.address,
        amount: 100,
        owner: owner,
      );

      expect(signature, isNot(null));
    }, timeout: const Timeout(Duration(minutes: 2)));

    test(
        'Fails to transfer tokens if the recipient has no associated token account',
        () async {
      final recipient = await HDKeyPair.random();
      final token = await SplToken.readWrite(
        owner: owner,
        mint: newTokenMint,
        rpcClient: client,
      );
      // Send to the newly created account
      expect(
        token.transfer(
          source: owner.address,
          destination: recipient.address,
          amount: 100,
          owner: owner,
        ),
        throwsFormatException,
      );
    });

    test(
        'Fails to transfer tokens if the sender has no associated token account',
        () async {
      final sender = await HDKeyPair.random();
      final token = await SplToken.readWrite(
        owner: owner,
        mint: newTokenMint,
        rpcClient: client,
      );
      // Send to the newly created account
      expect(
        token.transfer(
          source: sender.address,
          destination: owner.address,
          amount: 100,
          owner: owner,
        ),
        throwsFormatException,
      );
    });
  });
}

const _totalSupply = 1000000000000;
