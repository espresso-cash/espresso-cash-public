import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_tokens.freezed.dart';
part 'get_tokens.g.dart';

@freezed
class GetTokenResponseDto with _$GetTokenResponseDto {
  const factory GetTokenResponseDto({
    required List<Token> tokens,
  }) = _GetTokenResponseDto;

  factory GetTokenResponseDto.fromJson(Map<String, dynamic> json) =>
      _$GetTokenResponseDtoFromJson(json);
}

@freezed
class Token with _$Token {
  const factory Token({
    required String address,
    required int chainId,
    required String symbol,
    required String name,
    required int decimals,
    required String logoURI,
    required List<String> tags,
    required Map<String, String> extensions,
  }) = _Token;

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);
}
