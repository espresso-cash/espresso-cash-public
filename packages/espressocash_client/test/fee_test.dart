import 'package:ec_client_dart/ec_client_dart.dart';
import 'package:solana/solana.dart';
import 'package:test/test.dart';

import 'utils.dart';

void main() {
  late EspressoCashClient client;
  late Ed25519HDKeyPair walletKeyPair;

  setUp(() async {
    walletKeyPair = await Ed25519HDKeyPair.random();
    client = await createClient(keyPair: walletKeyPair);
    await client.login();
  });

  tearDown(() async {
    await client.dispose();
  });

  test('gets direct payment quote successfully', skip: true, () async {
    final receiverKeyPair = await Ed25519HDKeyPair.random();
    final request = DirectPaymentQuoteRequestDto(
      receiverAccount: receiverKeyPair.address,
      amount: 100_000,
      mintAddress: 'So11111111111111111111111111111111111111112',
    );

    final response = await client.getDirectPaymentQuote(request);

    expect(response, isA<DirectPaymentQuoteResponseDto>());
    expect(response.fee, isA<int>());
    expect(response.totalAmount, isA<int>());
    expect(response.fee, greaterThanOrEqualTo(0));
    expect(response.totalAmount, greaterThan(request.amount));
  });

  test('gets outgoing escrow payment quote successfully', skip: true, () async {
    final response = await client.getOutgoingEscrowPaymentQuote();

    expect(response, isA<EscrowPaymentQuoteResponseDto>());
    expect(response.fee, isA<int>());
    expect(response.fee, greaterThanOrEqualTo(0));
  });

  test('gets incoming escrow payment quote successfully', skip: true, () async {
    final response = await client.getIncomingEscrowPaymentQuote();

    expect(response, isA<EscrowPaymentQuoteResponseDto>());
    expect(response.fee, isA<int>());
    expect(response.fee, greaterThanOrEqualTo(0));
  });
}
