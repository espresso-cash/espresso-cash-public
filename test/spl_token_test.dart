import 'dart:io';

import 'package:solana/solana.dart';
import 'package:solana/src/spl_token/spl_token.dart';
import 'package:solana/src/types/token_supply.dart';
import 'package:solana/src/wallet.dart';
import 'package:test/test.dart';

import 'airdrop.dart';

void dumpAddress(String key, String address) {}

const mnemonic =
    'april boy slush piano discover sell balance frequent enrich noble worry purchase';

const totalSupply = 1000000000000;

void main() {
  final devnetRpcUrl =
      Platform.environment['DEVNET_RPC_URL'] ?? 'http://127.0.0.1:8899';

  group('Test spl tokens', () {
    final SolanaClient client = SolanaClient(devnetRpcUrl);
    late final SolanaWallet owner;
    late final SolanaWallet account;
    late final String newTokenMint;
    late final String associatedTokenAccountAddress;

    setUpAll(() async {
      owner = await SolanaWallet.random();
      account = await SolanaWallet.random();
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

    test('Can create an account', () async {
      final token = await SPLToken.withOwner(
        owner: owner,
        mint: newTokenMint,
        client: client,
      );
      // Just expect it not to throw
      await token.createAccount(account);
    });

    test('Can create an associated token account', () async {
      final token = await SPLToken.withOwner(
        owner: owner,
        mint: newTokenMint,
        client: client,
      );
      associatedTokenAccountAddress = await token.createAssociatedAccount(
        systemAccountAddress: owner.address,
        funder: owner,
      );
    });

    test('Can mint the newly created token and account', () async {
      var token = await SPLToken.withOwner(
        owner: owner,
        mint: newTokenMint,
        client: client,
      );
      await token.mintTo(address: account.address, amount: totalSupply);
      // Reload it
      token = await SPLToken.withOwner(
        owner: owner,
        mint: newTokenMint,
        client: client,
      );

      expect(token.supply, equals(totalSupply));
      expect(token.decimals, equals(2));
    });

    test('Can get spl_token supply', () async {
      final TokenSupplyResult supplyResult = await client.getTokenSupply(
        newTokenMint,
      );
      final TokenSupply tokenSupply = supplyResult.value;

      expect(int.parse(tokenSupply.amount), equals(totalSupply));
    });

    test('Can transfer tokens', () async {
      final token = await SPLToken.withOwner(
        owner: owner,
        mint: newTokenMint,
        client: client,
      );
      final recipient = await SolanaWallet.random();
      await token.createAccount(recipient);
      final message = TokenMessage.transfer(
        source: account.address,
        destination: associatedTokenAccountAddress,
        owner: owner.address,
        amount: 100,
      );
      final signature = await client.signAndSendTransaction(
        message,
        [
          owner,
        ],
      );
      expect(signature, isNot(null));
    }, timeout: const Timeout(Duration(minutes: 2)));
  });
}
