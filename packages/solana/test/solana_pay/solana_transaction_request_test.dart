import 'package:solana/solana_pay.dart';
import 'package:test/test.dart';

void main() {
  final validLinks = <String, SolanaTransactionRequest>{
    'solana:https://example.com/solana-pay': SolanaTransactionRequest(
      link: Uri.parse(
        'https://example.com/solana-pay',
      ),
    ),
    'solana:https%3A%2F%2Fexample.com%2Fsolana-pay%3Forder%3D12345':
        SolanaTransactionRequest(
      link: Uri.parse(
        'https://example.com/solana-pay?order=12345',
      ),
    ),
    'solana:https://example.com?label=label&message=message':
        SolanaTransactionRequest(
      link: Uri.parse(
        'https://example.com',
      ),
      label: 'label',
      message: 'message',
    ),
    'solana:https%3A%2F%2Fexample.com%3Fquery%3Dparam?label=label&message=message':
        SolanaTransactionRequest(
      link: Uri.parse(
        'https://example.com?query=param',
      ),
      label: 'label',
      message: 'message',
    ),
  };

  for (final link in validLinks.entries) {
    test('Valid link: ${link.key}', () {
      final request = SolanaTransactionRequest.parse(link.key);
      expect(request, link.value);
    });

    test('Builds link: ${link.key}', () {
      final url = link.value.toUrl();
      expect(url, link.key);
    });
  }

  test('Catch Invalid Links', () {
    final request = SolanaTransactionRequest.tryParse('invalid-key');
    expect(request, null);

    expect(
      () => SolanaTransactionRequest.parse('sol:https://example.com'),
      throwsA(
        isA<ParseUrlException>().having(
          (p) => p.message,
          'Protocol invalid',
          'Protocol invalid',
        ),
      ),
    );

    expect(
      () => SolanaTransactionRequest.parse('solana:http://example.com'),
      throwsA(
        isA<ParseUrlException>().having(
          (p) => p.message,
          'Protocol invalid',
          'Protocol invalid',
        ),
      ),
    );
  });
}
