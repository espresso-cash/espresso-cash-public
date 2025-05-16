import 'package:ec_client_dart/ec_client_dart.dart';
import 'package:solana/solana.dart';
import 'package:test/test.dart';

import 'utils.dart';

void main() {
  late EspressoCashClient client;
  late Ed25519HDKeyPair keyPair;

  setUp(() async {
    keyPair = await Ed25519HDKeyPair.random();
    client = await createClient(keyPair: keyPair, local: true);
    await client.login();
  });

  tearDown(() async {
    await client.dispose();
  });

  test('calls token swap', skip: true, () async {
    const request = SwapRouteRequestDto(
      inputToken: 'EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v',
      outputToken: 'So11111111111111111111111111111111111111112',
      amount: '5000000',
      match: SwapMatchDto.inAmount,
      slippage: SwapSlippageDto.zpFive,
    );

    final response = await client.swap(request);

    expect(response.inAmount, isA<String>());
    expect(response.outAmount, isA<String>());
    expect(response.amount, isA<String>());
    expect(response.encodedTx, isA<String>());
    expect(response.feeInUsdc, isA<int>());
    expect(response.slot, isA<BigInt>());
    expect(response.slippageBps, isA<int>());
    expect(response.platformFeeBps, isA<int>());
    expect(response.priceImpact, isA<String>());
    expect(response.providerLabel, isA<String>());
  });
}
