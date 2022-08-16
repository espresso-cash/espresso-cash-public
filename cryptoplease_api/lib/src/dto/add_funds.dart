import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_funds.freezed.dart';
part 'add_funds.g.dart';

@freezed
class AddFundsResponseDto with _$AddFundsResponseDto {
  const factory AddFundsResponseDto({
    required String signedUrl,
  }) = _AddFundsResponseDto;

  factory AddFundsResponseDto.fromJson(Map<String, dynamic> json) =>
      _$AddFundsResponseDtoFromJson(json);
}

@freezed
class AddFundsRequestDto with _$AddFundsRequestDto {
  const factory AddFundsRequestDto({
    required String receiverAddress,
    required String tokenSymbol,
    required String value,
  }) = _AddFundsRequestDto;

  factory AddFundsRequestDto.fromJson(Map<String, dynamic> json) =>
      _$AddFundsRequestDtoFromJson(json);
}
