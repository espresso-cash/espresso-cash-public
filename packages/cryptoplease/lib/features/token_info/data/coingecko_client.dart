import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:retrofit/retrofit.dart';

part 'coingecko_client.freezed.dart';
part 'coingecko_client.g.dart';

@RestApi(baseUrl: 'https://api.coingecko.com/api/v3')
abstract class CoingeckoClient {
  factory CoingeckoClient() => _CoingeckoClient(Dio());

  @GET('/coins/{id}')
  Future<TokenInfoResponseDto> getCoinInfo(
    @Path() String id,
    @Queries() TokenInfoRequestDto request,
  );

  @GET('/coins/{id}/market_chart')
  Future<TokenChartResponseDto> getCoinChart(
    @Path() String id,
    @Queries() TokenChartRequestDto request,
  );
}

@freezed
class TokenInfoRequestDto with _$TokenInfoRequestDto {
  // ignore: invalid_annotation_target, it's valid
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory TokenInfoRequestDto({
    @Default(false) bool localization,
    @Default(false) bool tickers,
    @Default(false) bool marketData,
    @Default(false) bool communityData,
    @Default(false) bool developerData,
    @Default(false) bool sparkline,
  }) = _TokenInfoRequestDto;

  factory TokenInfoRequestDto.fromJson(Map<String, dynamic> json) =>
      _$TokenInfoRequestDtoFromJson(json);
}

@freezed
class TokenInfoResponseDto with _$TokenInfoResponseDto {
  // ignore: invalid_annotation_target, it's valid
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory TokenInfoResponseDto({
    String? id,
    String? name,
    Map<String, dynamic>? description,
    Map<String, dynamic>? links,
    int? marketCapRank,
  }) = _TokenInfoResponseDto;

  const TokenInfoResponseDto._();

  factory TokenInfoResponseDto.fromJson(Map<String, dynamic> json) =>
      _$TokenInfoResponseDtoFromJson(json);
}

@freezed
class TokenChartRequestDto with _$TokenChartRequestDto {
  // ignore: invalid_annotation_target, it's valid
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory TokenChartRequestDto({
    @Default('usd') String vsCurrency,
    @Default('1') String days,
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
