import 'package:dio/dio.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/http.dart';

import 'coingecko_client.dart';

part 'jupiter_client.freezed.dart';
part 'jupiter_client.g.dart';

@injectable
@RestApi(baseUrl: 'https://price.jup.ag/v6/')
abstract class JupiterPriceClient {
  @factoryMethod
  factory JupiterPriceClient(CoingeckoClient client) =>
      _JupiterPriceClient(client.dio);

  @GET('/price')
  @Extra({maxAgeOption: Duration(minutes: 1)})
  Future<PriceResponseDto> getPrice(@Queries() RateRequestDto request);
}

@freezed
class PriceResponseDto with _$PriceResponseDto {
  const factory PriceResponseDto({
    required Map<String, PricesMapDto> data,
  }) = _PriceResponseDto;

  factory PriceResponseDto.fromJson(Map<String, dynamic> data) =>
      _$PriceResponseDtoFromJson(data);
}

@freezed
class PricesMapDto with _$PricesMapDto {
  const factory PricesMapDto({
    required double price,
    required String vsTokenSymbol,
  }) = _PricesMapDto;

  const PricesMapDto._();

  factory PricesMapDto.fromJson(Map<String, dynamic> data) =>
      _$PricesMapDtoFromJson(data);
}

@freezed
class RateRequestDto with _$RateRequestDto {
  const factory RateRequestDto({
    required IList<String> ids,
  }) = _RateRequestDto;

  factory RateRequestDto.fromJson(Map<String, dynamic> json) =>
      _$RateRequestDtoFromJson(json);
}
