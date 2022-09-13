import 'package:cryptoplease/core/split_key_payments/split_key_api_version.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/features/incoming_split_key_payment/bl/models.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('(v1) Builds first link', () {
    final link = buildFirstLink(
      [1, 2, 3, 4].lock,
      Token.sol.address,
      SplitKeyApiVersion.v1,
    );
    expect(
      link.toString(),
      'https://solana1.cryptoplease.link/?key=5T&v=v1',
    );
  });

  test('(v2) Builds first link', () {
    final link = buildFirstLink(
      [1, 2, 3, 4].lock,
      Token.sol.address,
      SplitKeyApiVersion.v2,
    );
    expect(
      link.toString(),
      'https://solana1.cryptoplease.link/?key=5T&v=v2',
    );
  });

  test('Builds second link', () {
    final link = buildSecondLink([1, 2, 3, 4].lock);
    expect(link.toString(), 'https://solana2.cryptoplease.link/?key=EK');
  });

  test('(v1) Valid first link 1', () {
    expect(
      SplitKeyIncomingFirstPart.tryParse(
        Uri.parse('https://solana1.cryptoplease.link?token=abc&key=123'),
      ),
      const SplitKeyIncomingFirstPart(
        keyPart: '123',
        tokenAddress: 'abc',
        apiVersion: SplitKeyApiVersion.v1,
      ),
    );
  });

  test('(v1) Valid first link 2', () {
    expect(
      SplitKeyIncomingFirstPart.tryParse(
        Uri.parse('https://solana1.cryptoplease.link?key=123'),
      ),
      SplitKeyIncomingFirstPart(
        keyPart: '123',
        tokenAddress: Token.sol.address,
        apiVersion: SplitKeyApiVersion.v1,
      ),
    );
  });

  test('(v1) Valid first link 3', () {
    expect(
      SplitKeyIncomingFirstPart.tryParse(
        Uri.parse('https://solana1.cryptoplease.link/?token=abc&key=123'),
      ),
      const SplitKeyIncomingFirstPart(
        keyPart: '123',
        tokenAddress: 'abc',
        apiVersion: SplitKeyApiVersion.v1,
      ),
    );
  });

  test('(v2) Valid first link 1', () {
    expect(
      SplitKeyIncomingFirstPart.tryParse(
        Uri.parse(
          'https://solana1.cryptoplease.link?token=abc&key=123&v=v2',
        ),
      ),
      const SplitKeyIncomingFirstPart(
        keyPart: '123',
        tokenAddress: 'abc',
        apiVersion: SplitKeyApiVersion.v2,
      ),
    );
  });

  test('(v2) Valid first link 2', () {
    expect(
      SplitKeyIncomingFirstPart.tryParse(
        Uri.parse('https://solana1.cryptoplease.link?key=123&v=v2'),
      ),
      SplitKeyIncomingFirstPart(
        keyPart: '123',
        tokenAddress: Token.sol.address,
        apiVersion: SplitKeyApiVersion.v2,
      ),
    );
  });

  test('(v2) Valid first link 3', () {
    expect(
      SplitKeyIncomingFirstPart.tryParse(
        Uri.parse(
          'https://solana1.cryptoplease.link/?token=abc&key=123&v=v2',
        ),
      ),
      const SplitKeyIncomingFirstPart(
        keyPart: '123',
        tokenAddress: 'abc',
        apiVersion: SplitKeyApiVersion.v2,
      ),
    );
  });

  test('Valid first link 1 (old)', () {
    expect(
      SplitKeyIncomingFirstPart.tryParse(
        Uri.parse('https://sol.cryptoplease.link?token=abc&key=123'),
      ),
      const SplitKeyIncomingFirstPart(
        keyPart: '123',
        tokenAddress: 'abc',
        apiVersion: SplitKeyApiVersion.v1,
      ),
    );
  });

  test('Valid first link 2 (old)', () {
    expect(
      SplitKeyIncomingFirstPart.tryParse(
        Uri.parse('https://sol.cryptoplease.link?key=123'),
      ),
      SplitKeyIncomingFirstPart(
        keyPart: '123',
        tokenAddress: Token.sol.address,
        apiVersion: SplitKeyApiVersion.v1,
      ),
    );
  });

  test('Valid first link 3 (old)', () {
    expect(
      SplitKeyIncomingFirstPart.tryParse(
        Uri.parse('cryptoplease-sol://1?token=abc&key=123'),
      ),
      const SplitKeyIncomingFirstPart(
        keyPart: '123',
        tokenAddress: 'abc',
        apiVersion: SplitKeyApiVersion.v1,
      ),
    );
  });

  test('Valid first link 4 (old)', () {
    expect(
      SplitKeyIncomingFirstPart.tryParse(
        Uri.parse('https://sol.cryptoplease.link/?token=abc&key=123'),
      ),
      const SplitKeyIncomingFirstPart(
        keyPart: '123',
        tokenAddress: 'abc',
        apiVersion: SplitKeyApiVersion.v1,
      ),
    );
  });

  test('Valid first link 5 (old)', () {
    expect(
      SplitKeyIncomingFirstPart.tryParse(
        Uri.parse('cryptoplease-sol://1/?token=abc&key=123'),
      ),
      const SplitKeyIncomingFirstPart(
        keyPart: '123',
        tokenAddress: 'abc',
        apiVersion: SplitKeyApiVersion.v1,
      ),
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
        Uri.parse('https://solana2.cryptoplease.link?key=123'),
      ),
      const SplitKeySecondLink(key: '123'),
    );
  });

  test('Valid second link 1 (old)', () {
    expect(
      SplitKeySecondLink.tryParse(
        Uri.parse('cryptoplease://sk?second=123_a'),
      ),
      const SplitKeySecondLink(key: '123'),
    );
  });

  test('Valid second link 2 (old)', () {
    expect(
      SplitKeySecondLink.tryParse(
        Uri.parse('https://cryptoplease.github.io?data=123_a'),
      ),
      const SplitKeySecondLink(key: '123'),
    );
  });

  test('Valid second link 3 (old)', () {
    expect(
      SplitKeySecondLink.tryParse(
        Uri.parse('https://sol2.cryptoplease.link?key=123'),
      ),
      const SplitKeySecondLink(key: '123'),
    );
  });

  test('Valid second link 4 (old)', () {
    expect(
      SplitKeySecondLink.tryParse(
        Uri.parse('cryptoplease-sol://2?key=123'),
      ),
      const SplitKeySecondLink(key: '123'),
    );
  });

  test('Valid second link 5 (old)', () {
    expect(
      SplitKeySecondLink.tryParse(
        Uri.parse('https://sol2.cryptoplease.link/?key=123'),
      ),
      const SplitKeySecondLink(key: '123'),
    );
  });

  test('Valid second link 6 (old)', () {
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
