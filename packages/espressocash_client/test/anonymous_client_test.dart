import 'package:ec_client_dart/ec_client_dart.dart';
import 'package:test/test.dart';

const baseUrl = 'grpc-demo.espressocash.com';
const port = 443;

void main() {
  late EspressoCashClient client;

  setUp(() async {
    client = await EspressoCashClient.anonymous(
      baseUrl: baseUrl,
      port: port,
      secure: true,
    );
  });

  tearDown(() async {
    await client.dispose();
  });

  test('creates anonymous client successfully', () {
    expect(client, isNotNull);
    expect(client.walletAddress, isNull);
  });

  test('expands shortened link without authentication', () async {
    final shortLink =
        'https://pay.espressocash.com/?s=7ec8ca685976c4062db58ae8536901f7';

    final result = await client.expandLink(
      UnshortenLinkRequestDto(shortLink: shortLink),
    );

    expect(result, isNotNull);
    expect(result.fullLink, isA<String>());
    print('Expanded link: ${result.fullLink}');
  });
}
