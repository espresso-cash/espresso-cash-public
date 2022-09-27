// ignore_for_file: invalid_annotation_target

part of 'moonpay_client.dart';

@freezed
class BuyQuoteResponseDto with _$BuyQuoteResponseDto {
  const factory BuyQuoteResponseDto({
    required double quoteCurrencyAmount,
    required double quoteCurrencyPrice,
    required double feeAmount,
    required double networkFeeAmount,
    required double totalAmount,
  }) = _BuyQuoteResponseDto;

  factory BuyQuoteResponseDto.fromJson(Map<String, dynamic> json) =>
      _$BuyQuoteResponseDtoFromJson(json);
}

@freezed
class LimitResponseDto with _$LimitResponseDto {
  const factory LimitResponseDto({
    required MoonpayCurrency quoteCurrency,
  }) = _LimitResponseDto;

  factory LimitResponseDto.fromJson(Map<String, dynamic> json) =>
      _$LimitResponseDtoFromJson(json);
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

@freezed
class AskPriceResponseDto with _$AskPriceResponseDto {
  const factory AskPriceResponseDto({
    @JsonKey(name: 'USD') double? usd,
  }) = _AskPriceResponseDto;

  factory AskPriceResponseDto.fromJson(Map<String, dynamic> json) =>
      _$AskPriceResponseDtoFromJson(json);
}
