import 'package:espressocash_app/core/api_version.dart';
import 'package:espressocash_app/core/split_key_payments.dart';
import 'package:espressocash_app/core/tokens/token.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SplitKeyApiVersion.manual:', () {
    test('Builds first link', () {
      final link = SplitKeyFirstLink(
        key: 'abcd',
        token: Token.usdc.publicKey,
        apiVersion: SplitKeyApiVersion.manual,
        source: SplitKeySource.other,
      );

      expect(
        link.toUri().toString(),
        'https://solana1.cryptoplease.link/?key=abcd&token=${Token.usdc.address}&v=v2',
      );
    });

    test('Builds second link (manual)', () {
      const link = SplitKeySecondLink(
        key: 'abcd',
        apiVersion: SplitKeyApiVersion.manual,
      );
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
        SplitKeyFirstLink(
          key: '123',
          token: Token.usdc.publicKey,
          apiVersion: SplitKeyApiVersion.manual,
          source: SplitKeySource.other,
        ),
      );
    });

    test('Single Key link is not Split Key link', () {
      expect(
        SplitKeyFirstLink.tryParse(
          Uri.parse(
            'https://solana1.cryptoplease.link?token=${Token.usdc.address}&key=123&v=v2&type=single',
          ),
        ),
        null,
      );
    });

    test('Invalid first link 1', () {
      expect(
        SplitKeyFirstLink.tryParse(
          Uri.parse(
            'https://solana1.cryptoplease.link?token=${Token.usdc.address}&key=123&v=v4',
          ),
        ),
        isNull,
      );
    });

    test('Valid second link 1', () {
      expect(
        SplitKeySecondLink.tryParse(
          Uri.parse('https://solana2.cryptoplease.link?key=123'),
        ),
        const SplitKeySecondLink(
          key: '123',
          apiVersion: SplitKeyApiVersion.manual,
        ),
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
  });

  group('SplitKeyApiVersion.smartContract:', () {
    test('Builds first link (smartContract)', () {
      final link = SplitKeyFirstLink(
        key: 'abcd',
        token: Token.usdc.publicKey,
        apiVersion: SplitKeyApiVersion.smartContract,
        source: SplitKeySource.other,
      );

      expect(
        link.toUri().toString(),
        'https://link.espressocash.com?k1=abcd',
      );
    });

    test('Builds second link (smartContract)', () {
      const link = SplitKeySecondLink(
        key: 'abcd',
        apiVersion: SplitKeyApiVersion.smartContract,
      );
      expect(
        link.toUri().toString(),
        'https://link.espressocash.com?k2=abcd',
      );
    });

    test('Valid first link 1', () {
      expect(
        SplitKeyFirstLink.tryParse(
          Uri.parse('https://link.espressocash.com?k1=123'),
        ),
        SplitKeyFirstLink(
          key: '123',
          token: Token.usdc.publicKey,
          apiVersion: SplitKeyApiVersion.smartContract,
          source: SplitKeySource.other,
        ),
      );
    });

    test('Valid second link 1', () {
      expect(
        SplitKeySecondLink.tryParse(
          Uri.parse('https://link.espressocash.com?k2=123'),
        ),
        const SplitKeySecondLink(
          key: '123',
          apiVersion: SplitKeyApiVersion.smartContract,
        ),
      );
    });
  });
}
