import 'package:freezed_annotation/freezed_annotation.dart';
part 'stellar.freezed.dart';
part 'stellar.g.dart';

@freezed
class InitiateStellarDepositRequestDto with _$InitiateStellarDepositRequestDto {
  const factory InitiateStellarDepositRequestDto({
    required String signedTx,
  }) = _InitiateStellarDepositRequestDto;

  factory InitiateStellarDepositRequestDto.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$InitiateStellarDepositRequestDtoFromJson(json);
}

@freezed
class InitiateStellarDepositResponseDto
    with _$InitiateStellarDepositResponseDto {
  const factory InitiateStellarDepositResponseDto({
    required String url,
  }) = _InitiateStellarDepositResponseDto;

  factory InitiateStellarDepositResponseDto.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$InitiateStellarDepositResponseDtoFromJson(json);
}
