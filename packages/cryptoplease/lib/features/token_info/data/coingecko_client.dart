import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:retrofit/retrofit.dart';

part 'coingecko_client.freezed.dart';
part 'coingecko_client.g.dart';

@RestApi(baseUrl: 'https://api.coingecko.com/api/v3')
abstract class CoingeckoClient {
  factory CoingeckoClient() =>
      _CoingeckoClient(Dio()..options.listFormat = ListFormat.csv);

  @GET('/coins/{id}')
  Future<Map<String, String>> getCoinInfo(
    //TODO result
    @Path() String id,
    @Queries() CoinInfoRequestDto request,
  );

  @GET('/coins/{id}/market_chart')
  Future<Map<String, String>> getCoinChart(
    //TODO
    @Path() String id,
    @Queries() CoinMarketChartRequestDto request,
  );
}

@freezed
class CoinInfoRequestDto with _$CoinInfoRequestDto {
  // ignore: invalid_annotation_target, it's valid
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory CoinInfoRequestDto({
    @Default(false) bool localization,
    @Default(false) bool tickers,
    @Default(false) bool marketData,
    @Default(false) bool communityData,
    @Default(false) bool developerData,
    @Default(false) bool sparkline,
  }) = _RateRequestDto;

  factory CoinInfoRequestDto.fromJson(Map<String, dynamic> json) =>
      _$CoinInfoRequestDtoFromJson(json);
}

@freezed
class CoinMarketChartRequestDto with _$CoinMarketChartRequestDto {
  // ignore: invalid_annotation_target, it's valid
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory CoinMarketChartRequestDto({
    @Default('usd') String vscurrency,
    @Default('1') String days,
    @Default('daily') String interval,
  }) = _CoinMarketChartRequestDto;

  factory CoinMarketChartRequestDto.fromJson(Map<String, dynamic> json) =>
      _$CoinMarketChartRequestDtoFromJson(json);
}
