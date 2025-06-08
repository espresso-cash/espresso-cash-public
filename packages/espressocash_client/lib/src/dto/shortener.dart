import 'package:freezed_annotation/freezed_annotation.dart';

part 'shortener.freezed.dart';

@freezed
sealed class ShortenLinkRequestDto with _$ShortenLinkRequestDto {
  const factory ShortenLinkRequestDto({required String fullLink}) = _ShortenLinkRequestDto;
}

@freezed
sealed class ShortenLinkResponseDto with _$ShortenLinkResponseDto {
  const factory ShortenLinkResponseDto({required String shortLink}) = _ShortenLinkResponseDto;
}

@freezed
sealed class UnshortenLinkRequestDto with _$UnshortenLinkRequestDto {
  const factory UnshortenLinkRequestDto({required String shortLink}) = _UnshortenLinkRequestDto;
}

@freezed
sealed class UnshortenLinkResponseDto with _$UnshortenLinkResponseDto {
  const factory UnshortenLinkResponseDto({required String fullLink}) = _UnshortenLinkResponseDto;
}
