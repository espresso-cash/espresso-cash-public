import 'package:ec_client_dart/ec_client_dart.dart';
import 'package:ec_client_dart/src/espressocash_client.dart';
import 'package:solana/solana.dart';
import 'package:test/test.dart';

import 'utils.dart';

void main() {
  late EspressoCashClient client;
  late Ed25519HDKeyPair keyPair;

  setUp(() async {
    keyPair = await Ed25519HDKeyPair.random();

    client = await createClient(keyPair: keyPair);
    await client.login();
  });

  tearDown(() async {
    await client.dispose();
  });

  group('Token operations', () {
    test('gets tokens metadata', skip: true, () async {
      final response = await client.getTokensMeta();

      // ignore: avoid-weak-cryptographic-algorithms, accepted algorithm
      expect(response.md5, isA<String>());
    });

    test('gets tokens file', skip: true, () async {
      await client.getTokensFile('tokenlist.csv.gz');
    });
  });
}
