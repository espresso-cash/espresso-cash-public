// ignore_for_file: cast_nullable_to_non_nullable

import 'dart:math';

import 'package:solana/solana.dart';
import 'package:test/test.dart';

void main() {
  test('Derivation works for all test cases', () async {
    for (final int walletIndex in _testCases.keys) {
      final wallet = _testCases[walletIndex]!;
      for (final MapEntry<int, String> item in wallet.entries) {
        final signer = await Ed25519HDKeyPair.fromMnemonic(
          _mnemonic,
          account: walletIndex,
          change: item.key,
        );
        expect(signer.address, equals(item.value));
      }
    }
  });

  test('Creating a keypair directly from private key bytes works', () async {
    // Test with a bunch different random keys
    for (var i = 0; i < 20; i++) {
      final randomKeyPair = await Ed25519HDKeyPair.random();
      final simpleKeyPairData = await randomKeyPair.extract();
      final testKeyPair = await Ed25519HDKeyPair.fromPrivateKeyBytes(
        privateKey: simpleKeyPairData.bytes,
      );

      expect(randomKeyPair.address, equals(testKeyPair.address));

      // Sign a bunch of random messages to check that it works
      for (var j = 0; j < 20; ++j) {
        int random(int _) => _random.nextInt(256);

        // Create the seed
        final List<int> testBytes = List<int>.generate(100, random);
        // Signatures are identical with both key pairs
        final signature1 = await randomKeyPair.sign(testBytes);
        final signature2 = await testKeyPair.sign(testBytes);

        expect(signature1, signature2);
      }
    }
  });

  test(
    'Can derive a public key from another public key and a seed',
    () async {
      _withSeedKeyDerivationData.forEach((key, value) async {
        final derived = await Ed25519HDPublicKey.createWithSeed(
          fromPublicKey: Ed25519HDPublicKey.fromBase58(key),
          seed: value['seed'] as String,
          programId: Ed25519HDPublicKey.fromBase58(SystemProgram.programId),
        );

        expect(derived.toBase58(), value['result']);
      });
    },
  );

  test(
    'Can copy a key pair data if bytes are not destroyed',
    () async {
      final randomKeyPair = await Ed25519HDKeyPair.random();
      final simpleKeyPairData = await randomKeyPair.extract();
      final testKeyPair = simpleKeyPairData.copy();

      expect(randomKeyPair.publicKey, equals(testKeyPair.publicKey));
    },
  );

  test(
    'Cannot copy a key pair data if bytes are destroyed',
    () async {
      final randomKeyPair = await Ed25519HDKeyPair.random();
      final simpleKeyPairData = await randomKeyPair.extract();
      simpleKeyPairData.destroy();

      expect(simpleKeyPairData.copy, throwsA(isA<StateError>()));
    },
  );

  test(
    'Cannot extract a key pair data if bytes are destroyed',
    () async {
      final randomKeyPair = await Ed25519HDKeyPair.random();
      final simpleKeyPairData = await randomKeyPair.extract();
      simpleKeyPairData.destroy();

      expect(simpleKeyPairData.extract, throwsA(isA<StateError>()));
    },
  );

  group('getHDPath', () {
    test('returns correct path with account and change', () {
      expect(Ed25519HDKeyPair.getHDPath(1, 2), equals("m/44'/501'/1'/2'"));
    });

    test('returns correct path with only account', () {
      expect(Ed25519HDKeyPair.getHDPath(1, null), equals("m/44'/501'/1'"));
    });

    test('returns correct path with only change', () {
      expect(Ed25519HDKeyPair.getHDPath(null, 2), equals("m/44'/501'/0'/2'"));
    });

    test('returns correct path with no account or change', () {
      expect(Ed25519HDKeyPair.getHDPath(null, null), equals("m/44'/501'"));
    });
  });
}

const _mnemonic =
    'nothing steak step patient peasant assist add coral tone harsh hint dilemma';
const _testCases = {
  0: {
    0: 'AZ9tSkwgBjvgNrSBKujYVobWkcVy7QuJJHUiiUs7PTG',
    1: 'EABPLcGWs53zd1Kdhz25S7dSy5WNSAvS8DzjyGsDSaWN',
    2: 'GsiMGRtdX5ufN3CZmx8UbgpVmV29V2R9PcXH6xuDghGV',
    3: 'JEECvYzWfARXz5s4tsW1kR6ar2jkqSV3sfZSkw7ZweXY',
    4: '4q4XDHkK2QRLmBPfFaz6wky5r8BnHsgNsFFvU9rYyvsS',
    5: 'CcT6Ffgf498guEyVXaGxsv4mKWRXTtby8i4TEAEdYgJY',
  },
  1: {
    0: 'B7KveuCb5W4CpDe4SQHdCmokEU8A8wDVEkcEyQJ5Nnyu',
    1: '2YWUvBHTYBnXhkQnXkYvgMw3gipxc6uJ6rE9Lss9UVWB',
    2: '6JxNKUf83kF5kUBdWbjC3CD62kkmiY4imvFB38qMxjvs',
    3: 'AWFMLshwnwamhgfEnDYPUWVMewNswzazWtUaEEnyuh99',
    4: 'GwFbSCTiy1eusJ9Axk3GqZthvvQZVY715FJzqAnor7bf',
    5: '4hG6dGqGHGJRcAtHLJsZi3Vat1rgtSyC5zY4XQvfekqC',
  },
  2: {
    0: 'J1QX218Pckm9m2MxWkhdKgdTBieAADzUfThGpCWqRcEu',
    1: 'GtFJrgxwHBGuBChuuHKq3adda16PT9nuyMfBDaUgmgZ7',
    2: '3kaUj3THFwbZsZwbJ5DRKnwVmHurZutK5PZ6rUeKYHSG',
    3: 'GaVaMi5qgds93g5C8egHZzA5T9A2P4rxmGQaFTpTFRtR',
    4: '5U1yWdhWWyKW1WKf3kse3MwUjXDngQCj7spV8GWvCPcJ',
    5: '7gziCSpT9kPSodDxqmzCbZrwwm2kmMDGJj1hawohyJyQ',
  },
  3: {
    0: 'FsBwksd1gXb22sX8w36VP3EdA4eFcJCJzXtYXrzhrzKF',
    1: '54xnBocBr1xKkfTJgY43fU9LJ1SrZ2XeKhnnSFR9RcHb',
    2: 'ADzMC2fj48AUFCESoQsGED6s4e33Uj7whzfPVfFHumGY',
    3: 'DMV9b9cKDe4PzehTHYiLg7UZSbCUHyfMgYsY4QGbSQYq',
    4: '8E3RxPKT8uwgqVtQEFyqM252SAGp9KoehGfL6kqFEju3',
    5: 'HL42no5PJdQ657nDcr2fSSNAdZZbQAjNMhwxxL3TiQ1d',
  },
  4: {
    0: 'EfvhFZxeptKe7pCrCfXPUZBpeqBHUu97ERsE426WTdVU',
    1: '2WXL6RUk7qmacdmoYyEW37HHY5wviAKsYvGGP67eWYHt',
    2: '7zGmgoa37oGncK2SYjxKeBRe7NnbvrZ94LyzEZiJEain',
    3: '72UYv24V3NWHND8KzGF2bkLWgQ3Hc181L9pL24Bf1iPo',
    4: 'DAVEtUY4xM4f8MEZutGvXjDTQgfWNmjsn6hhf32xdVJR',
    5: 'YReA4Xv7PpL6BZokvsiwHZdpcd8bqEf6NjvRW2bX8Cw',
  },
  5: {
    0: 'Bz69BTu8T3zQe3RXiE9D3DuARQ81U8rzCBC1bRPJSPTF',
    1: '4F6CtKKyWNgqnoSrxFTSReUMChvCmuzCKwBK6Jc3FstJ',
    2: 'H4FaiGjattjVe8ve9UqEgDT765pjbjGZV77Bv1vZqgUm',
    3: 'kHtcpyHD2YjvdSnyJPzGA26TGj7D8WJfYJBUSKjK7Xj',
    4: 'C5FkQjgPi7pezRcAHLaoafdFGW2Kavco8WvCrJ2HBYkM',
    5: 'Av4QAMBwZKt5bNnfT2mVc8VhWzE2z4JoWW36CsprwRHP',
  },
};

// Note: Generated with the web3.js library
final _withSeedKeyDerivationData = {
  'AKt2Mb3WWRvrQVVRKzPDKz2eJxt6FFp2JpqCQ2Dd6aiD': {
    'result': '3mofn5aDR85AQADM1sjg5EJkQzxm5mfARMdf8sGHMRnU',
    'seed': '83wbay35jln'
  },
  '4p4Q2mMS6beJHjWFq3Rf15yeTEagKx6xrNxS6BykHg5d': {
    'result': '71SdWBfp5Vc5B88UsTrDmRQnaUxjR9dWPrHfUFibz63i',
    'seed': 'sg7strvv6i8'
  },
  'JAJyHWhKKt1wQR393Vngd2KRGd2qp9Jt35xWRLBcE8vm': {
    'result': 'AUvp4exymYnFp64XZVBwgd9YqrRJ5YYRfi29myUHLpQh',
    'seed': 'hrhev1c4qka'
  },
  '2jTtpQYE26bjEjVtzTHBbsavTGh827Hero7YhTHkDL1P': {
    'result': '4fKy3JG28Z1GkLW8Gk5zLHwn24sVSMsS6in81LTy4eya',
    'seed': 'iafkw47ezrm'
  },
  '7vWmVQmLZw2YEGKoGVasxdBVS3BLLfv3iiLx9SnhNLu5': {
    'result': '8UQ48VTBQ9kVYKPRPpW7igGBk5kfBHNqf5ajvX4PwhEJ',
    'seed': 'oq4jdymivkp'
  },
  'AA8VS3DAdhyL6UEnrUuxYCdfVu8feyy8ccdYxbmfFpQF': {
    'result': 'CiTXxToxwwXRSxJ2zpqbzCALV4KC7nopgVs8U9LsWjB3',
    'seed': 'r6vuncch21s'
  },
  '5VxhCStjRsynKV74wAQ11DYRwW96yWxDoRdbbupayoF7': {
    'result': '8hxtWoVLpC8m5bfjFrmukDEHcAHtY7RUCFz3VUsjsKsy',
    'seed': '123wdwcqeq7l'
  },
  'E6iWcpEk7wAcEpX3ksGe1WuvrjTJekRicumJuPkbvYWh': {
    'result': '35KWzKbGVFnKAJADtKGrLTw8XUUofrLLAipuWeKw8VPE',
    'seed': 'gg21d582kt9'
  },
  '7PN32epxuKt71sG6Kygy9Dn2uhkvWHMbscka3kDdu1QE': {
    'result': 'GTreHFzqAtAYDDkg5ahCMT4Vc5zoXHzduL918Y4ZzQQ2',
    'seed': 'ayddb9axjft'
  },
  'F8UWuuDN6qo8Yh4zdofTCKQpMSh23sqA3rfFBWewHDZw': {
    'result': '3VDGgSjBASPHP35WwMv4G5U9WZEMQgfR4sMsbraKUHhQ',
    'seed': 'tf5b60vh0rl'
  },
};

final _random = Random.secure();
