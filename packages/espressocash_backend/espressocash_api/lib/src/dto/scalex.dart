import 'package:freezed_annotation/freezed_annotation.dart';

part 'scalex.freezed.dart';
part 'scalex.g.dart';

@freezed
class ScalexSignResponseDto with _$ScalexSignResponseDto {
  const factory ScalexSignResponseDto({
    required String timestamp,
    required String signature,
  }) = _ScalexSignResponseDto;

  factory ScalexSignResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ScalexSignResponseDtoFromJson(json);
}

@freezed
class ScalexSignRequestDto with _$ScalexSignRequestDto {
  const factory ScalexSignRequestDto({
    required String data,
    required String path,
  }) = _ScalexSignRequestDto;

  factory ScalexSignRequestDto.fromJson(Map<String, dynamic> json) =>
      _$ScalexSignRequestDtoFromJson(json);
}
