import 'package:solana/solana.dart';
import 'package:test/test.dart';

void main() {
  test('it fails for invalid base58 characters', () {
    expect(
        isValidAddress('2gVkYWexTHR5Hb2aLeQN3tnngvWzisFKXDUPrgMHpdSl'), false);
  });

  test('it fails for invalid length', () {
    expect(isValidAddress('2gVkYWexTHR5Hb2aLeQN3tnngvWzisFKXDUPrgMHpd'), false);
  });

  test('it correctly validates valid addresses', () {
    expect(
        isValidAddress('HzqnaMjWFbK2io6WgV2Z5uBguCBU21RMUS16wsDUHkon'), true);
    expect(
        isValidAddress('68io7dTfyeWua1wD1YcCMka4y5iiChceaFRCBjqCM5PK'), true);
    expect(
        isValidAddress('Dra34QLFCjxnk8tUNcBwxs6pgb5spF4oseQYF2xn7ABZ'), true);
  });
  test('it fails for invalid ed25519 points', () {
    expect(
        isValidAddress('6X4X1Ae24mkoWeCEpktevySVG9jzeCufut5vtUW3wFrD'), false);
    expect(
        isValidAddress('EDNd1ycsydWYwVmrYZvqYazFqwk1QjBgAUKFjBoz1jKP'), false);
    expect(
        isValidAddress('ANVCrmRw7Ww7rTFfMbrjApSPXEEcZpBa6YEiBdf98pAf'), false);
    expect(
        isValidAddress('AbygL37RheNZv327cMvZPqKYLLkZ6wqWYexRxgNiZyeP'), false);
  });
}
