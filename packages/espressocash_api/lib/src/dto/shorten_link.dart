import 'package:freezed_annotation/freezed_annotation.dart';

part 'shorten_link.g.dart';
part 'shorten_link.freezed.dart';

@freezed
class ShortenLinkRequestDto with _$ShortenLinkRequestDto {
  const factory ShortenLinkRequestDto({
    required String fullLink,
  }) = _ShortenLinkRequestDto;

  factory ShortenLinkRequestDto.fromJson(Map<String, dynamic> json) =>
      _$ShortenLinkRequestDtoFromJson(json);
}

@freezed
class ShortenLinkResponseDto with _$ShortenLinkResponseDto {
  const factory ShortenLinkResponseDto({
    required String shortLink,
  }) = _ShortenLinkResponseDto;

  factory ShortenLinkResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ShortenLinkResponseDtoFromJson(json);
}

@freezed
class UnshortenLinkRequestDto with _$UnshortenLinkRequestDto {
  const factory UnshortenLinkRequestDto({
    required String shortLink,
  }) = _UnshortenLinkRequestDto;

  factory UnshortenLinkRequestDto.fromJson(Map<String, dynamic> json) =>
      _$UnshortenLinkRequestDtoFromJson(json);
}

@freezed
class UnshortenLinkResponseDto with _$UnshortenLinkResponseDto {
  const factory UnshortenLinkResponseDto({
    required String fullLink,
  }) = _UnshortenLinkResponseDto;

  factory UnshortenLinkResponseDto.fromJson(Map<String, dynamic> json) =>
      _$UnshortenLinkResponseDtoFromJson(json);
}
