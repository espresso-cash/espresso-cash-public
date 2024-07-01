import 'package:espressocash_app/data/db/db.dart';
import 'package:espressocash_app/features/tokens/data/token_repository.dart';
import 'package:espressocash_app/features/tokens/token.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

import 'token_list_repository_test.mocks.dart';

@GenerateMocks([TokenListRepository])
void main() {
  final MemoryTokenRepository memoryRepo = MemoryTokenRepository();
  final MockTokenListRepository mockRepo = MockTokenListRepository();

  group('mocked test', () {
    test('should initialize database from CSV file', () async {
      when(mockRepo.initialize()).thenAnswer((_) async {});

      await mockRepo.initialize();

      verify(mockRepo.initialize()).called(1);
    });

    test('should get a token', () async {
      const token = TokenRow(
        address: 'So00000000000',
        chainId: 101,
        symbol: 'SOL',
        name: 'Solana',
        decimals: 18,
        logoURI: 'https://example.com',
        tags: [],
        extensions: null,
      );

      when(mockRepo.getToken('So00000000000'))
          .thenAnswer((_) async => token.toModel());

      final Token? response = await mockRepo.getToken('So00000000000');

      verify(
        mockRepo.getToken('So00000000000'),
      ).called(1);

      expect(response, token.toModel());
    });

    test('should insert a token', () async {
      const token = TokenRow(
        address: 'So00000000002',
        chainId: 101,
        symbol: 'SOL',
        name: 'Solana',
        decimals: 18,
        logoURI: 'https://example.com',
        tags: [],
        extensions: null,
      );

      when(mockRepo.insertToken(token)).thenAnswer((_) async => 1);

      final int response = await mockRepo.insertToken(token);

      verify(
        mockRepo.insertToken(token),
      ).called(1);

      expect(response, 1);
    });

    test('should insert multiple tokens', () async {
      final tokens = [
        const TokenRow(
          address: 'So00000000003',
          chainId: 101,
          symbol: 'SOL',
          name: 'Solana',
          decimals: 18,
          logoURI: 'https://example.com',
          tags: [],
          extensions: null,
        ),
        const TokenRow(
          address: 'So00000000004',
          chainId: 101,
          symbol: 'SOL',
          name: 'Solana',
          decimals: 18,
          logoURI: 'https://example.com',
          tags: [],
          extensions: null,
        ),
      ];
      when(mockRepo.insertTokens(tokens)).thenAnswer((_) async => 2);

      await mockRepo.insertTokens(tokens);

      verify(
        mockRepo.insertTokens(tokens),
      ).called(1);
    });

    test('should update a token', () async {
      const token = TokenRow(
        address: 'So00000000000',
        chainId: 101,
        symbol: 'SOL',
        name: 'Solana',
        decimals: 18,
        logoURI: 'https://example.com',
        tags: [],
        extensions: null,
      );
      when(mockRepo.updateToken(token)).thenAnswer((_) async {});

      await mockRepo.updateToken(token);

      verify(mockRepo.updateToken(token)).called(1);
    });

    test('should delete a token', () async {
      const token = TokenRow(
        address: 'So00000000000',
        chainId: 101,
        symbol: 'SOL',
        name: 'Solana',
        decimals: 18,
        logoURI: 'https://example.com',
        tags: [],
        extensions: null,
      );
      when(mockRepo.deleteToken(token)).thenAnswer((_) async {});

      await mockRepo.deleteToken(token);

      verify(mockRepo.deleteToken(token)).called(1);
    });

    test('should dispose repository', () async {
      when(mockRepo.onDispose()).thenAnswer((_) async {});

      await mockRepo.onDispose();

      verify(mockRepo.onDispose()).called(1);
    });

    test('should parse and load token rows from CSV chunk', () {
      const chunk =
          'address,chainId,symbol,name,decimals,logoURI,tags,extensions\n'
          'So00000000000,101,SOL,Solana,18,https://example.com,,\n';

      const expectedToken = TokenRow(
        address: 'So00000000000',
        chainId: 101,
        symbol: 'SOL',
        name: 'Solana',
        decimals: 18,
        logoURI: 'https://example.com',
        tags: null,
        extensions: null,
      );

      final result = parseChunk(chunk);

      expect(result.length, 1);
      expect(result[0], expectedToken);
    });
  });
  group('memory test', () {
    test('should initialize database from CSV file', () async {
      const token = TokenRow(
        address: 'So00000000000',
        chainId: 101,
        symbol: 'SOL',
        name: 'Solana',
        decimals: 18,
        logoURI: 'https://example.com',
        tags: [],
        extensions: null,
      );

      await memoryRepo.initialize();

      final Token? response = await memoryRepo.getToken('So00000000000');

      expect(response, token.toModel());
    });

    test('should get a token', () async {
      const token = TokenRow(
        address: 'So00000000000',
        chainId: 101,
        symbol: 'SOL',
        name: 'Solana',
        decimals: 18,
        logoURI: 'https://example.com',
        tags: null,
        extensions: null,
      );

      await memoryRepo.getToken('So00000000000');

      final Token? response = await memoryRepo.getToken('So00000000000');

      expect(response, token.toModel());
    });

    test('should insert a token', () async {
      const token = TokenRow(
        address: 'So00000000002',
        chainId: 101,
        symbol: 'SOL',
        name: 'Solana',
        decimals: 18,
        logoURI: 'https://example.com',
        tags: [],
        extensions: null,
      );

      await memoryRepo.insertToken(token);

      final int response = await memoryRepo.insertToken(token);

      expect(response, 1);

      final Token? responseToken = await memoryRepo.getToken('So00000000002');

      expect(responseToken, token.toModel());
    });

    test('should insert multiple tokens', () async {
      final tokens = [
        const TokenRow(
          address: 'So00000000003',
          chainId: 101,
          symbol: 'SOL',
          name: 'Solana',
          decimals: 18,
          logoURI: 'https://example.com',
          tags: [],
          extensions: null,
        ),
        const TokenRow(
          address: 'So00000000004',
          chainId: 101,
          symbol: 'SOL',
          name: 'Solana',
          decimals: 18,
          logoURI: 'https://example.com',
          tags: [],
          extensions: null,
        ),
      ];
      await memoryRepo.insertTokens(tokens);

      final Token? responseToken1 = await memoryRepo.getToken('So00000000003');

      expect(responseToken1, tokens[0].toModel());

      final Token? responseToken2 = await memoryRepo.getToken('So00000000004');

      expect(responseToken2, tokens[1].toModel());
    });

    test('should update a token', () async {
      const token = TokenRow(
        address: 'So00000000000',
        chainId: 101,
        symbol: 'SOL',
        name: 'Solana',
        decimals: 18,
        logoURI: 'https://example2.com',
        tags: [],
        extensions: null,
      );
      await memoryRepo.updateToken(token);

      final Token? response = await memoryRepo.getToken('So00000000000');

      expect(response, token.toModel());
    });

    test('should delete a token', () async {
      const token = TokenRow(
        address: 'So00000000000',
        chainId: 101,
        symbol: 'SOL',
        name: 'Solana',
        decimals: 18,
        logoURI: 'https://example.com',
        tags: [],
        extensions: null,
      );
      await memoryRepo.deleteToken(token);

      final Token? response = await memoryRepo.getToken('So00000000000');

      expect(null, response);
    });

    test('should parse and load token rows from CSV chunk', () {
      const chunk =
          'address,chainId,symbol,name,decimals,logoURI,tags,extensions\n'
          'So00000000000,101,SOL,Solana,18,https://example.com,,\n';

      const expectedToken = TokenRow(
        address: 'So00000000000',
        chainId: 101,
        symbol: 'SOL',
        name: 'Solana',
        decimals: 18,
        logoURI: 'https://example.com',
        tags: null,
        extensions: null,
      );

      final result = parseChunk(chunk);

      expect(result.length, 1);
      expect(result[0], expectedToken);
    });
  });
}

List<TokenRow> parseChunk(String chunk) {
  final List<TokenRow> tokenIterable = [];
  final List<String> lines = chunk.split('\n');
  for (int i = 1; i < lines.length; i++) {
    final line = lines[i];
    if (line.trim().isEmpty) continue;
    final values = line.split(',');
    if (values.length < 8) continue;
    final tags = parseTags(values[6]);
    final extensions = parseExtensions(values[7]);

    tokenIterable.add(
      TokenRow(
        address: values[0],
        chainId: int.parse(values[1]),
        symbol: values[2],
        name: values[3],
        decimals: int.parse(values[4]),
        logoURI: values[5],
        tags: tags,
        extensions: extensions,
      ),
    );
  }

  return tokenIterable;
}

List<String>? parseTags(String? tagString) {
  if (tagString == null || tagString.isEmpty) return null;

  return tagString
      .replaceAll('[', '')
      .replaceAll(']', '')
      .split(',')
      .map((e) => e.trim())
      .toList();
}

Extensions? parseExtensions(String? extensionString) {
  final List<String>? parts = extensionString?.split(':');

  return (parts != null && parts.length == 2 && parts[0] == 'coingeckoId')
      ? Extensions(coingeckoId: parts[1])
      : null;
}

typedef TokenMap = IMap<String, TokenRow>;

class MemoryTokenRepository implements TokenListRepository {
  final data = BehaviorSubject<TokenMap>.seeded(TokenMap());

  @override
  Future<int> insertToken(TokenRow token) async {
    data.add(data.value.add(token.address, token));
    return 1;
  }

  @override
  Future<dynamic> insertTokens(Iterable<TokenRow> tokens) async {
    data.add(
      data.value
          .addAll(IMap.fromEntries(tokens.map((e) => MapEntry(e.address, e)))),
    );

    return tokens.length;
  }

  @override
  Future<Token?> getToken(String address) async =>
      data.value[address]?.toModel();

  @override
  Future<void> updateToken(TokenRow token) async {
    data.add(data.value.add(token.address, token));
  }

  @override
  Future<void> deleteToken(TokenRow token) async {
    data.add(data.value.remove(token.address));
  }

  @override
  Future<void> initialize() async {
    const chunk =
        'address,chainId,symbol,name,decimals,logoURI,tags,extensions\n'
        'So00000000000,101,SOL,Solana,18,https://example.com,,\n';

    final tokenRows = parseChunk(chunk);
    await insertTokens(tokenRows);
  }

  @override
  Future<void> onDispose() async {
    data.add(data.value.clear());
  }
}
