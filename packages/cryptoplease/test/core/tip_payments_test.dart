import 'package:cryptoplease/core/tip_payments.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Builds tip link', () {
    final link = TipPaymentData(key: 'abcd', token: Token.usdc.publicKey);

    expect(
      link.toUri().toString(),
      'https://solana1.cryptoplease.link/?key=abcd&token=${Token.usdc.address}&v=v2&type=tip',
    );
  });

  test('Valid tip link', () {
    expect(
      TipPaymentData.tryParse(
        Uri.parse(
          'https://solana1.cryptoplease.link?token=${Token.usdc.address}&key=123&v=v2&type=tip',
        ),
      ),
      TipPaymentData(key: '123', token: Token.usdc.publicKey),
    );
  });

  test('Split Key link is not Tip link', () {
    expect(
      TipPaymentData.tryParse(
        Uri.parse(
          'https://solana1.cryptoplease.link?token=${Token.usdc.address}&key=123&v=v2',
        ),
      ),
      null,
    );
  });

  test('Invalid link 1', () {
    expect(
      TipPaymentData.tryParse(Uri.parse('crypto://some_link')),
      isNull,
    );
  });

  test('Invalid link 2', () {
    expect(
      TipPaymentData.tryParse(Uri.parse('No link here')),
      isNull,
    );
  });
}
