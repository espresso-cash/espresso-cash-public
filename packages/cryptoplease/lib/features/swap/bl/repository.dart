import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/core/tokens/token_list.dart';
import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:decimal/decimal.dart';
import 'package:solana/solana.dart';

class JupiterRepository {
  JupiterRepository({
    required JupiterAggregatorClient jupiterAggregatorClient,
    required SolanaClient solanaClient,
    required TokenList tokenList,
  })  : _jupiterClient = jupiterAggregatorClient,
        _solanaClient = solanaClient,
        _tokenList = tokenList;

  final JupiterAggregatorClient _jupiterClient;
  final SolanaClient _solanaClient;
  final TokenList _tokenList;

  Future<bool> routeExists(Token input, Token output) async {
    final routeMap = await _jupiterClient.getIndexedRouteMap();
    final mintKeys = routeMap.mintKeys;
    final outputIndex = mintKeys.indexOf(output.forJupiter.address);
    final inputIndex = mintKeys.indexOf(input.forJupiter.address).toString();

    return routeMap.indexedRouteMap[inputIndex]?.contains(outputIndex) ?? false;
  }

  Future<JupiterRoute> bestRoute({
    required CryptoAmount amount,
    required Token inputToken,
    required Token outputToken,
    required Decimal slippage,
  }) async {
    final swapMode =
        amount.token == inputToken ? SwapMode.exactIn : SwapMode.exactOut;
    final requestDto = QuoteRequestDto(
      amount: amount.value,
      inputMint: inputToken.forJupiter.address,
      outputMint: outputToken.forJupiter.address,
      slippage: slippage.toDouble(),
      swapMode: swapMode,
    );
    final responseDto = await _jupiterClient.getQuote(requestDto);

    return responseDto.routes.first;
  }
}

extension on Token {
  // Token get forJupiter => this == Token.sol ? Token.wrappedSol : this;

  // TODO: dev impl
  Token get forJupiter {
    if (this == Token.sol) return Token.wrappedSol;
    if (this == Token.usdc) return Token.usdcProd;

    return this;
  }
}
