import 'package:espressocash_app/features/tokens/data/token_dto.dart';
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

  test('should fetch all tokens', () async {
    final tokens = [
      const TokenDTO(
        chainId: 1,
        address: 'address1',
        symbol: 'SYM1',
        name: 'Token1',
        decimals: 2,
        logoURI: 'uri',
        tags: [],
        extensions: null,
      ),
    ];
    when(mockRepository.getAllTokens()).thenAnswer((_) async => tokens);

    final result = await service.getAllTokens();

    expect(result.length, tokens.length);
  });

  test('should initialize database with JSON', () async {
    final json = {
      'tokens': [
        {
          'chainId': 1,
          'address': 'address1',
          'symbol': 'SYM1',
          'name': 'Token1',
          'decimals': 2,
          'logoURI': 'uri',
          'tags': [],
          'extensions': null
        }
      ]
    };

    await service.initializeDatabaseWithJson(json);

    verify(mockRepository.clearAllTokens()).called(1);
    verify(mockRepository.insertToken(any)).called(1);
  });

  // Add more tests for other methods
}
