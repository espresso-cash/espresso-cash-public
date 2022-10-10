import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:retrofit/retrofit.dart';

part 'coingecko_client.freezed.dart';
part 'coingecko_client.g.dart';

@RestApi(baseUrl: 'https://api.coingecko.com/api/v3')
abstract class CoingeckoClient {
  factory CoingeckoClient() => _CoingeckoClient(Dio());

  @GET('/coins/{id}')
  Future<TokenDetailsResponseDto> getCoinDetails(
    @Path() String id,
    @Queries() TokenDetailsRequestDto request,
  );

  @GET('/coins/{id}/market_chart')
  Future<TokenChartResponseDto> getCoinChart(
    @Path() String id,
    @Queries() TokenChartRequestDto request,
  );
}

@freezed
class TokenDetailsRequestDto with _$TokenDetailsRequestDto {
  // ignore: invalid_annotation_target, it's valid
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory TokenDetailsRequestDto({
    @Default(false) bool localization,
    @Default(false) bool tickers,
    @Default(false) bool marketData,
    @Default(false) bool communityData,
    @Default(false) bool developerData,
    @Default(false) bool sparkline,
  }) = _TokenDetailsRequestDto;

  factory TokenDetailsRequestDto.fromJson(Map<String, dynamic> json) =>
      _$TokenDetailsRequestDtoFromJson(json);
}

@freezed
class TokenDetailsResponseDto with _$TokenDetailsResponseDto {
  // ignore: invalid_annotation_target, it's valid
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory TokenDetailsResponseDto({
    String? id,
    String? name,
    Map<String, dynamic>? description,
    Map<String, dynamic>? links,
    int? marketCapRank,
  }) = _TokenDetailsResponseDto;

  const TokenDetailsResponseDto._();

  factory TokenDetailsResponseDto.fromJson(Map<String, dynamic> json) =>
      _$TokenDetailsResponseDtoFromJson(json);
}

@freezed
class TokenChartRequestDto with _$TokenChartRequestDto {
  // ignore: invalid_annotation_target, it's valid
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory TokenChartRequestDto({
    @Default('usd') String vsCurrency,
    @Default('1') String days,
    String? interval,
  }) = _TokenChartRequestDto;

  factory TokenChartRequestDto.fromJson(Map<String, dynamic> json) =>
      _$TokenChartRequestDtoFromJson(json);
}

@freezed
class TokenChartResponseDto with _$TokenChartResponseDto {
  const factory TokenChartResponseDto({
    // ignore: invalid_annotation_target, its' valid
    @JsonKey(fromJson: _parseChartResponse) List<TokenChartItem>? prices,
  }) = _TokenChartResponseDto;

  factory TokenChartResponseDto.fromJson(Map<String, dynamic> data) =>
      _$TokenChartResponseDtoFromJson(data);
}

List<TokenChartItem> _parseChartResponse(List<dynamic> data) => data
    .map(
      (e) => TokenChartItem(
        date: DateTime.fromMillisecondsSinceEpoch((e as List).first as int),
        price: e.last as double,
      ),
    )
    .toList();

@freezed
class TokenChartItem with _$TokenChartItem {
  const factory TokenChartItem({
    DateTime? date,
    double? price,
  }) = _TokenChartItem;

  const TokenChartItem._();

  factory TokenChartItem.fromJson(Map<String, dynamic> data) =>
      _$TokenChartItemFromJson(data);
}
