import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:retrofit/retrofit.dart';

part 'client.g.dart';

typedef SignRequest = Future<({String publicKey, String signature})?> Function(
  String data,
);

@RestApi(baseUrl: 'https://api.espressocash.com/api/v1')
abstract class EspressoCashClient {
  factory EspressoCashClient({
    String? baseUrl,
    required SignRequest sign,
  }) =>
      _EspressoCashClient(
        Dio()
          ..interceptors.add(
            InterceptorsWrapper(
              onRequest: (options, handler) async {
                final data =
                    options.data == null ? '' : jsonEncode(options.data);
                final signed = await sign(data);
                if (signed != null) {
                  options.headers['x-public-key'] = signed.publicKey;
                  options.headers['x-signature'] = signed.signature;
                }

                handler.next(options);
              },
            ),
          ),
        baseUrl: baseUrl,
      );

  Dio get _dio;
  String? get baseUrl;

  @POST('/createDirectPayment')
  Future<CreateDirectPaymentResponseDto> createDirectPayment(
    @Body() CreateDirectPaymentRequestDto request,
  );

  @POST('/getFees')
  Future<GetFeesResponseDto> getFees();

  @POST('/getSwapRoute')
  Future<SwapRouteResponseDto> getSwapRoute(
    @Body() SwapRouteRequestDto request,
  );

  @POST('/escrow/create')
  Future<CreatePaymentResponseDto> createPaymentEc(
    @Body() CreatePaymentRequestDto request,
  );

  @POST('/escrow/receive')
  Future<ReceivePaymentResponseDto> receivePaymentEc(
    @Body() ReceivePaymentRequestDto request,
  );

  @POST('/escrow/cancel')
  Future<CancelPaymentResponseDto> cancelPaymentEc(
    @Body() CancelPaymentRequestDto request,
  );

  @POST('/scalex/generate')
  Future<GenerateScalexLinkResponseDto> generateScalexLink(
    @Body() GenerateScalexLinkRequestDto request,
  );

  @POST('/scalex/fetch')
  Future<OrderStatusScalexResponseDto> fetchScalexTransaction(
    @Body() OrderStatusScalexRequestDto referenceId,
  );

  @POST('/scalex/withdraw')
  Future<ScalexWithdrawResponseDto> createScalexWithdraw(
    @Body() ScalexWithdrawRequestDto request,
  );

  @POST('/scalex/fees')
  Future<ScalexRateFeeResponseDto> fetchScalexFeesAndRate();

  @POST('/updateUserWalletCountry')
  Future<void> updateUserWalletCountry(
    @Body() WalletCountryRequestDto request,
  );

  @POST('/dln/quote')
  Future<PaymentQuoteResponseDto> getDlnQuote(
    @Body() PaymentQuoteRequestDto request,
  );

  @POST('/dln/orderId')
  Future<OrderIdDlnResponseDto> fetchDlnOrderId(
    @Body() OrderIdDlnRequestDto request,
  );

  @POST('/dln/status')
  Future<OrderStatusDlnResponseDto> fetchDlnStatus(
    @Body() OrderStatusDlnRequestDto request,
  );

  @POST('/dln/incoming/quote')
  Future<IncomingQuoteResponseDto> getIncomingDlnQuote(
    @Body() IncomingQuoteRequestDto request,
  );

  @POST('/getFreeNonce')
  Future<GetFreeNonceResponseDto> getFreeNonce();

  @POST('/submitDurableTx')
  Future<SubmitDurableTxResponseDto> submitDurableTx(
    @Body() SubmitDurableTxRequestDto request,
  );

  @POST('/getDurableFees')
  Future<GetDurableFeesResponseDto> getDurableFees();

  @POST('/shortenLink')
  Future<ShortenLinkResponseDto> shortenLink(
    @Body() ShortenLinkRequestDto request,
  );

  @POST('/unshortenLink')
  Future<UnshortenLinkResponseDto> unshortenLink(
    @Body() UnshortenLinkRequestDto request,
  );

  @POST('/dln/incoming/gasFee')
  Future<GasFeeResponseDto> getGasFees(
    @Body() GasFeeRequestDto request,
  );

  @POST('/rates')
  Future<GetRatesResponseDto> getRates();

  @POST('/getPriorityFeeEstimate')
  Future<PriorityFeesResponseDto> getPriorityFeeEstimate(
    @Body() PriorityFeesRequestDto request,
  );

  @POST('/moneygram/sign')
  Future<MoneygramChallengeSignResponseDto> signChallenge(
    @Body() MoneygramChallengeSignRequestDto request,
  );

  @POST('/moneygram/swapToSolana')
  Future<MoneygramSwapResponseDto> swapToSolana(
    @Body() SwapToSolanaRequestDto request,
  );

  @POST('/moneygram/swapToStellar')
  Future<MoneygramSwapResponseDto> swapToStellar(
    @Body() SwapToStellarRequestDto request,
  );

  @POST('/moneygram/calculateFee')
  Future<MoneygramFeeResponseDto> calculateMoneygramFee(
    @Body() MoneygramFeeRequestDto request,
  );

  @POST('/moneygram/fund')
  Future<void> fundXlmRequest(
    @Body() FundXlmRequestDto request,
  );

  @POST('/tokens/meta')
  Future<GetTokensMetaResponseDto> getTokensMeta();
}

extension EspressoCashClientExt on EspressoCashClient {
  Future<void> getTokensFile(String savePath) => _dio.download(
        '${baseUrl ?? _dio.options.baseUrl}/tokens/file',
        savePath,
        options: Options(method: HttpMethod.POST),
      );
}
