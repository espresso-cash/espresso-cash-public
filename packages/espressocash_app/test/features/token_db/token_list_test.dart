import 'package:espressocash_app/features/tokens/data/token_dto.dart';
import 'package:espressocash_app/features/tokens/token.dart';
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
    //(mockService.getAllTokens()).thenAnswer((_) async => serviceList);

    await tokenList.initialize();

    //print(tokenList.tokens.length);

    //final List<TokenDTO> response = await mockService.getAllTokens();

    //response.forEach((element) => print(element.toJson()));

    verify(mockService.tokenRepository.getAllTokens()).called(4);

    //verify(mockService.initializeDatabaseWithJson(any)).called(2);
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

    const List<TokenDTO> tokens = [tokenDTO];

    //await tokenList.service?.tokenRepository.insertToken(tokenDTO);

    // when(
    //   mockService.insertToken(tokenDTO),
    // ).thenAnswer(
    //   (_) => Future.value(),
    // );

    // when(
    //   mockService.findTokenByMint('address1', tokens),
    // ).thenAnswer(
    //   (_) => tokenDTO,
    // );

    final result = tokenList.service?.findTokenByMint('address1', tokens);
    //final result2 = tokenList.findTokenByMint('address1');

    verify(mockService.findTokenByMint('address1', tokens)).called(1);

    expect(result, Token.fromJson(tokenDTO.toJson()));
  });

  // Add more tests for other methods
}
