import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:ec_client_dart/ec_client_dart.dart';
import 'package:ec_client_dart/src/generated/api/dln/v1/service.pbgrpc.dart' as dln_proto;
import 'package:ec_client_dart/src/generated/api/moneygram/v1/service.pbgrpc.dart';
import 'package:ec_client_dart/src/generated/api/payments/v1/service.pbgrpc.dart';
import 'package:ec_client_dart/src/generated/api/rates/v1/service.pbgrpc.dart';
import 'package:ec_client_dart/src/generated/api/referrals/v1/service.pbgrpc.dart';
import 'package:ec_client_dart/src/generated/api/shortener/v1/service.pbgrpc.dart';
import 'package:ec_client_dart/src/generated/api/swap/v1/service.pbgrpc.dart';
import 'package:ec_client_dart/src/generated/api/tokens/v1/service.pbgrpc.dart';
import 'package:ec_client_dart/src/generated/api/users/v1/service.pbgrpc.dart';
import 'package:ec_client_dart/src/utils.dart';
import 'package:grpc/grpc.dart';

const defaultBaseUrl = 'grpc.espressocash.com';

typedef SignRequest = Future<String> Function(Iterable<int> data);
typedef TokenUpdated = Future<void> Function(String token);

class EspressoCashClient {
  factory EspressoCashClient({
    String? baseUrl,
    int? port,
    required SignRequest sign,
    String? walletAddress,
    bool secure = true,
    required TokenUpdated onTokenUpdated,
    String? token,
  }) {
    final client = EspressoCashClient._(
      baseUrl: baseUrl ?? defaultBaseUrl,
      port: port,
      sign: sign,
      walletAddress: walletAddress,
      secure: secure,
      onTokenUpdated: onTokenUpdated,
    );

    if (token != null) {
      client._initWithToken(token);
    }

    return client;
  }

  factory EspressoCashClient.anonymous({String? baseUrl, int? port, bool secure = true}) =>
      EspressoCashClient._(
        baseUrl: baseUrl ?? defaultBaseUrl,
        port: port,
        sign: (_) async => '',
        walletAddress: null,
        secure: secure,
        onTokenUpdated: (_) async {},
      );

  EspressoCashClient._({
    required this.baseUrl,
    required this.port,
    required this.sign,
    required this.walletAddress,
    required this.onTokenUpdated,
    required bool secure,
  }) {
    final options = ChannelOptions(
      credentials: secure ? const ChannelCredentials.secure() : const ChannelCredentials.insecure(),
      connectionTimeout: const Duration(seconds: 15),
      idleTimeout: const Duration(minutes: 5),
    );

    _channel = ClientChannel(baseUrl, port: port ?? 443, options: options);

    final callOptions = CallOptions();
    _userServiceClient = UserServiceClient(_channel, options: callOptions);
    _shortenerServiceClient = ShortenerServiceClient(_channel, options: callOptions);
    _rateServiceClient = RateServiceClient(_channel, options: callOptions);
    _paymentServiceClient = PaymentServiceClient(_channel, options: callOptions);
    _referralClient = ReferralServiceClient(_channel, options: callOptions);
    _dlnServiceClient = dln_proto.DlnServiceClient(_channel, options: callOptions);
    _moneygramServiceClient = MoneygramServiceClient(_channel, options: callOptions);
    _tokensServiceClient = TokensServiceClient(_channel, options: callOptions);
    _swapServiceClient = SwapServiceClient(_channel, options: callOptions);
  }

  final String baseUrl;
  final int? port;
  final SignRequest sign;
  final String? walletAddress;
  final TokenUpdated onTokenUpdated;

  late final ClientChannel _channel;
  late UserServiceClient _userServiceClient;
  late RateServiceClient _rateServiceClient;
  late PaymentServiceClient _paymentServiceClient;
  late ShortenerServiceClient _shortenerServiceClient;
  late ReferralServiceClient _referralClient;
  late dln_proto.DlnServiceClient _dlnServiceClient;
  late MoneygramServiceClient _moneygramServiceClient;
  late TokensServiceClient _tokensServiceClient;
  late SwapServiceClient _swapServiceClient;

  final _authCache = AsyncCache<void>.ephemeral();

  Future<void> dispose() async {
    await _channel.shutdown();
  }

  Future<void> login() async {
    if (walletAddress == null || walletAddress?.isEmpty == true) {
      throw Exception('Wallet address is required for login');
    }

    final proofMessage = await _getWalletProofMessage();
    final signature = await sign(utf8.encode(proofMessage));

    final newToken = await _login(proofSignature: signature, proofMessage: proofMessage);

    _initWithToken(newToken);
  }

  void _initWithToken(String token) {
    final callOptions = CallOptions(metadata: {'authorization': 'Bearer $token'});

    _userServiceClient = UserServiceClient(_channel, options: callOptions);
    _rateServiceClient = RateServiceClient(_channel, options: callOptions);
    _paymentServiceClient = PaymentServiceClient(_channel, options: callOptions);
    _shortenerServiceClient = ShortenerServiceClient(_channel, options: callOptions);
    _referralClient = ReferralServiceClient(_channel, options: callOptions);
    _dlnServiceClient = dln_proto.DlnServiceClient(_channel, options: callOptions);
    _moneygramServiceClient = MoneygramServiceClient(_channel, options: callOptions);
    _tokensServiceClient = TokensServiceClient(_channel, options: callOptions);
    _swapServiceClient = SwapServiceClient(_channel, options: callOptions);
  }

  Future<T> _withReauth<T>(Future<T> Function() f) async {
    try {
      return await f();
    } on GrpcError catch (error) {
      if (error.code != StatusCode.unauthenticated) {
        rethrow;
      }

      await _authCache.fetch(login);

      return f();
    }
  }

  Future<String> _getWalletProofMessage() async {
    final request = GetWalletProofMessageRequest(walletAddress: walletAddress);
    final response = await _userServiceClient.getWalletProofMessage(request);

    return response.message;
  }

  Future<String> _login({required String proofSignature, required String proofMessage}) async {
    final request = LoginRequest(
      walletAddress: walletAddress,
      proofSignature: proofSignature,
      proofMessage: proofMessage,
    );
    final response = await _userServiceClient.login(request);
    await onTokenUpdated(response.token);

    return response.token;
  }

  Future<CryptoRateResponseDto> getRates() => _withReauth(() async {
    final request = GetRatesRequest();
    final response = await _rateServiceClient.getRates(request);

    return CryptoRateResponseDto(usdc: response.usdc);
  });

  Future<CreateDirectPaymentResponseDto> createDirectPayment(
    CreateDirectPaymentRequestDto request,
  ) => _withReauth(() async {
    final r = CreateDirectPaymentRequest(
      senderAccount: request.senderAccount,
      receiverAccount: request.receiverAccount,
      referenceAccount: request.referenceAccount,
      amount: request.amount.toInt64,
      mint: request.mintAddress,
    );

    final response = await _paymentServiceClient.createDirectPayment(r);

    return CreateDirectPaymentResponseDto(
      fee: response.fee.toInt(),
      transaction: response.transaction,
      slot: response.slot.toBigInt,
    );
  });

  Future<ShortenLinkResponseDto> shortenLink(ShortenLinkRequestDto request) =>
      _withReauth(() async {
        final r = ShortenLinkRequest(fullLink: request.fullLink);
        final response = await _shortenerServiceClient.shortenLink(r);

        return ShortenLinkResponseDto(shortLink: response.shortLink);
      });

  Future<UnshortenLinkResponseDto> expandLink(UnshortenLinkRequestDto request) =>
      _withReauth(() async {
        final r = ExpandLinkRequest(shortLink: request.shortLink);
        final response = await _shortenerServiceClient.expandLink(r);

        return UnshortenLinkResponseDto(fullLink: response.fullLink);
      });

  Future<void> addReferral(AmbassadorReferralRequestDto request) => _withReauth(() async {
    final grpcRequest = AddReferralRequest(ambassadorAddress: request.ambassadorAddress);

    await _referralClient.addReferral(grpcRequest);
  });

  Future<AmbassadorStatsResponseDto> getReferralStats() => _withReauth(() async {
    final grpcRequest = GetStatsRequest();
    final grpcResponse = await _referralClient.getStats(grpcRequest);

    return AmbassadorStatsResponseDto(referralCount: grpcResponse.referralCount);
  });

  Future<AmbassadorVerificationResponseDto> verifyReferralStatus() => _withReauth(() async {
    final grpcRequest = VerifyRequest();
    final grpcResponse = await _referralClient.verify(grpcRequest);

    return AmbassadorVerificationResponseDto(
      isAmbassador: grpcResponse.isAmbassador,
      isReferral: grpcResponse.isReferral,
    );
  });

  Future<CreatePaymentResponseDto> createPaymentEc(CreatePaymentRequestDto request) =>
      _withReauth(() async {
        final r = CreateEscrowPaymentRequest(
          senderAccount: request.senderAccount,
          escrowAccount: request.escrowAccount,
          amount: request.amount.toInt64,
        );

        final response = await _paymentServiceClient.createEscrowPayment(r);

        return CreatePaymentResponseDto(
          transaction: response.transaction,
          slot: response.slot.toBigInt,
        );
      });

  Future<ReceivePaymentResponseDto> receivePaymentEc(ReceivePaymentRequestDto request) =>
      _withReauth(() async {
        final r = ReceiveEscrowPaymentRequest(
          receiverAccount: request.receiverAccount,
          escrowAccount: request.escrowAccount,
        );
        final response = await _paymentServiceClient.receiveEscrowPayment(r);

        return ReceivePaymentResponseDto(
          transaction: response.transaction,
          slot: response.slot.toBigInt,
        );
      });

  Future<CancelPaymentResponseDto> cancelPaymentEc(CancelPaymentRequestDto request) =>
      _withReauth(() async {
        final r = CancelEscrowPaymentRequest(
          senderAccount: request.senderAccount,
          escrowAccount: request.escrowAccount,
        );
        final response = await _paymentServiceClient.cancelEscrowPayment(r);

        return CancelPaymentResponseDto(
          transaction: response.transaction,
          slot: response.slot.toBigInt,
        );
      });

  Future<void> updateUserWalletCountry(String countryCode) => _withReauth(() async {
    final r = UpdateCountryRequest(countryCode: countryCode);
    await _userServiceClient.updateCountry(r);
  });

  Future<OutgoingQuoteResponseDto> getOutgoingDlnQuote(OutgoingQuoteRequestDto request) =>
      _withReauth(() async {
        final r = dln_proto.GetOutgoingQuoteRequest(
          amount: request.amount.toInt64,
          receiverAddress: request.receiverAddress,
          receiverBlockchain: request.receiverBlockchain,
        );

        final response = await _dlnServiceClient.getOutgoingQuote(r);

        return OutgoingQuoteResponseDto(
          inputAmount: response.inputAmount.toInt(),
          receiverAmount: response.receiverAmount.toInt(),
          encodedTx: response.encodedTx,
          feeInUsdc: response.feeInUsdc.toInt(),
          slot: response.slot.toBigInt,
        );
      });

  Future<IncomingQuoteResponseDto> getIncomingDlnQuote(IncomingQuoteRequestDto request) =>
      _withReauth(() async {
        final r = dln_proto.GetIncomingQuoteRequest(
          amount: request.amount.toInt64,
          senderAddress: request.senderAddress,
          senderBlockchain: request.senderBlockchain,
          receiverAddress: request.receiverAddress,
          solanaReferenceAddress: request.solanaReferenceAddress,
        );

        final response = await _dlnServiceClient.getIncomingQuote(r);

        return IncomingQuoteResponseDto(
          tx: QuoteTx(to: response.tx.to, data: response.tx.data, value: response.tx.value.toInt()),
          usdcInfo: QuoteUsdcInfo(
            usdcAddress: response.usdcInfo.usdcAddress,
            approvalAmount: response.usdcInfo.approvalAmount.toInt(),
          ),
          inputAmount: response.inputAmount.toInt(),
          receiverAmount: response.receiverAmount.toInt(),
          feeInUsdc: response.feeInUsdc.toInt(),
        );
      });

  Future<OrderIdDlnResponseDto> getDlnOrderId(OrderIdDlnRequestDto request) =>
      _withReauth(() async {
        final r = dln_proto.GetOrderIdRequest(txId: request.txId);
        final response = await _dlnServiceClient.getOrderId(r);

        return OrderIdDlnResponseDto(orderId: response.hasOrderId() ? response.orderId : null);
      });

  Future<OrderStatusDlnResponseDto> getDlnOrderStatus(OrderStatusDlnRequestDto request) =>
      _withReauth(() async {
        final r = dln_proto.GetOrderStatusRequest(orderId: request.orderId);
        final response = await _dlnServiceClient.getOrderStatus(r);

        return OrderStatusDlnResponseDto(status: mapDlnOrderStatus(response.status));
      });

  Future<GasFeeResponseDto> getGasFees(GasFeeRequestDto request) => _withReauth(() async {
    final r = dln_proto.GetGasFeesRequest(network: request.network);
    final response = await _dlnServiceClient.getGasFees(r);

    return GasFeeResponseDto(
      low: mapProtoToGasFeeEstimate(response.low),
      medium: mapProtoToGasFeeEstimate(response.medium),
      high: mapProtoToGasFeeEstimate(response.high),
      estimatedBaseFee: response.estimatedBaseFee,
      networkCongestion: response.networkCongestion,
    );
  });

  Future<MoneygramChallengeSignResponseDto> signChallenge(
    MoneygramChallengeSignRequestDto request,
  ) => _withReauth(() async {
    final r = MoneygramChallengeSignRequest(signedTx: request.signedTx);
    final response = await _moneygramServiceClient.signChallenge(r);

    return MoneygramChallengeSignResponseDto(signedTx: response.signedTx);
  });

  Future<MoneygramSwapResponseDto> swapToSolana(SwapToSolanaRequestDto request) =>
      _withReauth(() async {
        final r = SwapToSolanaRequest(
          amount: request.amount,
          solanaReceiverAddress: request.solanaReceiverAddress,
          stellarSenderAddress: request.stellarSenderAddress,
        );
        final response = await _moneygramServiceClient.swapToSolana(r);

        return MoneygramSwapResponseDto(encodedTx: response.encodedTx);
      });

  Future<MoneygramSwapResponseDto> swapToStellar(SwapToStellarRequestDto request) =>
      _withReauth(() async {
        final r = SwapToStellarRequest(
          amount: request.amount,
          priorityFee: request.priorityFee,
          solanaSenderAddress: request.solanaSenderAddress,
          stellarReceiverAddress: request.stellarReceiverAddress,
        );
        final response = await _moneygramServiceClient.swapToStellar(r);

        return MoneygramSwapResponseDto(encodedTx: response.encodedTx);
      });

  Future<MoneygramFeeResponseDto> calculateMoneygramFee(MoneygramFeeRequestDto request) =>
      _withReauth(() async {
        final r = MoneygramFeeRequest(amount: request.amount, type: request.type.toProto);
        final response = await _moneygramServiceClient.calculateFee(r);

        return MoneygramFeeResponseDto(
          bridgeFee: response.bridgeFee,
          moneygramFee: response.moneygramFee,
          gasFeeInUsdc: response.gasFeeInUsdc,
          priorityFee: response.priorityFee,
        );
      });

  Future<void> fundXlmRequest(FundXlmRequestDto request) => _withReauth(() async {
    final r = FundXlmRequest(accountId: request.accountId);

    await _moneygramServiceClient.fundXlm(r);
  });

  Future<GetTokensMetaResponseDto> getTokensMeta() => _withReauth(() async {
    final request = GetTokensMetaRequest();
    final response = await _tokensServiceClient.getTokensMeta(request);

    // ignore: avoid-weak-cryptographic-algorithms, accepted algorithm
    return GetTokensMetaResponseDto(md5: response.md5);
  });

  Future<void> getTokensFile(String savePath) => _withReauth(() async {
    final request = GetTokensFileRequest();
    final response = await _tokensServiceClient.getTokensFile(request);

    final file = File(savePath);
    await file.writeAsBytes(response.content);
  });

  Future<FiatRateResponseDto> fetchFiatRate(FiatRateRequestDto request) => _withReauth(() async {
    final r = GetFiatRatesRequest(base: request.base, target: request.target);
    final response = await _rateServiceClient.getFiatRates(r);

    return FiatRateResponseDto(rate: response.rate);
  });

  Future<DirectPaymentQuoteResponseDto> getDirectPaymentQuote(
    DirectPaymentQuoteRequestDto request,
  ) => _withReauth(() async {
    final r = GetDirectPaymentQuoteRequest(
      receiverAccount: request.receiverAccount,
      amount: request.amount.toInt64,
    );
    final response = await _paymentServiceClient.getDirectPaymentQuote(r);

    return DirectPaymentQuoteResponseDto(
      fee: response.fee.toInt(),
      totalAmount: response.totalAmount.toInt(),
    );
  });

  Future<EscrowPaymentQuoteResponseDto> getOutgoingEscrowPaymentQuote() => _withReauth(() async {
    final r = GetOutgoingEscrowPaymentQuoteRequest();
    final response = await _paymentServiceClient.getOutgoingEscrowPaymentQuote(r);

    return EscrowPaymentQuoteResponseDto(fee: response.fee.toInt());
  });

  Future<EscrowPaymentQuoteResponseDto> getIncomingEscrowPaymentQuote() => _withReauth(() async {
    final r = GetIncomingEscrowPaymentQuoteRequest();
    final response = await _paymentServiceClient.getIncomingEscrowPaymentQuote(r);

    return EscrowPaymentQuoteResponseDto(fee: response.fee.toInt());
  });

  Future<SwapRouteResponseDto> swap(SwapRouteRequestDto request) => _withReauth(() async {
    final match = switch (request.match) {
      SwapMatchDto.inAmount => SwapMatch.SWAP_MATCH_IN_AMOUNT,
      SwapMatchDto.outAmount => SwapMatch.SWAP_MATCH_OUT_AMOUNT,
    };

    final slippage = switch (request.slippage) {
      SwapSlippageDto.zpOne => SwapSlippage.SWAP_SLIPPAGE_ZP_ONE,
      SwapSlippageDto.zpFive => SwapSlippage.SWAP_SLIPPAGE_ZP_FIVE,
      SwapSlippageDto.onePercent => SwapSlippage.SWAP_SLIPPAGE_ONE_PERCENT,
    };

    final r = SwapRouteRequest(
      inputToken: request.inputToken,
      outputToken: request.outputToken,
      amount: request.amount,
      match: match,
      slippage: slippage,
    );

    final response = await _swapServiceClient.swap(r);

    return SwapRouteResponseDto(
      inAmount: response.inAmount,
      outAmount: response.outAmount,
      amount: response.amount,
      encodedTx: response.encodedTx,
      feeInUsdc: response.feeInUsdc,
      slot: response.slot.toBigInt,
      slippageBps: response.slippageBps,
      platformFeeBps: response.platformFeeBps,
      priceImpact: response.priceImpact,
      providerLabel: response.providerLabel,
    );
  });
}
