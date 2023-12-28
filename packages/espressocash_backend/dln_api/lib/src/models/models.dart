import 'package:freezed_annotation/freezed_annotation.dart';

part 'models.freezed.dart';
part 'models.g.dart';

@freezed
class OrderEstimation with _$OrderEstimation {
  const factory OrderEstimation({
    required TokenWithApproximateOperatingExpense srcChainTokenIn,
    TokenWithMaxRefundAmount? srcChainTokenOut,
    required DstChainTokenOutResponseType dstChainTokenOut,
    double? recommendedSlippage,
    required List<dynamic> costsDetails,
  }) = _OrderEstimation;

  factory OrderEstimation.fromJson(Map<String, dynamic> json) =>
      _$OrderEstimationFromJson(json);
}

@freezed
class TokenWithMaxRefundAmount with _$TokenWithMaxRefundAmount {
  const factory TokenWithMaxRefundAmount({
    required String address,
    required String name,
    required String symbol,
    required int decimals,
    required String amount,
    required String maxRefundAmount,
  }) = _TokenWithMaxRefundAmount;

  factory TokenWithMaxRefundAmount.fromJson(Map<String, dynamic> json) =>
      _$TokenWithMaxRefundAmountFromJson(json);
}

@freezed
class TokenWithApproximateOperatingExpense
    with _$TokenWithApproximateOperatingExpense {
  const factory TokenWithApproximateOperatingExpense({
    required String address,
    required String name,
    required String symbol,
    required int decimals,
    required String amount,
    required String approximateOperatingExpense,
    required bool mutatedWithOperatingExpense,
  }) = _TokenWithApproximateOperatingExpense;

  factory TokenWithApproximateOperatingExpense.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$TokenWithApproximateOperatingExpenseFromJson(json);
}

@freezed
class DstChainTokenOutResponseType with _$DstChainTokenOutResponseType {
  const factory DstChainTokenOutResponseType({
    required String address,
    required String name,
    required String symbol,
    required int decimals,
    required String amount,
    required String recommendedAmount,
    String? withoutAdditionalTakerRewardsAmount,
  }) = _DstChainTokenOutResponseType;

  factory DstChainTokenOutResponseType.fromJson(Map<String, dynamic> json) =>
      _$DstChainTokenOutResponseTypeFromJson(json);
}

@freezed
class TxQuote with _$TxQuote {
  const factory TxQuote({
    required String allowanceTarget,
    required String allowanceValue,
  }) = _TxQuote;

  factory TxQuote.fromJson(Map<String, dynamic> json) =>
      _$TxQuoteFromJson(json);
}

@freezed
class Order with _$Order {
  const factory Order({
    required double approximateFulfillmentDelay,
  }) = _Order;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);
}

@freezed
class DlnTx with _$DlnTx {
  const factory DlnTx({
    required String data,
    String? to,
    String? value,
    double? gasLimit,
  }) = _DlnTx;

  factory DlnTx.fromJson(Map<String, dynamic> json) => _$DlnTxFromJson(json);
}

@freezed
class Offer with _$Offer {
  const factory Offer({
    required int chainId,
    required String tokenAddress,
    required String amount,
  }) = _Offer;

  factory Offer.fromJson(Map<String, dynamic> json) => _$OfferFromJson(json);
}

@freezed
class OrderStruct with _$OrderStruct {
  const factory OrderStruct({
    required int makerOrderNonce,
    required String makerSrc,
    required Offer giveOffer,
    required String receiverDst,
    required Offer takeOffer,
    required String givePatchAuthoritySrc,
    required String orderAuthorityAddressDst,
    String? allowedTakerDst,
    String? allowedCancelBeneficiarySrc,
    String? externalCall,
  }) = _OrderStruct;

  factory OrderStruct.fromJson(Map<String, dynamic> json) =>
      _$OrderStructFromJson(json);
}
