import 'dart:core';

import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:cryptoplease_link/src/constants.dart';
import 'package:cryptoplease_link/src/moonpay/client/moonpay_client.dart';
import 'package:cryptoplease_link/src/utils.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart' as shelf_router;

Handler addQuoteHandler() =>
    shelf_router.Router()..get('/quote', _quoteHandler);

Future<Response> _quoteHandler(Request request) async =>
    processRequest<QuoteRequestDto, QuoteResponseDto>(
      request,
      QuoteRequestDto.fromJson,
      (data) async {
        final response = await _moonpayClient.buyQuote(
          data.tokenSymbol,
          {
            'apiKey': moonpayApiKey,
            'baseCurrencyAmount': data.value,
            'quoteCurrencyCode': data.tokenSymbol,
            'currencyCode': data.tokenSymbol,
            'baseCurrencyCode': 'usd',
          },
        );

        return QuoteResponseDto(
          quoteAmount: response.quoteCurrencyAmount,
          feeAmount: response.feeAmount,
          networkFeeAmount: response.networkFeeAmount,
          minAmount: response.baseCurrency.minBuyAmount,
          quotePrice: response.quoteCurrencyPrice,
        );
      },
    );

final _moonpayClient = MoonpayClient();
