<<<<<<<< HEAD:packages/espressocash_app/test/core/single_key_payments_test.dart
import 'package:cryptoplease/core/single_key_payments.dart';
import 'package:cryptoplease/core/tokens/token.dart';
========
import 'package:espressocash_app/core/tip_payments.dart';
import 'package:espressocash_app/core/tokens/token.dart';
>>>>>>>> e33fccb59c629b584b13dd4ec01c02a1adb130f0:packages/espressocash_app/test/core/tip_payments_test.dart
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Builds single key link', () {
    final link = SingleKeyPaymentData(key: 'abcd', token: Token.usdc.publicKey);

    expect(
      link.toUri().toString(),
      'https://solana1.cryptoplease.link/?key=abcd&token=${Token.usdc.address}&v=v2&type=single',
    );
  });

  test('Valid single key link', () {
    expect(
      SingleKeyPaymentData.tryParse(
        Uri.parse(
          'https://solana1.cryptoplease.link?token=${Token.usdc.address}&key=123&v=v2&type=single',
        ),
      ),
      SingleKeyPaymentData(key: '123', token: Token.usdc.publicKey),
    );
  });

  test('Split Key link is not Single Key link', () {
    expect(
      SingleKeyPaymentData.tryParse(
        Uri.parse(
          'https://solana1.cryptoplease.link?token=${Token.usdc.address}&key=123&v=v2',
        ),
      ),
      null,
    );
  });

  test('Invalid link 1', () {
    expect(
      SingleKeyPaymentData.tryParse(Uri.parse('crypto://some_link')),
      isNull,
    );
  });

  test('Invalid link 2', () {
    expect(
      SingleKeyPaymentData.tryParse(Uri.parse('No link here')),
      isNull,
    );
  });
}
