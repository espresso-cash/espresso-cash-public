import 'package:dfunc/dfunc.dart';
import 'package:dio/dio.dart' hide Transformer;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'client.freezed.dart';
part 'client.g.dart';

@RestApi(baseUrl: 'https://api.onramp.money/onramp/api/v2')
abstract class OnRampMoneyApiClient {
  factory OnRampMoneyApiClient() => _OnRampMoneyApiClient(Dio());

  @POST('/sell/transaction/generateToken')
  Future<OnRampResponseDto<GenerateTokenResponseDto>> generateToken({
    @Body() required GenerateTokenRequestDto body,
    @Header('X-ONRAMP-SIGNATURE') required String signature,
    @Header('X-ONRAMP-APIKEY') required String apiKey,
    @Header('X-ONRAMP-PAYLOAD') required String payload,
  });
}

@freezed
class GenerateTokenRequestDto with _$GenerateTokenRequestDto {
  const factory GenerateTokenRequestDto({
    required String messageToSign,
    required String signedMessage,
    required String walletAddress,
    required String quantity,
    required String appId,
    required String coinId,
    required String chainId,
  }) = _GenerateTokenRequestDto;

  factory GenerateTokenRequestDto.fromJson(Map<String, dynamic> json) =>
      _$GenerateTokenRequestDtoFromJson(json);
}

@freezed
class GenerateTokenResponseDto with _$GenerateTokenResponseDto {
  const factory GenerateTokenResponseDto({
    required String token,
    required String depositAddress,
  }) = _GenerateTokenResponseDto;

  factory GenerateTokenResponseDto.fromJson(Map<String, dynamic> json) =>
      _$GenerateTokenResponseDtoFromJson(json);
}

@Freezed(genericArgumentFactories: true, toJson: false)
class OnRampResponseDto<T> with _$OnRampResponseDto<T> {
  const factory OnRampResponseDto({
    required T data,
  }) = _OnRampResponseDto<T>;

  factory OnRampResponseDto.fromJson(
    Map<String, dynamic> json,
    Transformer<Object?, T> fromJsonT,
  ) =>
      _$OnRampResponseDtoFromJson(json, fromJsonT);
}
