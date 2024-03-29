import 'package:solana/solana_pay.dart';
import 'package:test/test.dart';

void main() {
  group('TransactionRequestInfo', () {
    test('fromJson returns correct object', () {
      final json = {
        'label': 'Test Label',
        'icon': 'https://example.com/image.png',
      };
      final info = TransactionRequestInfo.fromJson(json);
      expect(info.label, equals('Test Label'));
      expect(info.icon, equals('https://example.com/image.png'));
    });
  });

  group('TransactionRequestResponse', () {
    test('fromJson returns correct object', () {
      final json = {'transaction': 'abc123', 'message': 'Test message'};
      final response = TransactionRequestResponse.fromJson(json);
      expect(response.transaction, equals('abc123'));
      expect(response.message, equals('Test message'));
    });

    test('fromJson returns object with null message if not present', () {
      final json = {'transaction': 'abc123'};
      final response = TransactionRequestResponse.fromJson(json);
      expect(response.transaction, equals('abc123'));
      expect(response.message, isNull);
    });
  });

  group('Exception toString', () {
    test('CreateTransactionException toString', () {
      const exception = CreateTransactionException('Error message');
      expect(exception.toString(), 'CreateTransactionException(Error message)');
    });

    test('ParseUrlException toString', () {
      const exception = ParseUrlException('Error message');
      expect(exception.toString(), 'ParseUrlException(Error message)');
    });

    test('ValidateTransactionException toString', () {
      const exception = ValidateTransactionException('Error message');
      expect(
        exception.toString(),
        'ValidateTransactionException(Error message)',
      );
    });

    test('FetchTransactionException toString', () {
      const exception = FetchTransactionException('Error message');
      expect(exception.toString(), 'FetchTransactionException(Error message)');
    });
  });
}
