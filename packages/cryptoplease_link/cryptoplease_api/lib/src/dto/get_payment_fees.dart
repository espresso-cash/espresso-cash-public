import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_payment_fees.freezed.dart';
part 'get_payment_fees.g.dart';

@freezed
class GetPaymentFeesResponseDto with _$GetPaymentFeesResponseDto {
  const factory GetPaymentFeesResponseDto({
    required DirectPaymentFeeDto directPayment,
    required int splitKeyPayment,
  }) = _GetPaymentFeesResponseDto;

  factory GetPaymentFeesResponseDto.fromJson(Map<String, dynamic> json) =>
      _$GetPaymentFeesResponseDtoFromJson(json);
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
