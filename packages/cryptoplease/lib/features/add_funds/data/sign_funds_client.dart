import 'package:cryptoplease/config.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:retrofit/retrofit.dart';

part 'sign_funds_client.freezed.dart';
part 'sign_funds_client.g.dart';

@RestApi(baseUrl: 'https://$moonpayHost/')
abstract class SignFundsClient {
  factory SignFundsClient() => _SignFundsClient(Dio());

  @GET('/sign')
  Future<SignedUrlDto> sign(
    @Queries() SignFundsRequestDto request,
  );
}

@freezed
class SignedUrlDto with _$SignedUrlDto {
  const factory SignedUrlDto({
    required String signedUrl,
  }) = _SignedUrlDto;

  factory SignedUrlDto.fromJson(Map<String, dynamic> json) =>
      _$SignedUrlDtoFromJson(json);
}

@freezed
class SignFundsRequestDto with _$SignFundsRequestDto {
  const factory SignFundsRequestDto({
    required String receiverAddress,
    required String tokenSymbol,
    required double value,
  }) = _SignFundsRequestDto;

  factory SignFundsRequestDto.fromJson(Map<String, dynamic> json) =>
      _$SignFundsRequestDtoFromJson(json);
}
