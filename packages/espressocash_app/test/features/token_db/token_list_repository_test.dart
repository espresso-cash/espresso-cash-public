import 'package:espressocash_app/data/db/db.dart';
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

    const tokenRow2 = TokenRow(
      chainId: 2,
      address: 'address2',
      symbol: 'SYM2',
      name: 'Token2',
      decimals: 3,
      logoURI: 'uri2',
      tags: [],
      extensions: null,
    );

    when(mockTokenDao.insertToken(tokenRow))
        .thenAnswer((_) async => Future.value());
    when(mockTokenDao.getAllTokens()).thenAnswer((_) async => [tokenRow]);

    await mockTokenDao.insertToken(tokenRow);

    final List<TokenRow> resultOne = await mockTokenDao.getAllTokens();

    when(mockTokenDao.insertToken(tokenRow2))
        .thenAnswer((_) async => Future.value());
    when(mockTokenDao.getAllTokens())
        .thenAnswer((_) async => [tokenRow, tokenRow2]);

    await mockTokenDao.insertToken(tokenRow2);

    final List<TokenRow> resultTwo = await mockTokenDao.getAllTokens();

    verify(mockTokenDao.insertToken(tokenRow)).called(1);
    verify(mockTokenDao.insertToken(tokenRow2)).called(1);
    verify(mockTokenDao.getAllTokens()).called(2);

    expect(resultOne.length, 1);
    expect(resultTwo.length, 2);
    expect(resultOne, [tokenRow]);
    expect(resultTwo, [tokenRow, tokenRow2]);
  });

  test('should insert a token', () async {
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

    const tokenRow2 = TokenRow(
      chainId: 2,
      address: 'address2',
      symbol: 'SYM2',
      name: 'Token2',
      decimals: 3,
      logoURI: 'uri2',
      tags: [],
      extensions: null,
    );

    when(mockTokenDao.insertToken(tokenRow))
        .thenAnswer((_) async => Future.value());
    when(mockTokenDao.getAllTokens()).thenAnswer((_) async => [tokenRow]);

    await mockTokenDao.insertToken(tokenRow);

    final List<TokenRow> resultOne = await mockTokenDao.getAllTokens();

    when(mockTokenDao.insertToken(tokenRow2))
        .thenAnswer((_) async => Future.value());
    when(mockTokenDao.getAllTokens())
        .thenAnswer((_) async => [tokenRow, tokenRow2]);

    await mockTokenDao.insertToken(tokenRow2);

    final List<TokenRow> resultTwo = await mockTokenDao.getAllTokens();

    verify(mockTokenDao.insertToken(tokenRow)).called(1);
    verify(mockTokenDao.insertToken(tokenRow2)).called(1);
    verify(mockTokenDao.getAllTokens()).called(2);

    expect(resultOne.length, 1);
    expect(resultTwo.length, 2);
    expect(resultOne, [tokenRow]);
    expect(resultTwo, [tokenRow, tokenRow2]);
  });
}
