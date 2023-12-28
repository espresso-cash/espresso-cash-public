import 'package:flutter_test/flutter_test.dart';
import 'package:solana_seed_vault/solana_seed_vault.dart';

void main() {
  group(
    'Should succeed to convert valid BipLevels to BIP44 Uri',
    () {
      test(
        'Convert single hardened BipLevel to BIP44 Uri',
        () {
          final levels = [const BipLevel(index: 0, hardened: true)];

          final result = Bip44DerivationPath.toUri(levels);

          expect(result, Uri.parse('bip44:/0\''));
        },
      );

      test(
        'Convert multiple hardened BipLevels to BIP44 Uri',
        () {
          final levels =
              List.generate(2, (i) => BipLevel(index: i, hardened: true));

          final result = Bip44DerivationPath.toUri(levels);

          expect(result, Uri.parse('bip44:/0\'/1\''));
        },
      );
      test(
        'Convert single non-hardened BipLevel to BIP44 Uri',
        () {
          final levels = [const BipLevel(index: 0, hardened: false)];

          final result = Bip44DerivationPath.toUri(levels);

          expect(result, Uri.parse('bip44:/0'));
        },
      );

      test(
        'Convert multiple non-hardened BipLevels to BIP44 Uri',
        () {
          final levels =
              List.generate(2, (i) => BipLevel(index: i, hardened: false));

          final result = Bip44DerivationPath.toUri(levels);

          expect(result, Uri.parse('bip44:/0/1'));
        },
      );

      test(
        'Convert multiple hardened and non-hardened BipLevels to BIP44 Uri',
        () {
          final levels =
              List.generate(4, (i) => BipLevel(index: i, hardened: i.isOdd));

          final result = Bip44DerivationPath.toUri(levels);

          expect(result, Uri.parse('bip44:/0/1\'/2/3\''));
        },
      );
    },
  );

  group(
    'Should succeed to convert valid BIP44 Uri to BipLevels',
    () {
      test(
        'Convert BIP44 Uri to account BipLevel only',
        () {
          final uri = Uri.parse('bip44:/0\'');

          final result = Bip44DerivationPath.fromUri(uri);

          expect(result.account, const BipLevel(index: 0, hardened: true));
          expect(result.change, null);
          expect(result.addressIndex, null);
        },
      );

      test(
        'Convert BIP44 Uri to multiple BipLevels',
        () {
          final uri = Uri.parse('bip44:/0\'/1\'');

          final result = Bip44DerivationPath.fromUri(uri);

          expect(result.account, const BipLevel(index: 0, hardened: true));
          expect(result.change, const BipLevel(index: 1, hardened: true));
          expect(result.addressIndex, null);
        },
      );

      test(
        'Convert BIP44 Uri to multiple hardened and non-hardened BipLevels',
        () {
          final uri = Uri.parse('bip44:/0\'/1/2\'');

          final result = Bip44DerivationPath.fromUri(uri);

          expect(result.account, const BipLevel(index: 0, hardened: true));
          expect(result.change, const BipLevel(index: 1, hardened: false));
          expect(result.addressIndex, const BipLevel(index: 2, hardened: true));
        },
      );
    },
  );

  group(
    'Should fail to convert invalid BIP44 Uri to BipLevels',
    () {
      test(
        'Non-hierarchical URI',
        () {
          final uri = Uri.parse('bip44:0\'');

          expect(
            () => Bip44DerivationPath.fromUri(uri),
            throwsA(isA<UnsupportedError>()),
          );
        },
      );

      test(
        'Invalid schema',
        () {
          final uri = Uri.parse('bip:/m/0\'');

          expect(
            () => Bip44DerivationPath.fromUri(uri),
            throwsA(isA<UnsupportedError>()),
          );
        },
      );
      test(
        'Contains authority info',
        () {
          final uri = Uri.parse('bip44:/m/0\':8080');

          expect(
            () => Bip44DerivationPath.fromUri(uri),
            throwsA(isA<UnsupportedError>()),
          );
        },
      );
      test(
        'Contains query',
        () {
          final uri = Uri.parse('bip44:/m/0\'?q=invalid');

          expect(
            () => Bip44DerivationPath.fromUri(uri),
            throwsA(isA<UnsupportedError>()),
          );
        },
      );
      test(
        'Contains fragment',
        () {
          final uri = Uri.parse('bip44:/m/0\'#1');

          expect(
            () => Bip44DerivationPath.fromUri(uri),
            throwsA(isA<UnsupportedError>()),
          );
        },
      );
      test(
        'Invalid level indexes',
        () {
          final uri = Uri.parse('bip44:/m/invalid');

          expect(
            () => Bip44DerivationPath.fromUri(uri),
            throwsA(isA<UnsupportedError>()),
          );
        },
      );
      test(
        'Too many BipLevels',
        () {
          final uri = Uri.parse('bip44:/0/1/2/3\'');

          expect(
            () => Bip44DerivationPath.fromUri(uri),
            throwsA(isA<UnsupportedError>()),
          );
        },
      );
    },
  );
}
