import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/currency.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/features/add_funds/bl/add_funds_quote.dart';
import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:decimal/decimal.dart';

class AddFundsRepository {
  AddFundsRepository(this._client);

  final CryptopleaseClient _client;

  Future<String> signFundsRequest(
    String address,
    Amount amount,
    Token quoteToken,
  ) async {
    final requestDto = AddFundsRequestDto(
      receiverAddress: address,
      tokenSymbol: quoteToken.symbol,
      value: amount.decimal.toString(),
    );

    final response = await _client.addFunds(requestDto);

    return response.signedUrl;
  }

  Future<FiatAmount> limit(Token quoteToken) async {
    final requestDto = LimitRequestDto(tokenSymbol: quoteToken.symbol);

    final response = await _client.limit(requestDto);
    final value = Decimal.parse(response.minAmount.toString());
    final amount = Amount.fromDecimal(value: value, currency: Currency.usd);

    return amount as FiatAmount;
  }

  Future<AddFundsQuote> buyQuote(
    Token quoteToken,
    FiatAmount amount,
  ) async {
    final requestDto = QuoteRequestDto(
      tokenSymbol: quoteToken.symbol,
      value: amount.decimal.toString(),
    );
    final currency = CryptoCurrency(token: quoteToken);

    final response = await _client.buyQuote(requestDto);

    final totalFee = response.feeAmount + response.networkFeeAmount;
    final buyAmount = Amount.fromDecimal(
      value: Decimal.parse(response.quoteAmount.toString()),
      currency: currency,
    );
    final feeAmount = amount.copyWithDecimal(
      Decimal.parse(totalFee.toString()),
    );
    final quotePrice = amount.copyWithDecimal(
      Decimal.parse(response.quotePrice.toString()),
    );

    return AddFundsQuote(
      buyAmount: buyAmount as CryptoAmount,
      feeAmount: feeAmount,
      quotePrice: quotePrice,
    );
  }
}
