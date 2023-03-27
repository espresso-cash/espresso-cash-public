// ignore_for_file: invalid_annotation_target

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/coingecko_client.dart';
import '../../../../core/tokens/token.dart';
import '../../../../core/tokens/token_list.dart';

part 'coingecko_client.freezed.dart';
part 'coingecko_client.g.dart';

const _maxAge = Duration(hours: 1);

@injectable
@RestApi(baseUrl: 'https://api.coingecko.com/api/v3')
abstract class SearchCoingeckoClient {
  @factoryMethod
  factory SearchCoingeckoClient(CoingeckoClient client) =>
      _SearchCoingeckoClient(client.setMaxAge(_maxAge));

  @GET('/search')
  Future<SearchResponseDto> search(@Query('query') String query);

  @GET('/coins/markets')
  Future<List<CategorySearchResponseDto>> searchByCategory(
    @Queries() CategorySearchRequestDto request,
  );
}

@freezed
class SearchResponseDto with _$SearchResponseDto {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SearchResponseDto({
    @Default([]) List<SearchResponseDataDto> coins,
  }) = _TokenChartResponseDto;

  factory SearchResponseDto.fromJson(Map<String, dynamic> data) =>
      _$SearchResponseDtoFromJson(data);
}

@freezed
class SearchResponseDataDto with _$SearchResponseDataDto {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SearchResponseDataDto({
    required String id,
    required String name,
    required String symbol,
    int? marketCapRank,
    required String large,
  }) = _SearchResponseDataDto;

  factory SearchResponseDataDto.fromJson(Map<String, dynamic> data) =>
      _$SearchResponseDataDtoFromJson(data);
}

@freezed
abstract class CategorySearchRequestDto with _$CategorySearchRequestDto {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory CategorySearchRequestDto({
    @Default('usd') String vsCurrency,
    @Default(50) int perPage,
    required String category,
  }) = _CategorySearchRequestDto;

  factory CategorySearchRequestDto.fromJson(Map<String, dynamic> json) =>
      _$CategorySearchRequestDtoFromJson(json);
}

@freezed
class CategorySearchResponseDto with _$CategorySearchResponseDto {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory CategorySearchResponseDto({
    String? id,
    String? symbol,
    String? name,
    String? image,
    int? marketCapRank,
  }) = _CategorySearchResponseDto;

  const CategorySearchResponseDto._();

  factory CategorySearchResponseDto.fromJson(Map<String, dynamic> json) =>
      _$CategorySearchResponseDtoFromJson(json);
}

extension SearchResponseDataDtoExt on SearchResponseDataDto {
  Token toToken(TokenList tokenList) {
    final id = this.id;
    final symbol = this.symbol.toLowerCase();

    if (symbol == Token.sol.symbol.toLowerCase()) return Token.sol;

    return tokenList.fromCoingecko(
      coingeckoId: id,
      symbol: symbol,
      name: name,
      image: large,
    );
  }
}

extension CategorySearchDtoExt on CategorySearchResponseDto {
  Token toToken(TokenList tokenList) {
    final id = this.id;
    final symbol = this.symbol?.toLowerCase();

    if (symbol == Token.sol.symbol.toLowerCase()) return Token.sol;

    return tokenList.fromCoingecko(
      coingeckoId: id,
      symbol: symbol,
      name: name,
      image: image,
    );
  }
}
