import 'package:ec_client_dart/ec_client_dart.dart';
import 'package:solana/solana.dart';
import 'package:test/test.dart';

import 'utils.dart';

const stellarAddress = 'GBBNXUPR3X7Z63FLLSHN3OV3TDSEGVZC2BVO6AMDPD5HFB5QIGXZVC6Z';

void main() {
  late EspressoCashClient client;
  late Ed25519HDKeyPair solanaKeyPair;

  setUp(() async {
    solanaKeyPair = await Ed25519HDKeyPair.random();
    client = await createClient(keyPair: solanaKeyPair);
    await client.login();
  });

  tearDown(() async {
    await client.dispose();
  });

  test('sign Moneygram challenge successfully', skip: true, () async {
    const mockSignedTx =
        'AAAAAgAAAAD62jCX+vB7muIA+PNb6RsdTGhqibHb5OmXUObU41CTgwAAASwAAAAAAAAAAAAAAAEAAAAAaAXPYQAAAABoBdLlAAAAAAAAAAMAAAABAAAAAJgrKnfbk7sOrkFB8IEUpq/KLXIzXkoh7d6lIVL4yMUfAAAACgAAABpzdGVsbGFyLm1vbmV5Z3JhbS5jb20gYXV0aAAAAAAAAQAAAEBRQmdwQnI2MUJTUmxETmtNQU1BazZMWE4yZlVPbm9Xb3hXYlVvK1VKdTdvZmRWY3ByMERCYk5BV0pXclVLUkZFAAAAAQAAAAD62jCX+vB7muIA+PNb6RsdTGhqibHb5OmXUObU41CTgwAAAAoAAAAPd2ViX2F1dGhfZG9tYWluAAAAAAEAAAAVc3RlbGxhci5tb25leWdyYW0uY29tAAAAAAAAAQAAAABEeJtKKH/+u/cPE07wmM5VZvBY9bmdVjntawLTEvU9fgAAAAoAAAANY2xpZW50X2RvbWFpbgAAAAAAAAEAAAAQZXNwcmVzc29jYXNoLmNvbQAAAAAAAAAB41CTgwAAAECNLoqeuLTHNNErrsVXpMiODszX204F+0owqrrXzQTTYPy6AmcAA8tM/KiDb2aFUSTrmcZV5Cd2FFopv3fpIZUA';

    const request = MoneygramChallengeSignRequestDto(signedTx: mockSignedTx);

    final response = await client.signChallenge(request);

    expect(response, isA<MoneygramChallengeSignResponseDto>());
    expect(response.signedTx, isNotEmpty);
    expect(response.signedTx, isA<String>());
  });

  test('calculates Moneygram fee successfully', skip: true, () async {
    const request = MoneygramFeeRequestDto(amount: '100.0', type: RampTypeDto.offRamp);

    final response = await client.calculateMoneygramFee(request);

    expect(response, isA<MoneygramFeeResponseDto>());
    expect(response.bridgeFee, isNotEmpty);
    expect(response.moneygramFee, isNotEmpty);

    if (response.gasFeeInUsdc != null) {
      expect(response.gasFeeInUsdc, isNotEmpty);
    }
  });

  test('creates swap to Stellar transaction successfully', skip: true, () async {
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
  });

  test('creates swap to Solana transaction successfully', skip: true, () async {
    final request = SwapToSolanaRequestDto(
      stellarSenderAddress: stellarAddress,
      solanaReceiverAddress: solanaKeyPair.address,
      amount: '10.0',
    );

    final response = await client.swapToSolana(request);

    expect(response, isA<MoneygramSwapResponseDto>());
    expect(response.encodedTx, isNotEmpty);
    expect(response.encodedTx, isA<String>());
  });

  test('funds XLM account successfully', skip: true, () async {
    const request = FundXlmRequestDto(accountId: stellarAddress);

    await client.fundXlmRequest(request);
  });
}
