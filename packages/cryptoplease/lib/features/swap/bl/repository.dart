import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:decimal/decimal.dart';
import 'package:injectable/injectable.dart';

@injectable
class JupiterRepository {
  JupiterRepository({
    required JupiterAggregatorClient jupiterAggregatorClient,
  }) : _jupiterClient = jupiterAggregatorClient;

  final JupiterAggregatorClient _jupiterClient;

  Future<bool> routeExists(Token input, Token output) async {
    const dto = IndexedRouteMapRequestDto();
    final routeMap = await _jupiterClient.getIndexedRouteMap(dto);
    final mintKeys = routeMap.mintKeys;
    final outputIndex = mintKeys.indexOf(output.forJupiter.address);
    final inputIndex = mintKeys.indexOf(input.forJupiter.address).toString();

    return routeMap.indexedRouteMap[inputIndex]?.contains(outputIndex) ?? false;
  }

  Future<List<JupiterRoute>> findRoutes({
    required CryptoAmount amount,
    required Token inputToken,
    required Token outputToken,
    required Decimal slippage,
    required String userPublickKey,
  }) async {
    final swapMode =
        amount.token == inputToken ? SwapMode.exactIn : SwapMode.exactOut;
    final requestDto = QuoteRequestDto(
      amount: amount.value.toString(),
      inputMint: inputToken.forJupiter.address,
      outputMint: outputToken.forJupiter.address,
      slippageBps: slippage.ceil().toDouble().toInt() * 100,
      swapMode: swapMode,
      userPublicKey: userPublickKey,
    );
    final responseDto = await _jupiterClient.getQuote(requestDto);

    return responseDto.routes;
  }
}

extension on Token {
  Token get forJupiter => this == Token.sol ? Token.wrappedSol : this;
}
