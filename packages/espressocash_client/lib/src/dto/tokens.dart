import 'package:freezed_annotation/freezed_annotation.dart';

part 'tokens.freezed.dart';

@freezed
sealed class GetTokensMetaResponseDto with _$GetTokensMetaResponseDto {
  const factory GetTokensMetaResponseDto({required String md5}) = _GetTokensMetaResponseDto;
}
