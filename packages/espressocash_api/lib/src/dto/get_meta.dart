import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_meta.freezed.dart';
part 'get_meta.g.dart';

@freezed
class GetTokenListMetaResponseDto with _$GetTokenListMetaResponseDto {
  const factory GetTokenListMetaResponseDto({
    required String md5,
  }) = _GetTokenListMetaResponseDto;

  factory GetTokenListMetaResponseDto.fromJson(Map<String, dynamic> json) =>
      _$GetTokenListMetaResponseDtoFromJson(json);
}
