import 'dart:convert';
import 'dart:io';

import 'package:ec_client_dart/ec_client_dart.dart';
import 'package:ec_client_dart/src/generated/api/moneygram/v1/service.pbgrpc.dart';
import 'package:ec_client_dart/src/generated/api/payments/v1/service.pbgrpc.dart';
import 'package:ec_client_dart/src/generated/api/rates/v1/service.pbgrpc.dart';
import 'package:ec_client_dart/src/generated/api/referrals/v1/service.pbgrpc.dart';
import 'package:ec_client_dart/src/generated/api/shortener/v1/service.pbgrpc.dart';
import 'package:ec_client_dart/src/generated/api/tokens/v1/service.pbgrpc.dart';
import 'package:ec_client_dart/src/generated/api/users/v1/service.pbgrpc.dart';
import 'package:ec_client_dart/src/utils.dart';
import 'package:grpc/grpc.dart';
import 'package:ec_client_dart/src/generated/api/dln/v1/service.pbgrpc.dart'
    as dln_proto;

const defaultBaseUrl = 'grpc.espressocash.com';

typedef SignRequest = Future<String> Function(Iterable<int> data);

class EspressoCashClient {
  final String baseUrl;
  final int? port;
  final SignRequest sign;
  final String? walletAddress;

  late final ClientChannel _channel;
  late UserServiceClient _userServiceClient;
  late final RateServiceClient _rateServiceClient;
  late final PaymentServiceClient _paymentServiceClient;
  late ShortenerServiceClient _shortenerServiceClient;
  late final ReferralServiceClient _referralClient;
  late final dln_proto.DlnServiceClient _dlnServiceClient;
  late final MoneygramServiceClient _moneygramServiceClient;
  late final TokensServiceClient _tokensServiceClient;

  EspressoCashClient._({
    required this.baseUrl,
    required this.port,
    required this.sign,
    required this.walletAddress,
    required bool secure,
  }) {
    final options = ChannelOptions(
      credentials: secure
          ? const ChannelCredentials.secure()
          : const ChannelCredentials.insecure(),
      connectionTimeout: const Duration(seconds: 15),
      idleTimeout: const Duration(minutes: 5),
    );

    _channel = ClientChannel(
      baseUrl,
      port: port ?? 443,
      options: options,
    );

    _userServiceClient = UserServiceClient(_channel);
    _shortenerServiceClient = ShortenerServiceClient(_channel);
  }

  static Future<EspressoCashClient> create({
    String? baseUrl,
    int? port,
    required SignRequest sign,
    String? walletAddress,
    bool secure = true,
  }) async {
    final client = EspressoCashClient._(
      baseUrl: baseUrl ?? defaultBaseUrl,
      port: port,
      sign: sign,
      walletAddress: walletAddress,
      secure: secure,
    );
    if (walletAddress != null && walletAddress.isNotEmpty) {
      await client._init();
    }
    return client;
  }

  static Future<EspressoCashClient> anonymous({
    String? baseUrl,
    int? port,
    bool secure = true,
  }) async {
    return EspressoCashClient._(
      baseUrl: baseUrl ?? defaultBaseUrl,
      port: port,
      sign: (_) async => '',
      walletAddress: null,
      secure: secure,
    );
  }

  Future<void> dispose() async {
    await _channel.shutdown();
  }

  Future<void> _init() async {
    final proofMessage = await _getWalletProofMessage();
    final signature = await sign(utf8.encode(proofMessage));

    final token = await _login(
      proofSignature: signature,
      proofMessage: proofMessage,
    );

    final callOptions =
        CallOptions(metadata: {'authorization': 'Bearer $token'});

    _userServiceClient = UserServiceClient(_channel, options: callOptions);
    _rateServiceClient = RateServiceClient(_channel, options: callOptions);
    _paymentServiceClient =
        PaymentServiceClient(_channel, options: callOptions);
    _shortenerServiceClient =
        ShortenerServiceClient(_channel, options: callOptions);
    _referralClient = ReferralServiceClient(_channel, options: callOptions);
    _dlnServiceClient =
        dln_proto.DlnServiceClient(_channel, options: callOptions);
    _moneygramServiceClient =
        MoneygramServiceClient(_channel, options: callOptions);
    _tokensServiceClient = TokensServiceClient(_channel, options: callOptions);
  }

  Future<String> _getWalletProofMessage() async {
    final request = GetWalletProofMessageRequest(walletAddress: walletAddress);
    final response = await _userServiceClient.getWalletProofMessage(request);
    return response.message;
  }

  Future<String> _login({
    required String proofSignature,
    required String proofMessage,
  }) async {
    final request = LoginRequest(
      walletAddress: walletAddress,
      proofSignature: proofSignature,
      proofMessage: proofMessage,
    );
    final response = await _userServiceClient.login(request);
    return response.token;
  }

  Future<CryptoRateResponseDto> getRates() async {
    final request = GetRatesRequest();
    final response = await _rateServiceClient.getRates(request);

    return CryptoRateResponseDto(usdc: response.usdc);
  }

  Future<CreateDirectPaymentResponseDto> createDirectPayment(
    CreateDirectPaymentRequestDto request,
  ) async {
    final r = CreateDirectPaymentRequest(
      senderAccount: request.senderAccount,
      receiverAccount: request.receiverAccount,
      referenceAccount: request.referenceAccount,
      amount: request.amount.toInt64,
    );

    final response = await _paymentServiceClient.createDirectPayment(r);

    return CreateDirectPaymentResponseDto(
      fee: response.fee.toInt(),
      transaction: response.transaction,
      slot: response.slot.toBigInt,
    );
  }

  Future<ShortenLinkResponseDto> shortenLink(
    ShortenLinkRequestDto request,
  ) async {
    final r = ShortenLinkRequest(fullLink: request.fullLink);
    final response = await _shortenerServiceClient.shortenLink(r);

    return ShortenLinkResponseDto(shortLink: response.shortLink);
  }

  Future<UnshortenLinkResponseDto> expandLink(
    UnshortenLinkRequestDto request,
  ) async {
    final r = ExpandLinkRequest(shortLink: request.shortLink);
    final response = await _shortenerServiceClient.expandLink(r);

    return UnshortenLinkResponseDto(fullLink: response.fullLink);
  }

  Future<void> addReferral(AmbassadorReferralRequestDto request) async {
    final grpcRequest = AddReferralRequest(
      ambassadorAddress: request.ambassadorAddress,
    );

    await _referralClient.addReferral(grpcRequest);
  }

  Future<AmbassadorStatsResponseDto> getReferralStats() async {
    final grpcRequest = GetStatsRequest();
    final grpcResponse = await _referralClient.getStats(grpcRequest);

    return AmbassadorStatsResponseDto(
      referralCount: grpcResponse.referralCount,
    );
  }

  Future<AmbassadorVerificationResponseDto> verifyReferralStatus() async {
    final grpcRequest = VerifyRequest();
    final grpcResponse = await _referralClient.verify(grpcRequest);

    return AmbassadorVerificationResponseDto(
      isAmbassador: grpcResponse.isAmbassador,
      isReferral: grpcResponse.isReferral,
    );
  }

  Future<CreatePaymentResponseDto> createPaymentEc(
    CreatePaymentRequestDto request,
  ) async {
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
  }

  Future<ReceivePaymentResponseDto> receivePaymentEc(
    ReceivePaymentRequestDto request,
  ) async {
    final r = ReceiveEscrowPaymentRequest(
      receiverAccount: request.receiverAccount,
      escrowAccount: request.escrowAccount,
    );
    final response = await _paymentServiceClient.receiveEscrowPayment(r);

    return ReceivePaymentResponseDto(
      transaction: response.transaction,
      slot: response.slot.toBigInt,
    );
  }

  Future<CancelPaymentResponseDto> cancelPaymentEc(
    CancelPaymentRequestDto request,
  ) async {
    final r = CancelEscrowPaymentRequest(
      senderAccount: request.senderAccount,
      escrowAccount: request.escrowAccount,
    );
    final response = await _paymentServiceClient.cancelEscrowPayment(r);

    return CancelPaymentResponseDto(
      transaction: response.transaction,
      slot: response.slot.toBigInt,
    );
  }

  Future<void> updateUserWalletCountry(String countryCode) async {
    final r = UpdateCountryRequest(countryCode: countryCode);
    await _userServiceClient.updateCountry(r);
  }

  Future<OutgoingQuoteResponseDto> getOutgoingDlnQuote(
    OutgoingQuoteRequestDto request,
  ) async {
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
  }

  Future<IncomingQuoteResponseDto> getIncomingDlnQuote(
    IncomingQuoteRequestDto request,
  ) async {
    final r = dln_proto.GetIncomingQuoteRequest(
      amount: request.amount.toInt64,
      senderAddress: request.senderAddress,
      senderBlockchain: request.senderBlockchain,
      receiverAddress: request.receiverAddress,
      solanaReferenceAddress: request.solanaReferenceAddress,
    );

    final response = await _dlnServiceClient.getIncomingQuote(r);

    return IncomingQuoteResponseDto(
      tx: QuoteTx(
        to: response.tx.to,
        data: response.tx.data,
        value: response.tx.value.toInt(),
      ),
      usdcInfo: QuoteUsdcInfo(
        usdcAddress: response.usdcInfo.usdcAddress,
        approvalAmount: response.usdcInfo.approvalAmount.toInt(),
      ),
      inputAmount: response.inputAmount.toInt(),
      receiverAmount: response.receiverAmount.toInt(),
      feeInUsdc: response.feeInUsdc.toInt(),
    );
  }

  Future<OrderIdDlnResponseDto> getDlnOrderId(
    OrderIdDlnRequestDto request,
  ) async {
    final r = dln_proto.GetOrderIdRequest(txId: request.txId);
    final response = await _dlnServiceClient.getOrderId(r);

    return OrderIdDlnResponseDto(
        orderId: response.hasOrderId() ? response.orderId : null);
  }

  Future<OrderStatusDlnResponseDto> getDlnOrderStatus(
    OrderStatusDlnRequestDto request,
  ) async {
    final r = dln_proto.GetOrderStatusRequest(orderId: request.orderId);
    final response = await _dlnServiceClient.getOrderStatus(r);

    return OrderStatusDlnResponseDto(
      status: mapDlnOrderStatus(response.status),
    );
  }

  Future<GasFeeResponseDto> getGasFees(
    GasFeeRequestDto request,
  ) async {
    final r = dln_proto.GetGasFeesRequest(network: request.network);
    final response = await _dlnServiceClient.getGasFees(r);

    return GasFeeResponseDto(
      low: mapProtoToGasFeeEstimate(response.low),
      medium: mapProtoToGasFeeEstimate(response.medium),
      high: mapProtoToGasFeeEstimate(response.high),
      estimatedBaseFee: response.estimatedBaseFee,
      networkCongestion: response.networkCongestion,
    );
  }

  Future<MoneygramChallengeSignResponseDto> signChallenge(
    MoneygramChallengeSignRequestDto request,
  ) async {
    final r = MoneygramChallengeSignRequest(signedTx: request.signedTx);
    final response = await _moneygramServiceClient.signChallenge(r);

    return MoneygramChallengeSignResponseDto(signedTx: response.signedTx);
  }

  Future<MoneygramSwapResponseDto> swapToSolana(
    SwapToSolanaRequestDto request,
  ) async {
    final r = SwapToSolanaRequest(
      amount: request.amount,
      solanaReceiverAddress: request.solanaReceiverAddress,
      stellarSenderAddress: request.stellarSenderAddress,
    );
    final response = await _moneygramServiceClient.swapToSolana(r);

    return MoneygramSwapResponseDto(encodedTx: response.encodedTx);
  }

  Future<MoneygramSwapResponseDto> swapToStellar(
    SwapToStellarRequestDto request,
  ) async {
    final r = SwapToStellarRequest(
      amount: request.amount,
      priorityFee: request.priorityFee,
      solanaSenderAddress: request.solanaSenderAddress,
      stellarReceiverAddress: request.stellarReceiverAddress,
    );
    final response = await _moneygramServiceClient.swapToStellar(r);

    return MoneygramSwapResponseDto(encodedTx: response.encodedTx);
  }

  Future<MoneygramFeeResponseDto> calculateMoneygramFee(
    MoneygramFeeRequestDto request,
  ) async {
    final r = MoneygramFeeRequest(
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
  }

  Future<void> fundXlmRequest(
    FundXlmRequestDto request,
  ) async {
    final r = FundXlmRequest(accountId: request.accountId);

    await _moneygramServiceClient.fundXlm(r);
  }

  Future<GetTokensMetaResponseDto> getTokensMeta() async {
    final request = GetTokensMetaRequest();
    final response = await _tokensServiceClient.getTokensMeta(request);

    return GetTokensMetaResponseDto(md5: response.md5);
  }

  Future<void> getTokensFile(String savePath) async {
    final request = GetTokensFileRequest();
    final response = await _tokensServiceClient.getTokensFile(request);

    final file = File(savePath);
    await file.writeAsBytes(response.content);
  }

  Future<FiatRateResponseDto> fetchFiatRate(FiatRateRequestDto request) async {
    final r = GetFiatRatesRequest(
      base: request.base,
      target: request.target,
    );
    final response = await _rateServiceClient.getFiatRates(r);

    return FiatRateResponseDto(rate: response.rate);
  }

  Future<DirectPaymentQuoteResponseDto> getDirectPaymentQuote(
    DirectPaymentQuoteRequestDto request,
  ) async {
    final r = GetDirectPaymentQuoteRequest(
      receiverAccount: request.receiverAccount,
      amount: request.amount.toInt64,
    );
    final response = await _paymentServiceClient.getDirectPaymentQuote(r);

    return DirectPaymentQuoteResponseDto(
      fee: response.fee.toInt(),
      totalAmount: response.totalAmount.toInt(),
    );
  }

  Future<EscrowPaymentQuoteResponseDto> getOutgoingEscrowPaymentQuote() async {
    final r = GetOutgoingEscrowPaymentQuoteRequest();
    final response =
        await _paymentServiceClient.getOutgoingEscrowPaymentQuote(r);

    return EscrowPaymentQuoteResponseDto(fee: response.fee.toInt());
  }

  Future<EscrowPaymentQuoteResponseDto> getIncomingEscrowPaymentQuote() async {
    final r = GetIncomingEscrowPaymentQuoteRequest();
    final response =
        await _paymentServiceClient.getIncomingEscrowPaymentQuote(r);

    return EscrowPaymentQuoteResponseDto(fee: response.fee.toInt());
  }
}
