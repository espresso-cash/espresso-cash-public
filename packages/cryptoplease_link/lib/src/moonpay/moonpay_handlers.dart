import 'dart:core';

import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:cryptoplease_link/src/constants.dart';
import 'package:cryptoplease_link/src/moonpay/client/moonpay_client.dart';
import 'package:cryptoplease_link/src/utils.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart' as shelf_router;

Handler addMoonpayHandlers() => shelf_router.Router()
  ..post('/buyQuote', _quoteHandler)
  ..post('/limit', _limitHandler);

Future<Response> _quoteHandler(Request request) async =>
    processRequest<QuoteRequestDto, QuoteResponseDto>(
      request,
      QuoteRequestDto.fromJson,
      (data) async {
        final tokenSymbol = data.tokenSymbol.toLowerCase();
        final quoteResponse = await _moonpayClient.buyQuote(
          apiKey: moonpayApiKey,
          currencyCode: tokenSymbol,
          baseCurrencyAmount: data.value,
          areFeesIncluded: true,
          baseCurrencyCode: 'usd',
        );

        return QuoteResponseDto(
          quoteAmount: quoteResponse.quoteCurrencyAmount,
          feeAmount: quoteResponse.feeAmount,
          networkFeeAmount: quoteResponse.networkFeeAmount,
          quotePrice: quoteResponse.quoteCurrencyPrice,
        );
      },
    );

Future<Response> _limitHandler(Request request) async =>
    processRequest<LimitRequestDto, LimitResponseDto>(
      request,
      LimitRequestDto.fromJson,
      (data) async {
        final tokenSymbol = data.tokenSymbol.toLowerCase();
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

        return LimitResponseDto(
          minAmount: limitResponse.quoteCurrency.minBuyAmount * askCurrency,
        );
      },
    );

final _moonpayClient = MoonpayClient();
