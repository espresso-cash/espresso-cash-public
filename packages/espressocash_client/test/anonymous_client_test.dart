import 'package:ec_client_dart/ec_client_dart.dart';
import 'package:test/test.dart';

import 'utils.dart';

void main() {
  late EspressoCashClient client;

  setUp(() {
    client = createAnonymousClient();
  });

  tearDown(() async {
    await client.dispose();
  });

  test('creates anonymous client successfully', skip: true, () {
    expect(client.walletAddress, isNull);
  });

  test('expands shortened link without authentication', skip: true, () async {
    const shortLink = 'https://pay.espressocash.com/?s=7ec8ca685976c4062db58ae8536901f7';

    final result = await client.expandLink(const UnshortenLinkRequestDto(shortLink: shortLink));

    expect(result.fullLink, isA<String>());
  });
}
