import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:connectrpc/connect.dart' as connect;
import 'package:ec_client_dart/ec_client_dart.dart';
import 'package:ec_client_dart/src/grpc/transport.dart';
import 'package:ec_client_dart/src/proto/gen/espressocash/api/dln/v1/service.connect.client.dart'
    as dln_client;
import 'package:ec_client_dart/src/proto/gen/espressocash/api/dln/v1/service.pb.dart' as dln_proto;
import 'package:ec_client_dart/src/proto/gen/espressocash/api/moneygram/v1/service.connect.client.dart';
import 'package:ec_client_dart/src/proto/gen/espressocash/api/moneygram/v1/service.pb.dart'
    as moneygram_proto;
import 'package:ec_client_dart/src/proto/gen/espressocash/api/payments/v1/service.connect.client.dart';
import 'package:ec_client_dart/src/proto/gen/espressocash/api/payments/v1/service.pb.dart'
    as payments_proto;
import 'package:ec_client_dart/src/proto/gen/espressocash/api/rates/v1/service.connect.client.dart';
import 'package:ec_client_dart/src/proto/gen/espressocash/api/rates/v1/service.pb.dart'
    as rates_proto;
import 'package:ec_client_dart/src/proto/gen/espressocash/api/referrals/v1/service.connect.client.dart';
import 'package:ec_client_dart/src/proto/gen/espressocash/api/referrals/v1/service.pb.dart'
    as referrals_proto;
import 'package:ec_client_dart/src/proto/gen/espressocash/api/shortener/v1/service.connect.client.dart';
import 'package:ec_client_dart/src/proto/gen/espressocash/api/shortener/v1/service.pb.dart'
    as shortener_proto;
import 'package:ec_client_dart/src/proto/gen/espressocash/api/swap/v1/service.connect.client.dart';
import 'package:ec_client_dart/src/proto/gen/espressocash/api/swap/v1/service.pb.dart'
    as swap_proto;
import 'package:ec_client_dart/src/proto/gen/espressocash/api/tokens/v1/service.connect.client.dart';
import 'package:ec_client_dart/src/proto/gen/espressocash/api/tokens/v1/service.pb.dart'
    as tokens_proto;
import 'package:ec_client_dart/src/proto/gen/espressocash/api/users/v1/service.connect.client.dart';
import 'package:ec_client_dart/src/proto/gen/espressocash/api/users/v1/service.pb.dart'
    as users_proto;
import 'package:ec_client_dart/src/utils.dart';

const defaultBaseUrl = 'https://grpc.espressocash.com';

typedef SignRequest = Future<String> Function(Iterable<int> data);
typedef TokenUpdated = Future<void> Function(String token);

class EspressoCashClient {
  factory EspressoCashClient({
    String? baseUrl,
    required SignRequest sign,
    String? walletAddress,
    required TokenUpdated onTokenUpdated,
    String? token,
  }) {
    final client = EspressoCashClient._(
      baseUrl: baseUrl ?? defaultBaseUrl,
      sign: sign,
      walletAddress: walletAddress,
      onTokenUpdated: onTokenUpdated,
    );

    if (token != null) {
      client._initWithToken(token);
    }

    return client;
  }

  factory EspressoCashClient.anonymous({String? baseUrl}) => EspressoCashClient._(
    baseUrl: baseUrl ?? defaultBaseUrl,
    sign: (_) async => '',
    walletAddress: null,
    onTokenUpdated: (_) async {},
  );

  EspressoCashClient._({
    required this.baseUrl,
    required this.sign,
    required this.walletAddress,
    required this.onTokenUpdated,
  }) {
    _transport = createTransport(baseUrl: baseUrl);
    _initializeClients();
  }

  final String baseUrl;
  final SignRequest sign;
  final String? walletAddress;
  final TokenUpdated onTokenUpdated;

  late connect.Transport _transport;
  late UserServiceClient _userServiceClient;
  late RateServiceClient _rateServiceClient;
  late PaymentServiceClient _paymentServiceClient;
  late ShortenerServiceClient _shortenerServiceClient;
  late ReferralServiceClient _referralClient;
  late dln_client.DlnServiceClient _dlnServiceClient;
  late MoneygramServiceClient _moneygramServiceClient;
  late TokensServiceClient _tokensServiceClient;
  late SwapServiceClient _swapServiceClient;

  final _authCache = AsyncCache<void>.ephemeral();

  void _initializeClients() {
    _userServiceClient = UserServiceClient(_transport);
    _shortenerServiceClient = ShortenerServiceClient(_transport);
    _rateServiceClient = RateServiceClient(_transport);
    _paymentServiceClient = PaymentServiceClient(_transport);
    _referralClient = ReferralServiceClient(_transport);
    _dlnServiceClient = dln_client.DlnServiceClient(_transport);
    _moneygramServiceClient = MoneygramServiceClient(_transport);
    _tokensServiceClient = TokensServiceClient(_transport);
    _swapServiceClient = SwapServiceClient(_transport);
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
    _transport = createTransport(baseUrl: baseUrl, token: token);
    _initializeClients();
  }

  Future<T> _withReauth<T>(Future<T> Function() f) async {
    try {
      return await f();
    } on connect.ConnectException catch (error) {
      if (error.code != connect.Code.unauthenticated) {
        rethrow;
      }

      await _authCache.fetch(login);

      return f();
    }
  }

  Future<String> _getWalletProofMessage() async {
    final request = users_proto.GetWalletProofMessageRequest(walletAddress: walletAddress);
    final response = await _userServiceClient.getWalletProofMessage(request);

    return response.message;
  }

  Future<String> _login({required String proofSignature, required String proofMessage}) async {
    final request = users_proto.LoginRequest(
      walletAddress: walletAddress,
      proofSignature: proofSignature,
      proofMessage: proofMessage,
    );
    final response = await _userServiceClient.login(request);
    await onTokenUpdated(response.token);

    return response.token;
  }

  Future<CryptoRateResponseDto> getRates() => _withReauth(() async {
    final request = rates_proto.GetRatesRequest();
    final response = await _rateServiceClient.getRates(request);

    return CryptoRateResponseDto(usdc: response.usdc);
  });

  Future<CreateDirectPaymentResponseDto> createDirectPayment(
    CreateDirectPaymentRequestDto request,
  ) => _withReauth(() async {
    final r = payments_proto.CreateDirectPaymentRequest(
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
        final r = shortener_proto.ShortenLinkRequest(fullLink: request.fullLink);
        final response = await _shortenerServiceClient.shortenLink(r);

        return ShortenLinkResponseDto(shortLink: response.shortLink);
      });

  Future<UnshortenLinkResponseDto> expandLink(UnshortenLinkRequestDto request) =>
      _withReauth(() async {
        final r = shortener_proto.ExpandLinkRequest(shortLink: request.shortLink);
        final response = await _shortenerServiceClient.expandLink(r);

        return UnshortenLinkResponseDto(fullLink: response.fullLink);
      });

  Future<void> addReferral(AmbassadorReferralRequestDto request) => _withReauth(() async {
    final grpcRequest = referrals_proto.AddReferralRequest(
      ambassadorAddress: request.ambassadorAddress,
    );

    await _referralClient.addReferral(grpcRequest);
  });

  Future<AmbassadorStatsResponseDto> getReferralStats() => _withReauth(() async {
    final grpcRequest = referrals_proto.GetStatsRequest();
    final grpcResponse = await _referralClient.getStats(grpcRequest);

    return AmbassadorStatsResponseDto(referralCount: grpcResponse.referralCount);
  });

  Future<AmbassadorVerificationResponseDto> verifyReferralStatus() => _withReauth(() async {
    final grpcRequest = referrals_proto.VerifyRequest();
    final grpcResponse = await _referralClient.verify(grpcRequest);

    return AmbassadorVerificationResponseDto(
      isAmbassador: grpcResponse.isAmbassador,
      isReferral: grpcResponse.isReferral,
    );
  });

  Future<CreatePaymentResponseDto> createPaymentEc(CreatePaymentRequestDto request) =>
      _withReauth(() async {
        final r = payments_proto.CreateEscrowPaymentRequest(
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
        final r = payments_proto.ReceiveEscrowPaymentRequest(
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
        final r = payments_proto.CancelEscrowPaymentRequest(
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
    final r = users_proto.UpdateCountryRequest(countryCode: countryCode);
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
    final r = moneygram_proto.MoneygramChallengeSignRequest(signedTx: request.signedTx);
    final response = await _moneygramServiceClient.signChallenge(r);

    return MoneygramChallengeSignResponseDto(signedTx: response.signedTx);
  });

  Future<MoneygramSwapResponseDto> swapToSolana(SwapToSolanaRequestDto request) =>
      _withReauth(() async {
        final r = moneygram_proto.SwapToSolanaRequest(
          amount: request.amount,
          solanaReceiverAddress: request.solanaReceiverAddress,
          stellarSenderAddress: request.stellarSenderAddress,
        );
        final response = await _moneygramServiceClient.swapToSolana(r);

        return MoneygramSwapResponseDto(encodedTx: response.encodedTx);
      });

  Future<MoneygramSwapResponseDto> swapToStellar(SwapToStellarRequestDto request) =>
      _withReauth(() async {
        final r = moneygram_proto.SwapToStellarRequest(
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
        final r = moneygram_proto.MoneygramFeeRequest(
          amount: request.amount,
          type: request.type.toProto,
        );
        final response = await _moneygramServiceClient.calculateFee(r);

        return MoneygramFeeResponseDto(
          bridgeFee: response.bridgeFee,
          moneygramFee: response.moneygramFee,
          gasFeeInUsdc: response.gasFeeInUsdc,
          priorityFee: response.priorityFee,
        );
      });

  Future<void> fundXlmRequest(FundXlmRequestDto request) => _withReauth(() async {
    final r = moneygram_proto.FundXlmRequest(accountId: request.accountId);

    await _moneygramServiceClient.fundXlm(r);
  });

  Future<GetTokensMetaResponseDto> getTokensMeta() => _withReauth(() async {
    final request = tokens_proto.GetTokensMetaRequest();
    final response = await _tokensServiceClient.getTokensMeta(request);

    // ignore: avoid-weak-cryptographic-algorithms, accepted algorithm
    return GetTokensMetaResponseDto(md5: response.md5);
  });

  Future<void> getTokensFile(String savePath) => _withReauth(() async {
    final request = tokens_proto.GetTokensFileRequest();
    final response = await _tokensServiceClient.getTokensFile(request);

    final file = File(savePath);
    await file.writeAsBytes(response.content);
  });

  Future<FiatRateResponseDto> fetchFiatRate(FiatRateRequestDto request) => _withReauth(() async {
    final r = rates_proto.GetFiatRatesRequest(base: request.base, target: request.target);
    final response = await _rateServiceClient.getFiatRates(r);

    return FiatRateResponseDto(rate: response.rate);
  });

  Future<DirectPaymentQuoteResponseDto> getDirectPaymentQuote(
    DirectPaymentQuoteRequestDto request,
  ) => _withReauth(() async {
    final r = payments_proto.GetDirectPaymentQuoteRequest(
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
    final r = payments_proto.GetOutgoingEscrowPaymentQuoteRequest();
    final response = await _paymentServiceClient.getOutgoingEscrowPaymentQuote(r);

    return EscrowPaymentQuoteResponseDto(fee: response.fee.toInt());
  });

  Future<EscrowPaymentQuoteResponseDto> getIncomingEscrowPaymentQuote() => _withReauth(() async {
    final r = payments_proto.GetIncomingEscrowPaymentQuoteRequest();
    final response = await _paymentServiceClient.getIncomingEscrowPaymentQuote(r);

    return EscrowPaymentQuoteResponseDto(fee: response.fee.toInt());
  });

  Future<SwapRouteResponseDto> swap(SwapRouteRequestDto request) => _withReauth(() async {
    final match = switch (request.match) {
      SwapMatchDto.inAmount => swap_proto.SwapMatch.SWAP_MATCH_IN_AMOUNT,
      SwapMatchDto.outAmount => swap_proto.SwapMatch.SWAP_MATCH_OUT_AMOUNT,
    };

    final slippage = switch (request.slippage) {
      SwapSlippageDto.zpOne => swap_proto.SwapSlippage.SWAP_SLIPPAGE_ZP_ONE,
      SwapSlippageDto.zpFive => swap_proto.SwapSlippage.SWAP_SLIPPAGE_ZP_FIVE,
      SwapSlippageDto.onePercent => swap_proto.SwapSlippage.SWAP_SLIPPAGE_ONE_PERCENT,
    };

    final r = swap_proto.SwapRouteRequest(
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
