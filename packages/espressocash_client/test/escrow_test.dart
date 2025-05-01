import 'package:ec_client_dart/ec_client_dart.dart';
import 'package:solana/solana.dart';
import 'package:test/test.dart';

const baseUrl = 'grpc-demo.espressocash.com';
const port = 443;

void main() {
  late EspressoCashClient client;
  late Ed25519HDKeyPair senderKeyPair;
  late Ed25519HDKeyPair escrowKeyPair;

  setUp(() async {
    senderKeyPair = await Ed25519HDKeyPair.random();

    escrowKeyPair = await Ed25519HDKeyPair.random();

    client = await EspressoCashClient.create(
      baseUrl: baseUrl,
      port: port,
      sign: (message) async {
        final signedMessage = await senderKeyPair.sign(message);

        return signedMessage.toBase58();
      },
      walletAddress: senderKeyPair.address,
      secure: true,
    );
  });

  tearDown(() async {
    await client.dispose();
  });

  test('creates escrow payment successfully', skip: true, () async {
    final request = CreatePaymentRequestDto(
      senderAccount: senderKeyPair.address,
      escrowAccount: escrowKeyPair.address,
      amount: 100000,
    );

    final response = await client.createPaymentEc(request);

    expect(response, isA<CreatePaymentResponseDto>());
    expect(response.transaction, isNotEmpty);
    expect(response.transaction, isA<String>());
    expect(response.slot, isA<BigInt>());

    expect(response.slot, greaterThanOrEqualTo(BigInt.zero));
  });
}
