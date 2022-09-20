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
  ) async {
    final requestDto = AddFundsRequestDto(
      receiverAddress: address,
      tokenSymbol: amount.currency.symbol,
      value: amount.decimal.toString(),
    );

    final response = await _client.addFunds(requestDto);

    return response.signedUrl;
  }

  Future<AddFundsQuote> buyQuote(
    Token quoteToken,
    FiatAmount amount,
  ) async {
    final requestDto = QuoteRequestDto(
      tokenSymbol: quoteToken.symbol,
      value: amount.decimal.toString(),
    );

    final response = await _client.buyQuote(requestDto);
    final totalFee = response.feeAmount + response.networkFeeAmount;
    final buyAmount = Amount.fromDecimal(
      value: Decimal.parse(response.quoteAmount.toString()),
      currency: CryptoCurrency(token: quoteToken),
    );
    final feeAmount = amount.copyWithDecimal(
      Decimal.parse(totalFee.toString()),
    );
    final minAmount = amount.copyWithDecimal(
      Decimal.fromInt(response.minAmount),
    );
    final quotePrice = amount.copyWithDecimal(
      Decimal.parse(response.quotePrice.toString()),
    );

    return AddFundsQuote(
      buyAmount: buyAmount as CryptoAmount,
      feeAmount: feeAmount,
      minAmount: minAmount,
      quotePrice: quotePrice,
    );
  }
}
