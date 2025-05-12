import 'package:ec_client_dart/ec_client_dart.dart';
import 'package:solana/solana.dart';
import 'package:test/test.dart';

import 'utils.dart';

void main() {
  late EspressoCashClient client;
  late Ed25519HDKeyPair keyPair;

  setUp(() async {
    keyPair = await Ed25519HDKeyPair.random();
    client = await createClient(keyPair: keyPair, local: false);
    await client.login();
  });

  tearDown(() async {
    await client.dispose();
  });

  group('DLN operations', () {
    test('gets outgoing DLN quote', skip: true, () async {
      const request = OutgoingQuoteRequestDto(
        amount: 100_000,
        receiverAddress: '0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d',
        receiverBlockchain: 'ethereum',
      );

      final response = await client.getOutgoingDlnQuote(request);

      expect(response.inputAmount, isA<int>());
      expect(response.receiverAmount, isA<int>());
      expect(response.encodedTx, isA<String>());
      expect(response.feeInUsdc, isA<int>());
      expect(response.slot, isA<BigInt>());
    });

    test('gets DLN order status', skip: true, () async {
      const request = OrderStatusDlnRequestDto(
        orderId: '0x9ee6c3d0aa68a7504e619b02df7c71539d0ce10e27f593bf8604b62e51955a01',
      );

      final response = await client.getDlnOrderStatus(request);

      expect(response.status, isA<DlnOrderStatus>());
    });

    test('gets DLN order ID', skip: true, () async {
      const request = OrderIdDlnRequestDto(
        txId: '0x40ee524d5bb9c4ecd8e55d23c66c5465a3f137be7ae24df366c3fd06daf7de7e',
      );

      final response = await client.getDlnOrderId(request);

      expect(response.orderId, isA<String?>());
    });

    test('gets gas fees', skip: true, () async {
      const request = GasFeeRequestDto(network: '1');

      final response = await client.getGasFees(request);

      expect(response.low, isA<GasFeeEstimate>());
      expect(response.medium, isA<GasFeeEstimate>());
      expect(response.high, isA<GasFeeEstimate>());
      expect(response.estimatedBaseFee, isA<String>());
      expect(response.networkCongestion, isA<double>());
    });

    test('gets incoming DLN quote', skip: true, () async {
      final request = IncomingQuoteRequestDto(
        amount: 1_000_000,
        senderAddress: '0x5CedA757A24bbA2507B3Ca74b590428EA02A2D5f',
        senderBlockchain: 'polygon',
        receiverAddress: 'CwLjY6mQxcCYnq7hgArJkCSxDb58yjZkWCiEYn385Aoa',
        solanaReferenceAddress: keyPair.publicKey.toBase58(),
      );

      final response = await client.getIncomingDlnQuote(request);

      expect(response.tx, isA<QuoteTx>());
      expect(response.tx.to, isA<String>());
      expect(response.tx.data, isA<String>());
      expect(response.tx.value, isA<int>());
      expect(response.usdcInfo, isA<QuoteUsdcInfo>());
      expect(response.usdcInfo.usdcAddress, isA<String>());
      expect(response.usdcInfo.approvalAmount, isA<int>());
      expect(response.inputAmount, isA<int>());
      expect(response.receiverAmount, isA<int>());
      expect(response.feeInUsdc, isA<int>());
    });
  });
}
