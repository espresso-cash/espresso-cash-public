import 'package:espressocash_app/features/tokens/data/token_dto.dart';
import 'package:espressocash_app/features/tokens/token_list.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'mocks.mocks.dart';

void main() {
  late MockTokenService mockService;
  late TokenList tokenList;

  setUp(() {
    mockService = MockTokenService();
    tokenList = TokenList(
      chainId: 1,
      service: mockService,
    );
  });

  test('should initialize and populate database', () async {
    final tokens = <TokenDTO>[];
    when(mockService.getAllTokens()).thenAnswer((_) async => tokens);

    await tokenList.initialize();

    verify(mockService.getAllTokens()).called(1);
    verify(mockService.initializeDatabaseWithJson(any)).called(1);
  });

  test('should find token by mint', () async {
    const tokenDTO = TokenDTO(
      chainId: 1,
      address: 'address1',
      symbol: 'SYM1',
      name: 'Token1',
      decimals: 2,
      logoURI: 'uri',
      tags: [],
      extensions: null,
    );
    when(mockService.getAllTokens()).thenAnswer((_) async => [tokenDTO]);

    await tokenList.initialize();
    final result = tokenList.findTokenByMint('address1');

    expect(result, tokenDTO);
  });

  // Add more tests for other methods
}
