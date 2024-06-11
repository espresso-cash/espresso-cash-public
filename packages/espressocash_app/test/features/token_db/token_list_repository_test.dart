import 'package:espressocash_app/data/db/db.dart';
import 'package:espressocash_app/features/tokens/data/token_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'mocks.mocks.dart';

void main() {
  late MockMyDatabase mockDatabase;
  late TokenListRepository repository;

  setUp(() {
    mockDatabase = MockMyDatabase();
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

    when(repository.getAllTokens()).thenAnswer((_) async => tokens);

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

    when(repository.insertToken(tokenRow))
        .thenAnswer((_) async => Future.value());
    when(repository.getAllTokens()).thenAnswer((_) async => [tokenRow]);

    await repository.insertToken(tokenRow);

    final List<TokenRow> resultOne = await repository.getAllTokens();

    when(repository.insertToken(tokenRow2))
        .thenAnswer((_) async => Future.value());
    when(repository.getAllTokens())
        .thenAnswer((_) async => [tokenRow, tokenRow2]);

    await repository.insertToken(tokenRow2);

    final List<TokenRow> resultTwo = await repository.getAllTokens();

    verify(repository.insertToken(tokenRow)).called(1);
    verify(repository.insertToken(tokenRow2)).called(1);
    verify(repository.getAllTokens()).called(2);

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

    when(repository.insertToken(tokenRow))
        .thenAnswer((_) async => Future.value());
    when(repository.getAllTokens()).thenAnswer((_) async => [tokenRow]);

    await repository.insertToken(tokenRow);

    final List<TokenRow> resultOne = await repository.getAllTokens();

    when(repository.insertToken(tokenRow2))
        .thenAnswer((_) async => Future.value());
    when(repository.getAllTokens())
        .thenAnswer((_) async => [tokenRow, tokenRow2]);

    await repository.insertToken(tokenRow2);

    final List<TokenRow> resultTwo = await repository.getAllTokens();

    verify(repository.insertToken(tokenRow)).called(1);
    verify(repository.insertToken(tokenRow2)).called(1);
    verify(repository.getAllTokens()).called(2);

    expect(resultOne.length, 1);
    expect(resultTwo.length, 2);
    expect(resultOne, [tokenRow]);
    expect(resultTwo, [tokenRow, tokenRow2]);
  });
}
