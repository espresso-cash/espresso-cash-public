import 'package:freezed_annotation/freezed_annotation.dart';

part 'swap.freezed.dart';
part 'swap.g.dart';

@freezed
class SwapResponseDto with _$SwapResponseDto {
  const factory SwapResponseDto({
    required String swapTransaction,
  }) = _SwapResponseDto;

  factory SwapResponseDto.fromJson(Map<String, dynamic> json) =>
      _$SwapResponseDtoFromJson(json);
}
