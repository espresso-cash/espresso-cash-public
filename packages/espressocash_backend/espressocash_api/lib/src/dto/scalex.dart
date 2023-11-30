// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'scalex.freezed.dart';
part 'scalex.g.dart';

@freezed
class GenerateScalexLinkResponseDto with _$GenerateScalexLinkResponseDto {
  const factory GenerateScalexLinkResponseDto({
    required String signedUrl,
  }) = _GenerateScalexLinkResponseDto;

  factory GenerateScalexLinkResponseDto.fromJson(Map<String, dynamic> json) =>
      _$GenerateScalexLinkResponseDtoFromJson(json);
}

@freezed
class GenerateScalexLinkRequestDto with _$GenerateScalexLinkRequestDto {
  const factory GenerateScalexLinkRequestDto({
    required String type,
    required String address,
    required String email,
  }) = _GenerateScalexLinkRequestDto;

  factory GenerateScalexLinkRequestDto.fromJson(Map<String, dynamic> json) =>
      _$GenerateScalexLinkRequestDtoFromJson(json);
}

@freezed
class OrderStatusScalexRequestDto with _$OrderStatusScalexRequestDto {
  const factory OrderStatusScalexRequestDto({
    required String referenceId,
  }) = _OrderStatusScalexRequestDto;

  factory OrderStatusScalexRequestDto.fromJson(Map<String, dynamic> json) =>
      _$OrderStatusScalexRequestDtoFromJson(json);
}

@freezed
class OrderStatusScalexResponseDto with _$OrderStatusScalexResponseDto {
  const factory OrderStatusScalexResponseDto({
    @JsonKey(unknownEnumValue: ScalexOrderStatus.unknown)
    required ScalexOrderStatus status,
  }) = _OrderStatusScalexResponseDto;

  factory OrderStatusScalexResponseDto.fromJson(Map<String, dynamic> json) =>
      _$OrderStatusScalexResponseDtoFromJson(json);
}

@JsonEnum()
enum ScalexOrderStatus {
  pending,
  completed,
  unknown,
}
