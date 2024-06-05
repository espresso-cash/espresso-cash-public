import 'package:espressocash_app/data/db/db.dart';
import 'package:espressocash_app/features/tokens/data/token_dto.dart';
import 'package:espressocash_app/features/tokens/data/token_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'mocks.mocks.dart';

void main() {
  late MockMyDatabase mockDatabase;
  late MockTokenDao mockTokenDao;
  late TokenListRepository repository;

  setUp(() {
    mockDatabase = MockMyDatabase();
    mockTokenDao = MockTokenDao();
    when(mockDatabase.tokenDao).thenReturn(mockTokenDao);
    repository = TokenListRepository(mockDatabase);
  });

  test('should fetch all tokens', () async {
    final tokens = [
      const TokenRow(
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
    when(mockTokenDao.getAllTokens()).thenAnswer((_) async => tokens);

    final result = await repository.getAllTokens();

    expect(result.length, tokens.length);
  });

  test('should insert a token', () async {
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

    const tokenRow = TokenRow(
      chainId: 1,
      address: 'address1',
      symbol: 'SYM1',
      name: 'Token1',
      decimals: 2,
      logoURI: 'uri',
      tags: [],
      extensions: null,
    );

    when(mockTokenDao.insertToken(any)).thenAnswer((_) async => Future.value());

    await repository.insertToken(tokenDTO);

    verify(mockTokenDao.insertToken(tokenRow)).called(1);
  });

  // Add more tests for other methods
}
