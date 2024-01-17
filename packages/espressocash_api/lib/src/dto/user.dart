import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class WalletCountryRequestDto with _$WalletCountryRequestDto {
  const factory WalletCountryRequestDto({
    required String countryCode,
  }) = _WalletCountryRequestDto;

  factory WalletCountryRequestDto.fromJson(Map<String, dynamic> json) =>
      _$WalletCountryRequestDtoFromJson(json);
}
