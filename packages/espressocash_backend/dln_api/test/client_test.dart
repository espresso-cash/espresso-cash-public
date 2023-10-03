import 'package:dln_api/src/client.dart';
import 'package:dln_api/src/models/dto.dart';
import 'package:test/test.dart';

void main() {
  group('DlnApiClient - ', () {
    test('create instance', () {
      final client = DlnApiClient();
      expect(client, isNotNull);
    });

    test('getQuote', () async {
      final client = DlnApiClient();

      final quote = await client.getQuote(
        const QuoteRequestDto(
          srcChainId: '56',
          srcChainTokenIn: '0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d',
          srcChainTokenInAmount: '100000000000000000000',
          dstChainId: '43114',
          dstChainTokenOut: '0x9702230A8Ea53601f5cD2dc00fDBc13d4dF4A8c7',
        ),
      );

      expect(quote, isNotNull);
      expect(quote, isA<QuoteResponseDto>());
    });

    test('createTx', () async {
      final client = DlnApiClient();

      final createTx = await client.createTx(
        const CreateTxRequestDto(
          srcChainId: '56',
          srcChainTokenIn: '0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d',
          srcChainTokenInAmount: '100722632000000000000',
          dstChainId: '43114',
          dstChainTokenOut: '0x9702230A8Ea53601f5cD2dc00fDBc13d4dF4A8c7',
          dstChainTokenOutAmount: '99623050',
          dstChainTokenOutRecipient:
              '0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045',
          srcChainOrderAuthorityAddress:
              '0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045',
          dstChainOrderAuthorityAddress:
              '0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045',
        ),
      );

      expect(createTx, isNotNull);
      expect(createTx, isA<CreateTxResponseDto>());
    });

    test('getStatus', () async {
      final client = DlnApiClient();

      final status = await client.getStatus(
        '0x9ee6c3d0aa68a7504e619b02df7c71539d0ce10e27f593bf8604b62e51955a01',
      );

      expect(status, isNotNull);
      expect(status, isA<OrderStatusResponseDto>());
    });

    test('getOrder', () async {
      final client = DlnApiClient();

      final status = await client.getOrder(
        '0x9ee6c3d0aa68a7504e619b02df7c71539d0ce10e27f593bf8604b62e51955a01',
      );

      expect(status, isNotNull);
      expect(status, isA<OrderResponseDto>());
    });

    test('getOrderIdByHash', () async {
      final client = DlnApiClient();

      final status = await client.getOrderIdByHash(
        '0x40ee524d5bb9c4ecd8e55d23c66c5465a3f137be7ae24df366c3fd06daf7de7e',
      );

      expect(status, isNotNull);
      expect(status, isA<OrderIdTxResponseDto>());
    });
  });
}
