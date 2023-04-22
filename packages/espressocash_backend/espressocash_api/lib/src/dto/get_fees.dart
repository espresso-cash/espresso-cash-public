import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_fees.freezed.dart';
part 'get_fees.g.dart';

@freezed
class GetFeesResponseDto with _$GetFeesResponseDto {
  const factory GetFeesResponseDto({
    required DirectPaymentFeeDto directPayment,
    required int splitKeyPayment,
    required int escrowPayment,
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
