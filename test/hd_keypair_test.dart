import 'package:solana/src/crypto/ed25519_hd_keypair.dart';
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
