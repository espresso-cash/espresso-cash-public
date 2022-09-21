part of 'moonpay_client.dart';

@freezed
class MoonpayQuoteDto with _$MoonpayQuoteDto {
  const factory MoonpayQuoteDto({
    required String accountId,
    required String baseCurrencyCode,
    required double baseCurrencyAmount,
    required String quoteCurrencyCode,
    required double quoteCurrencyAmount,
    required double quoteCurrencyPrice,
    required double feeAmount,
    required double extraFeeAmount,
    required double extraFeePercentage,
    required double networkFeeAmount,
    required bool networkFeeAmountNonRefundable,
    required double totalAmount,
    required dynamic feeDiscountType,
    required dynamic feeAmountDiscount,
    required String feeRuleId,
    required MoonpayCurrency baseCurrency,
    required MoonpayCurrency currency,
  }) = _MoonpayQuoteDto;

  factory MoonpayQuoteDto.fromJson(Map<String, dynamic> json) =>
      _$MoonpayQuoteDtoFromJson(json);
}

@freezed
class MoonpayLimitDto with _$MoonpayLimitDto {
  const factory MoonpayLimitDto({
    required String paymentMethod,
    required MoonpayCurrency baseCurrency,
    required MoonpayCurrency quoteCurrency,
  }) = _MoonpayLimitDto;

  factory MoonpayLimitDto.fromJson(Map<String, dynamic> json) =>
      _$MoonpayLimitDtoFromJson(json);
}

@freezed
class MoonpayCurrency with _$MoonpayCurrency {
  const factory MoonpayCurrency({
    required String code,
    required int minBuyAmount,
  }) = _MoonpayCurrency;

  factory MoonpayCurrency.fromJson(Map<String, dynamic> json) =>
      _$MoonpayCurrencyFromJson(json);
}
