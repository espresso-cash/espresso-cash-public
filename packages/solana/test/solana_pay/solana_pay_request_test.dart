import 'package:decimal/decimal.dart';
import 'package:solana/solana.dart';
import 'package:solana/solana_pay.dart';
import 'package:test/test.dart';

void main() {
  final validLinks = <String, SolanaPayRequest>{
    'solana:mvines9iiHiQTysrwkJjGf2gb9Ex9jXJX8ns3qwf2kN?amount=1&label=Michael&message=Thanks%20for%20all%20the%20fish&memo=OrderId1234':
        SolanaPayRequest(
      recipient: Ed25519HDPublicKey.fromBase58(
        'mvines9iiHiQTysrwkJjGf2gb9Ex9jXJX8ns3qwf2kN',
      ),
      amount: Decimal.parse('1'),
      label: 'Michael',
      message: 'Thanks for all the fish',
      memo: 'OrderId1234',
    ),
    'solana:mvines9iiHiQTysrwkJjGf2gb9Ex9jXJX8ns3qwf2kN?amount=0.01&spl-token=EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v&label=Michael&message=Thanks%20for%20all%20the%20fish&memo=OrderId5678':
        SolanaPayRequest(
      recipient: Ed25519HDPublicKey.fromBase58(
        'mvines9iiHiQTysrwkJjGf2gb9Ex9jXJX8ns3qwf2kN',
      ),
      amount: Decimal.parse('0.01'),
      splToken: Ed25519HDPublicKey.fromBase58(
        'EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v',
      ),
      label: 'Michael',
      message: 'Thanks for all the fish',
      memo: 'OrderId5678',
    ),
    'solana:mvines9iiHiQTysrwkJjGf2gb9Ex9jXJX8ns3qwf2kN?label=Michael&memo=4321ABCD':
        SolanaPayRequest(
      recipient: Ed25519HDPublicKey.fromBase58(
        'mvines9iiHiQTysrwkJjGf2gb9Ex9jXJX8ns3qwf2kN',
      ),
      label: 'Michael',
      memo: '4321ABCD',
    ),
  };

  for (final link in validLinks.entries) {
    test('Valid link: ${link.key}', () {
      final request = SolanaPayRequest.parse(link.key);
      expect(request, link.value);
    });

    test('Builds link: ${link.key}', () {
      final url = link.value.toUrl();
      expect(url, link.key);
    });
  }
}
