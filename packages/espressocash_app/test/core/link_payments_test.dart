import 'package:espressocash_app/features/link_payments/models/link_payment.dart';
import 'package:espressocash_app/features/tokens/token.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Builds link', () {
    final link = LinkPayment(key: 'abcd', token: Token.usdc.publicKey);

    expect(
      link.toShareableLink().toString(),
      'https://pay.espressocash.com?t=link&k=abcd',
    );
  });

  test('Valid link', () {
    expect(
      LinkPayment.tryParse(
        Uri.parse('https://pay.espressocash.com?t=link&k=123'),
      ),
      LinkPayment(key: '123', token: Token.usdc.publicKey),
    );
  });

  test('Invalid link ', () {
    expect(
      LinkPayment.tryParse(
        Uri.parse(
          'https://solana1.cryptoplease.link?token=${Token.usdc.address}&key=123&v=v4',
        ),
      ),
      isNull,
    );
  });
}
