import 'dart:io';

import 'package:solana/solana.dart';
import 'package:solana/src/signer.dart';
import 'package:solana/src/spl_token/associated_account.dart';
import 'package:solana/src/spl_token/spl_token.dart';
import 'package:solana/src/types/token_supply.dart';
import 'package:test/test.dart';

import 'airdrop.dart';

void main() {
  final devnetRpcUrl =
      Platform.environment['DEVNET_RPC_URL'] ?? 'http://127.0.0.1:8899';

  group('Test spl tokens', () {
    final RPCClient client = RPCClient(devnetRpcUrl);
    late final String newTokenMint;
    late final Signer owner;

    setUpAll(() async {
      owner = await Signer.random(); // fromMnemonic(mnemonic);
      await airdrop(client, owner, sol: 100);
    });

    test('Can create a new mint', () async {
      final token = await client.newToken(
        owner: owner,
        decimals: 2,
      );

      expect(token.supply, equals(0));
      expect(token.decimals, equals(2));

      newTokenMint = token.mint;
    });

    test('Can create an associated token account', () async {
      final token = await SPLToken.withOwner(
        owner: owner,
        mint: newTokenMint,
        client: client,
      );
      List<AssociatedAccount> accounts =
          await token.getAssociatedAccountFor(owner: owner.address);
      expect(accounts, isNot(null));
      expect(accounts.length, equals(0));

      final address = await token.createAssociatedAccount(
        owner: owner.address,
        funder: owner,
      );

      accounts = await token.getAssociatedAccountFor(owner: owner.address);
      expect(accounts, isNot(null));
      expect(accounts.length, equals(1));
      expect(accounts.where((a) => a.address == address), isNot(null));
    });

    test('Can mint the newly created token and account', () async {
      var token = await SPLToken.withOwner(
        owner: owner,
        mint: newTokenMint,
        client: client,
      );
      final accounts =
          await token.getAssociatedAccountFor(owner: owner.address);
      await token.mintTo(
          destination: accounts[0].address, amount: _totalSupply);
      // Reload it
      token = await SPLToken.withOwner(
        owner: owner,
        mint: newTokenMint,
        client: client,
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

    test('Can transfer tokens', () async {
      final recipient = await Signer.random();
      final token = await SPLToken.withOwner(
        owner: owner,
        mint: newTokenMint,
        client: client,
      );
      final myAssociatedAccounts = await token.getAssociatedAccountFor(
        owner: owner.address,
      );
      var associatedAccounts =
          await token.getAssociatedAccountFor(owner: recipient.address);
      expect(associatedAccounts.length, equals(0));
      // The account does not exist, so create it
      final recipientAddress = await token.createAssociatedAccount(
        owner: recipient.address,
        funder: owner,
      );
      associatedAccounts =
          await token.getAssociatedAccountFor(owner: recipient.address);
      expect(associatedAccounts.length, equals(1));
      expect(associatedAccounts[0].address, equals(recipientAddress));
      // Send to the newly created account
      final signature = await token.transfer(
        source: myAssociatedAccounts[0].address,
        destination: recipient.address,
        amount: 100,
        owner: owner,
      );

      expect(signature, isNot(null));
    }, timeout: const Timeout(Duration(minutes: 2)));
  });
}

const _totalSupply = 1000000000000;
