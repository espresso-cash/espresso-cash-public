import 'package:solana/solana.dart';
import 'package:test/test.dart';

void main() {
  test('Throws for invalid base58 characters', () {
    expect(
      isValidAddress('2gVkYWexTHR5Hb2aLeQN3tnngvWzisFKXDUPrgMHpdSl'),
      equals(false),
    );
  });

  test('Throws for invalid length', () {
    expect(
      isValidAddress('2gVkYWexTHR5Hb2aLeQN3tnngvWzisFKXDUPrgMHpd'),
      equals(false),
    );
  });

  test('Correctly validates valid addresses', () {
    for (final a in _validAddresses) {
      expect(isValidAddress(a), equals(true));
    }
  });

  test('Fails for invalid ed25519 points', () {
    for (final a in _invalidAddresses) {
      expect(isValidAddress(a), false);
    }
  });
}

const _validAddresses = [
  '7vVcBLQwT1rmjiTXhhvmHKfiaCda2giGMeKchc2jwmBN',
  '3z99cfKQ2kvKxs79gJon7GeRZ3gtJWfmNG1NkZqFJKQs',
  '6pr7pCxXu9cF8oP2ARRhrkDj6ikw6QyJNAZ62gyQmwjZ',
  'HzqnaMjWFbK2io6WgV2Z5uBguCBU21RMUS16wsDUHkon',
  '68io7dTfyeWua1wD1YcCMka4y5iiChceaFRCBjqCM5PK',
  'Dra34QLFCjxnk8tUNcBwxs6pgb5spF4oseQYF2xn7ABZ',
];

const _invalidAddresses = [
  '6X4X1Ae24mkoWeCEpktevySVG9jzeCufut5vtUW3wFrD',
  'EDNd1ycsydWYwVmrYZvqYazFqwk1QjBgAUKFjBoz1jKP',
  'ANVCrmRw7Ww7rTFfMbrjApSPXEEcZpBa6YEiBdf98pAf',
  'AbygL37RheNZv327cMvZPqKYLLkZ6wqWYexRxgNiZyeP',
  '3gF2KMe9KiC6FNVBmfg9i267aMPvK37FewCip4eGBFcT',
];
