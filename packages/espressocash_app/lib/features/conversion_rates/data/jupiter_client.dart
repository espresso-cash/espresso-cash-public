// ignore_for_file: avoid-type-casts

import 'package:dio/dio.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import 'cache_client.dart';

part 'jupiter_client.freezed.dart';
part 'jupiter_client.g.dart';

@injectable
@RestApi(baseUrl: 'https://lite-api.jup.ag')
abstract class JupiterPriceClient {
  @factoryMethod
  factory JupiterPriceClient(DioCacheClient client) => _JupiterPriceClient(client.dio);

  @GET('/price/v3')
  @Extra({maxAgeOption: Duration(minutes: 1)})
  Future<PriceResponseDto> getPrice(@Queries() TokenRateRequestDto request);
}

@freezed
class PriceResponseDto with _$PriceResponseDto {
  const factory PriceResponseDto({required Map<String, TokenPricesMapDto> data}) =
      _PriceResponseDto;

  factory PriceResponseDto.fromJson(Map<String, dynamic> json) => PriceResponseDto(
    data: Map<String, TokenPricesMapDto>.from(
      json.map(
        (key, value) => MapEntry(key, TokenPricesMapDto.fromJson(value as Map<String, dynamic>)),
      ),
    ),
  );
}

class TokenPricesMapDto {
  const TokenPricesMapDto({required this.usdPrice});

  factory TokenPricesMapDto.fromJson(Map<String, dynamic> json) =>
      TokenPricesMapDto(usdPrice: (json['usdPrice'] as num).toDouble());
  final double usdPrice;

  String get price => usdPrice.toString();

  Map<String, dynamic> toJson() => {'usdPrice': usdPrice};
}

@freezed
class TokenRateRequestDto with _$TokenRateRequestDto {
  const factory TokenRateRequestDto({required IList<String> ids}) = _TokenRateRequestDto;

  factory TokenRateRequestDto.fromJson(Map<String, dynamic> json) =>
      _$TokenRateRequestDtoFromJson(json);
}
