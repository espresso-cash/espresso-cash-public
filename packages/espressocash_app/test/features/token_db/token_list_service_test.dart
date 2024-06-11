import 'package:espressocash_app/features/tokens/services/token_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'mocks.mocks.dart';

void main() {
  late MockTokenListRepository mockRepository;
  late TokenService service;

  setUp(() {
    mockRepository = MockTokenListRepository();
    service = TokenService(mockRepository);
  });

  test('should initialize database from CSV file', () async {
    await service.initializeDatabaseFromCsvFile(
      'lib/features/tokens/solana.tokenlist.csv',
    );

    verify(mockRepository.clearAllTokens()).called(1);
    verify(mockRepository.insertToken(any)).called(1);
  });

  // Add more tests for other methods
}
