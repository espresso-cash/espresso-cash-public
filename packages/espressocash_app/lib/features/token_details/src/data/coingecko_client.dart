// ignore_for_file: invalid_annotation_target

import 'package:dio/dio.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../token_details.dart';

part 'coingecko_client.freezed.dart';
part 'coingecko_client.g.dart';

@injectable
@RestApi(baseUrl: 'https://api.coingecko.com/api/v3')
abstract class DetailsCoingeckoClient {
  @factoryMethod
  factory DetailsCoingeckoClient(Dio dio) = _DetailsCoingeckoClient;

  @GET('/coins/{id}')
  Future<TokenDetailsResponseDto> getCoinDetails(
    @Path() String id,
    @Queries() TokenDetailsRequestDto request,
  );
}

@freezed
class TokenDetailsRequestDto with _$TokenDetailsRequestDto {
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
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory TokenDetailsResponseDto({
    String? id,
    String? name,
    IMap<String, String>? description,
    int? marketCapRank,
    MarketData? marketData,
  }) = _TokenDetailsResponseDto;

  const TokenDetailsResponseDto._();

  factory TokenDetailsResponseDto.fromJson(Map<String, dynamic> json) =>
      _$TokenDetailsResponseDtoFromJson(json);
}

@freezed
class MarketData with _$MarketData {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory MarketData({
    required IMap<String, double>? currentPrice,
  }) = _MarketData;

  factory MarketData.fromJson(Map<String, dynamic> json) =>
      _$MarketDataFromJson(json);
}

extension TokenDetailsResponseExt on TokenDetailsResponseDto {
  TokenDetails toModel({
    required String name,
    required String fiatCurrency,
  }) {
    final price = marketData?.currentPrice;

    return TokenDetails(
      name: this.name ?? name,
      description: _removeHtmlTags(description?['en'] ?? ''),
      marketCapRank: marketCapRank,
      marketPrice: price?[fiatCurrency],
    );
  }
}

String _removeHtmlTags(String htmlText) {
  final RegExp exp = RegExp(
    r'<[^>]*>',
    multiLine: true,
    caseSensitive: true,
  );

  return htmlText.replaceAll(exp, '');
}
