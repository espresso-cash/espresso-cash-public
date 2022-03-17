import 'package:cryptoplease/bl/split_key_payments/models.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Builds first link', () {
    final link = buildFirstLink([1, 2, 3, 4].lock, Token.sol.address);
    expect(link.toString(), 'https://sol.cryptoplease.link/?key=5T');
  });

  test('Builds second link', () {
    final link = buildSecondLink([1, 2, 3, 4].lock);
    expect(link.toString(), 'https://sol2.cryptoplease.link/?key=EK');
  });

  test('Valid first link 1', () {
    expect(
      SplitKeyIncomingFirstPart.tryParse(
        Uri.parse('https://sol.cryptoplease.link?token=abc&key=123'),
      ),
      const SplitKeyIncomingFirstPart(keyPart: '123', tokenAddress: 'abc'),
    );
  });

  test('Valid first link 2', () {
    expect(
      SplitKeyIncomingFirstPart.tryParse(
        Uri.parse('https://sol.cryptoplease.link?key=123'),
      ),
      SplitKeyIncomingFirstPart(
        keyPart: '123',
        tokenAddress: Token.sol.address,
      ),
    );
  });

  test('Valid first link 3', () {
    expect(
      SplitKeyIncomingFirstPart.tryParse(
        Uri.parse('cryptoplease-sol://1?token=abc&key=123'),
      ),
      const SplitKeyIncomingFirstPart(keyPart: '123', tokenAddress: 'abc'),
    );
  });

  test('Valid first link 4', () {
    expect(
      SplitKeyIncomingFirstPart.tryParse(
        Uri.parse('https://sol.cryptoplease.link/?token=abc&key=123'),
      ),
      const SplitKeyIncomingFirstPart(keyPart: '123', tokenAddress: 'abc'),
    );
  });

  test('Valid first link 5', () {
    expect(
      SplitKeyIncomingFirstPart.tryParse(
        Uri.parse('cryptoplease-sol://1/?token=abc&key=123'),
      ),
      const SplitKeyIncomingFirstPart(keyPart: '123', tokenAddress: 'abc'),
    );
  });

  test('Invalid first link 1', () {
    expect(
      SplitKeyIncomingFirstPart.tryParse(
        Uri.parse('cryptoplease-sol://2?key=123'),
      ),
      isNull,
    );
  });

  test('Valid second link 1', () {
    expect(
      SplitKeySecondLink.tryParse(
        Uri.parse('cryptoplease://sk?second=123_a'),
      ),
      const SplitKeySecondLink(key: '123'),
    );
  });

  test('Valid second link 2', () {
    expect(
      SplitKeySecondLink.tryParse(
        Uri.parse('https://cryptoplease.github.io?data=123_a'),
      ),
      const SplitKeySecondLink(key: '123'),
    );
  });

  test('Valid second link 3', () {
    expect(
      SplitKeySecondLink.tryParse(
        Uri.parse('https://sol2.cryptoplease.link?key=123'),
      ),
      const SplitKeySecondLink(key: '123'),
    );
  });

  test('Valid second link 4', () {
    expect(
      SplitKeySecondLink.tryParse(
        Uri.parse('cryptoplease-sol://2?key=123'),
      ),
      const SplitKeySecondLink(key: '123'),
    );
  });

  test('Valid second link 5', () {
    expect(
      SplitKeySecondLink.tryParse(
        Uri.parse('https://sol2.cryptoplease.link/?key=123'),
      ),
      const SplitKeySecondLink(key: '123'),
    );
  });

  test('Valid second link 6', () {
    expect(
      SplitKeySecondLink.tryParse(
        Uri.parse('cryptoplease-sol://2/?key=123'),
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
