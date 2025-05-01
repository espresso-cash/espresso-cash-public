import 'package:ec_client_dart/ec_client_dart.dart';
import 'package:solana/solana.dart';
import 'package:test/test.dart';

const baseUrl = 'localhost';
const port = 8080;

void main() {
  late EspressoCashClient client;
  late Ed25519HDKeyPair solanaKeyPair;

  const stellarAddress =
      'GBBNXUPR3X7Z63FLLSHN3OV3TDSEGVZC2BVO6AMDPD5HFB5QIGXZVC6Z';

  setUp(() async {
    solanaKeyPair = await Ed25519HDKeyPair.random();

    client = await EspressoCashClient.create(
      baseUrl: baseUrl,
      port: port,
      sign: (message) async {
        final signedMessage = await solanaKeyPair.sign(message);
        return signedMessage.toBase58();
      },
      walletAddress: solanaKeyPair.address,
      secure: false,
    );
  });

  tearDown(() async {
    await client.dispose();
  });

  test('sign Moneygram challenge successfully', () async {
    const mockSignedTx =
        'AAAAAgAAAAD62jCX+vB7muIA+PNb6RsdTGhqibHb5OmXUObU41CTgwAAASwAAAAAAAAAAAAAAAEAAAAAaAXPYQAAAABoBdLlAAAAAAAAAAMAAAABAAAAAJgrKnfbk7sOrkFB8IEUpq/KLXIzXkoh7d6lIVL4yMUfAAAACgAAABpzdGVsbGFyLm1vbmV5Z3JhbS5jb20gYXV0aAAAAAAAAQAAAEBRQmdwQnI2MUJTUmxETmtNQU1BazZMWE4yZlVPbm9Xb3hXYlVvK1VKdTdvZmRWY3ByMERCYk5BV0pXclVLUkZFAAAAAQAAAAD62jCX+vB7muIA+PNb6RsdTGhqibHb5OmXUObU41CTgwAAAAoAAAAPd2ViX2F1dGhfZG9tYWluAAAAAAEAAAAVc3RlbGxhci5tb25leWdyYW0uY29tAAAAAAAAAQAAAABEeJtKKH/+u/cPE07wmM5VZvBY9bmdVjntawLTEvU9fgAAAAoAAAANY2xpZW50X2RvbWFpbgAAAAAAAAEAAAAQZXNwcmVzc29jYXNoLmNvbQAAAAAAAAAB41CTgwAAAECNLoqeuLTHNNErrsVXpMiODszX204F+0owqrrXzQTTYPy6AmcAA8tM/KiDb2aFUSTrmcZV5Cd2FFopv3fpIZUA';

    final request = MoneygramChallengeSignRequestDto(
      signedTx: mockSignedTx,
    );

    final response = await client.signChallenge(request);

    print('Signed challenge transaction: $response');

    expect(response, isA<MoneygramChallengeSignResponseDto>());
    expect(response.signedTx, isNotEmpty);
    expect(response.signedTx, isA<String>());

    print('Signed challenge transaction: ${response.signedTx}');
  });

  test('calculates Moneygram fee successfully', () async {
    final request = MoneygramFeeRequestDto(
      amount: '100.0',
      type: RampTypeDto.offRamp,
    );

    final response = await client.calculateMoneygramFee(request);

    print('Calculated Moneygram fee: $response');

    expect(response, isA<MoneygramFeeResponseDto>());
    expect(response.bridgeFee, isNotEmpty);
    expect(response.moneygramFee, isNotEmpty);

    if (response.gasFeeInUsdc != null) {
      expect(response.gasFeeInUsdc, isNotEmpty);
    }
  });

  test('creates swap to Stellar transaction successfully', () async {
    final request = SwapToStellarRequestDto(
      solanaSenderAddress: solanaKeyPair.address,
      stellarReceiverAddress: stellarAddress,
      amount: '10.0',
      priorityFee: 5000,
    );

    final response = await client.swapToStellar(request);

    expect(response, isA<MoneygramSwapResponseDto>());
    expect(response.encodedTx, isNotEmpty);
    expect(response.encodedTx, isA<String>());

    print('Generated Swap to Stellar transaction: ${response.encodedTx}');
  });

  test('creates swap to Solana transaction successfully', () async {
    final request = SwapToSolanaRequestDto(
      stellarSenderAddress: stellarAddress,
      solanaReceiverAddress: solanaKeyPair.address,
      amount: '10.0',
    );

    final response = await client.swapToSolana(request);

    expect(response, isA<MoneygramSwapResponseDto>());
    expect(response.encodedTx, isNotEmpty);
    expect(response.encodedTx, isA<String>());

    print('Generated Swap to Solana transaction: ${response.encodedTx}');
  });

  test('funds XLM account successfully', () async {
    final request = FundXlmRequestDto(
      accountId: stellarAddress,
    );

    await client.fundXlmRequest(request);
  });
}
