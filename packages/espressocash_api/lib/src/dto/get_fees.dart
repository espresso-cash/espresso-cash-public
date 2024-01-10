import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_fees.freezed.dart';
part 'get_fees.g.dart';

@freezed
class GetFeesResponseDto with _$GetFeesResponseDto {
  const factory GetFeesResponseDto({
    required DirectPaymentFeeDto directPayment,
    required int escrowPayment,
    required int escrowPaymentAtaFee,
    required int splitKeyPayment,
    @Default(WithdrawFeeDto()) WithdrawFeeDto withdrawFeePercentage,
  }) = _GetFeesResponseDto;

  factory GetFeesResponseDto.fromJson(Map<String, dynamic> json) =>
      _$GetFeesResponseDtoFromJson(json);
}

@freezed
class DirectPaymentFeeDto with _$DirectPaymentFeeDto {
  const factory DirectPaymentFeeDto({
    required int ataExists,
    required int ataDoesNotExist,
  }) = _DirectPaymentFeeDto;

  factory DirectPaymentFeeDto.fromJson(Map<String, dynamic> json) =>
      _$DirectPaymentFeeDtoFromJson(json);
}

@freezed
class WithdrawFeeDto with _$WithdrawFeeDto {
  const factory WithdrawFeeDto({
    @Default(0) double scalex,
    @Default(0) double kado,
    @Default(0) double rampNetwork,
    @Default(0) double coinflow,
    @Default(0) double guardarian,
  }) = _WithdrawFeeDto;

  factory WithdrawFeeDto.fromJson(Map<String, dynamic> json) =>
      _$WithdrawFeeDtoFromJson(json);
}
