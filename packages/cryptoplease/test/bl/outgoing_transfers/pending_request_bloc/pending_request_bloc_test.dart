import 'package:cryptoplease/bl/outgoing_transfers/pending_request_bloc/pending_request_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:solana/solana.dart';
import 'package:solana/solana_pay.dart';

Future<void> main() async {
  final randomAddress = (await Ed25519HDKeyPair.random()).publicKey.toBase58();

  final validLinks = [
    'https://sol.cryptoplease.link/$randomAddress',
    'https://solana.cryptoplease.link/$randomAddress',
    'solana:$randomAddress',
  ].map(Uri.parse);

  final invalidLinks = [
    'https://solana.cryptoplease.link/?key=$randomAddress',
    'https://sol.cryptoplease.link?key=$randomAddress',
  ].map(Uri.parse);

  for (final link in validLinks) {
    test('Valid link: $link', () async {
      expect(
        tryParseDeepLink(link),
        isA<SolanaPayRequest>().having(
          (r) => r.recipient,
          'recipient',
          Ed25519HDPublicKey.fromBase58(randomAddress),
        ),
      );
    });
  }

  for (final link in invalidLinks) {
    test('Invalid link: $link', () async {
      expect(tryParseDeepLink(link), isNull);
    });
  }
}
