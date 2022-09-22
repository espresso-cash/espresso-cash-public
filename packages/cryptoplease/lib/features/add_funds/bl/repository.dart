import 'package:cryptoplease/config.dart';
import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/currency.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/data/moonpay/moonpay_client.dart';
import 'package:cryptoplease/features/add_funds/bl/add_funds_quote.dart';
import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:decimal/decimal.dart';

class AddFundsRepository {
  AddFundsRepository({
    required CryptopleaseClient cryptopleaseClient,
    required MoonpayClient moonpayClient,
  })  : _cpClient = cryptopleaseClient,
        _moonpayClient = moonpayClient;

  final CryptopleaseClient _cpClient;
  final MoonpayClient _moonpayClient;

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

    final response = await _cpClient.addFunds(requestDto);

    return response.signedUrl;
  }

  Future<FiatAmount> limit(Token quoteToken) async {
    final tokenSymbol = quoteToken.symbol.toLowerCase();
    final limitResponse = await _moonpayClient.limits(
      apiKey: moonpayApiKey,
      currencyCode: tokenSymbol,
      baseCurrencyCode: 'usd',
    );
    final askResponse = await _moonpayClient.askPrice(
      apiKey: moonpayApiKey,
      currencyCode: tokenSymbol,
    );

    final askCurrency = askResponse['USD'];

    if (askCurrency == null) {
      throw Exception('$tokenSymbol price not found in USD');
    }

    final minValue = limitResponse.quoteCurrency.minBuyAmount * askCurrency;
    final value = Decimal.parse(minValue.toString());
    final amount = Amount.fromDecimal(value: value, currency: Currency.usd);

    return amount as FiatAmount;
  }

  Future<AddFundsQuote> buyQuote(
    Token quoteToken,
    FiatAmount amount,
  ) async {
    final tokenSymbol = quoteToken.symbol.toLowerCase();
    final response = await _moonpayClient.buyQuote(
      apiKey: moonpayApiKey,
      currencyCode: tokenSymbol,
      baseCurrencyAmount: amount.decimal.toString(),
      areFeesIncluded: true,
      baseCurrencyCode: 'usd',
    );

    final buyAmount = Amount.fromDecimal(
      currency: CryptoCurrency(token: quoteToken),
      value: Decimal.parse(response.quoteCurrencyPrice.toString()),
    );

    final totalFee = response.feeAmount + response.networkFeeAmount;
    final feeAmount = amount.copyWithDecimal(
      Decimal.parse(totalFee.toString()),
    );

    final quotePrice = amount.copyWithDecimal(
      Decimal.parse(response.quoteCurrencyPrice.toString()),
    );

    return AddFundsQuote(
      buyAmount: buyAmount as CryptoAmount,
      feeAmount: feeAmount,
      quotePrice: quotePrice,
    );
  }
}
