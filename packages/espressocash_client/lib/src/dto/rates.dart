import 'package:freezed_annotation/freezed_annotation.dart';

part 'rates.freezed.dart';

@freezed
abstract class CryptoRateResponseDto with _$CryptoRateResponseDto {
  const factory CryptoRateResponseDto({required double usdc}) = _CryptoRateResponseDto;
}

@freezed
abstract class FiatRateRequestDto with _$FiatRateRequestDto {
  const factory FiatRateRequestDto({required String base, required String target}) =
      _FiatRateRequestDto;
}

@freezed
abstract class FiatRateResponseDto with _$FiatRateResponseDto {
  const factory FiatRateResponseDto({required double rate}) = _FiatRateResponseDto;
}
