import 'package:ec_client_dart/ec_client_dart.dart';
import 'package:solana/solana.dart';
import 'package:test/test.dart';

const baseUrl = 'grpc-demo.espressocash.com';
const port = 443;

void main() {
  late EspressoCashClient client;
  late Ed25519HDKeyPair keyPair;

  setUp(() async {
    keyPair = await Ed25519HDKeyPair.random();

    client = await EspressoCashClient.create(
      baseUrl: baseUrl,
      port: port,
      sign: (message) async {
        final signedMessage = await keyPair.sign(message);
        return signedMessage.toBase58();
      },
      walletAddress: keyPair.address,
      secure: true,
    );
  });

  tearDown(() async {
    await client.dispose();
  });

  test('creates client successfully', () {
    expect(client, isNotNull);
    expect(client.walletAddress, equals(keyPair.address));
  });

  test('fetches rates from backend', () async {
    final rate = await client.getRates();

    expect(rate.usdc, isA<double>());
  });

  test('updates user wallet country', () async {
    await client.updateUserWalletCountry('US');
  });

  test('creates short link', () async {
    final fullLink =
        'https://pay.espressocash.com/?t=espressopay&recipient=5ZQdTQvHEWkgYWP17JcERQ4VPuGnPb2LmW5BYzXWVSRg&amount=50&spl-token=EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v&reference=B3hEXqhQdQ7NH48nDmhBqt8n4W74wjTDE686prKoVJXm';

    final result = await client.shortenLink(
      ShortenLinkRequestDto(fullLink: fullLink),
    );

    print(result);

    expect(result.shortLink, isA<String>());
  });

  test('unshortens link', () async {
    final shortLink =
        'https://pay.espressocash.com/?s=7ec8ca685976c4062db58ae8536901f7';

    final result = await client.expandLink(
      UnshortenLinkRequestDto(shortLink: shortLink),
    );

    print(result);
  });
}
