import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_tokens.freezed.dart';
part 'get_tokens.g.dart';

@freezed
class GetTokensMetaResponseDto with _$GetTokensMetaResponseDto {
  const factory GetTokensMetaResponseDto({
    required String md5,
  }) = _GetTokensMetaResponseDto;

  factory GetTokensMetaResponseDto.fromJson(Map<String, dynamic> json) =>
      _$GetTokensMetaResponseDtoFromJson(json);
}
