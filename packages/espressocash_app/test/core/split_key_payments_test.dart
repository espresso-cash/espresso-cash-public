import 'package:espressocash_app/core/split_key_payments.dart';
import 'package:espressocash_app/core/tokens/token.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Builds first link', () {
    final link = SplitKeyFirstLink(key: 'abcd', token: Token.usdc.publicKey);

    expect(
      link.toUri().toString(),
      'https://solana1.cryptoplease.link/?key=abcd&token=${Token.usdc.address}&v=v2',
    );
  });

  test('Builds second link', () {
    const link = SplitKeySecondLink(key: 'abcd');
    expect(
      link.toUri().toString(),
      'https://solana2.cryptoplease.link/?key=abcd',
    );
  });

  test('Valid first link 1', () {
    expect(
      SplitKeyFirstLink.tryParse(
        Uri.parse(
          'https://solana1.cryptoplease.link?token=${Token.usdc.address}&key=123&v=v2',
        ),
      ),
      SplitKeyFirstLink(key: '123', token: Token.usdc.publicKey),
    );
  });

  test('Tip link is not Split Key link', () {
    expect(
      SplitKeyFirstLink.tryParse(
        Uri.parse(
          'https://solana1.cryptoplease.link?token=${Token.usdc.address}&key=123&v=v2&type=tip',
        ),
      ),
      null,
    );
  });

  test('Valid second link 1', () {
    expect(
      SplitKeySecondLink.tryParse(
        Uri.parse('https://solana2.cryptoplease.link?key=123'),
      ),
      const SplitKeySecondLink(key: '123'),
    );
  });

  test('Invalid second link 1', () {
    expect(
      SplitKeySecondLink.tryParse(Uri.parse('crypto://some_link')),
      isNull,
    );
  });

  test('Invalid second link 2', () {
    expect(
      SplitKeySecondLink.tryParse(Uri.parse('No link here')),
      isNull,
    );
  });
}
