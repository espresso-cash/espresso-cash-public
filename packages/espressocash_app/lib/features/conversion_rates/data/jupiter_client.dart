import 'package:dio/dio.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/http.dart';

import 'cache_client.dart';

part 'jupiter_client.freezed.dart';
part 'jupiter_client.g.dart';

@injectable
@RestApi(baseUrl: 'https://price.jup.ag/v6/')
abstract class JupiterPriceClient {
  @factoryMethod
  factory JupiterPriceClient(DioCacheClient client) =>
      _JupiterPriceClient(client.dio);

  @GET('/price')
  @Extra({maxAgeOption: Duration(minutes: 1)})
  Future<PriceResponseDto> getPrice(@Queries() TokenRateRequestDto request);
}

@freezed
class PriceResponseDto with _$PriceResponseDto {
  const factory PriceResponseDto({
    required Map<String, TokenPricesMapDto> data,
  }) = _PriceResponseDto;

  factory PriceResponseDto.fromJson(Map<String, dynamic> data) =>
      _$PriceResponseDtoFromJson(data);
}

@freezed
class TokenPricesMapDto with _$TokenPricesMapDto {
  const factory TokenPricesMapDto({
    required double price,
    required String vsTokenSymbol,
  }) = _TokenPricesMapDto;

  const TokenPricesMapDto._();

  factory TokenPricesMapDto.fromJson(Map<String, dynamic> data) =>
      _$TokenPricesMapDtoFromJson(data);
}

@freezed
class TokenRateRequestDto with _$TokenRateRequestDto {
  const factory TokenRateRequestDto({
    required IList<String> ids,
  }) = _TokenRateRequestDto;

  factory TokenRateRequestDto.fromJson(Map<String, dynamic> json) =>
      _$TokenRateRequestDtoFromJson(json);
}
