import 'package:solana/solana.dart';
import 'package:test/test.dart';

void main() {
  test('it correctly validates valid addresses', () {
    expect(
      isValidAddress('Dra34QLFCjxnk8tUNcBwxs6pgb5spF4oseQYF2xn7ABZ'),
      true,
    );
  });
  test('it correctly validates invalid addresses', () {
    expect(
      isValidAddress('6X4X1Ae24mkoWeCEpktevySVG9jzeCufut5vtUW3wFrD'),
      false,
    );
  });
}
