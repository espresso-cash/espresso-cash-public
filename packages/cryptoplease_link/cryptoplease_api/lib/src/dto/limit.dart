import 'package:freezed_annotation/freezed_annotation.dart';

part 'limit.freezed.dart';
part 'limit.g.dart';

@freezed
class LimitResponseDto with _$LimitResponseDto {
  const factory LimitResponseDto({
    required double minAmount,
  }) = _LimitResponseDto;

  const LimitResponseDto._();

  factory LimitResponseDto.fromJson(Map<String, dynamic> json) =>
      _$LimitResponseDtoFromJson(json);
}

@freezed
class LimitRequestDto with _$LimitRequestDto {
  const factory LimitRequestDto({
    required String tokenSymbol,
  }) = _LimitRequestDto;

  factory LimitRequestDto.fromJson(Map<String, dynamic> json) =>
      _$LimitRequestDtoFromJson(json);
}
