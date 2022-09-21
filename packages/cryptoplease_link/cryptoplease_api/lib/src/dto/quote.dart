import 'package:freezed_annotation/freezed_annotation.dart';

part 'quote.freezed.dart';
part 'quote.g.dart';

@freezed
class QuoteResponseDto with _$QuoteResponseDto {
  const factory QuoteResponseDto({
    required double quoteAmount,
    required double feeAmount,
    required double networkFeeAmount,
    required double quotePrice,
  }) = _Quote;

  const QuoteResponseDto._();

  factory QuoteResponseDto.fromJson(Map<String, dynamic> json) =>
      _$QuoteResponseDtoFromJson(json);
}

@freezed
class QuoteRequestDto with _$QuoteRequestDto {
  const factory QuoteRequestDto({
    required String tokenSymbol,
    required String value,
  }) = _QuoteRequestDto;

  factory QuoteRequestDto.fromJson(Map<String, dynamic> json) =>
      _$QuoteRequestDtoFromJson(json);
}
