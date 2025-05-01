import 'package:freezed_annotation/freezed_annotation.dart';

part 'tokens.freezed.dart';

@freezed
class GetTokensMetaResponseDto with _$GetTokensMetaResponseDto {
  const factory GetTokensMetaResponseDto({required String md5}) = _GetTokensMetaResponseDto;
}
