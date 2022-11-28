// ignore_for_file: invalid_annotation_target

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/tokens/token.dart';

part 'coingecko_client.freezed.dart';
part 'coingecko_client.g.dart';

@injectable
@RestApi(baseUrl: 'https://api.coingecko.com/api/v3')
abstract class SearchCoingeckoClient {
  @factoryMethod
  factory SearchCoingeckoClient(Dio dio) = _SearchCoingeckoClient;

  @GET('/search')
  Future<SearchResponseDto> search(@Query('query') String query);

  @GET('/coins/markets')
  Future<SearchResponseDto> searchByCategory(
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
    required String thumb,
  }) = _SearchResponseDataDto;

  factory SearchResponseDataDto.fromJson(Map<String, dynamic> data) =>
      _$SearchResponseDataDtoFromJson(data);
}

@freezed
abstract class CategorySearchRequestDto with _$CategorySearchRequestDto {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory CategorySearchRequestDto({
    @Default('usd') String currency,
    @Default(25) int perPage,
    required String category,
  }) = _CategorySearchRequestDto;

  factory CategorySearchRequestDto.fromJson(Map<String, dynamic> json) =>
      _$CategorySearchRequestDtoFromJson(json);
}

extension SearchResponseDataDtoExt on SearchResponseDataDto {
  Token toModel() => Token(
        symbol: symbol,
        name: name,
        extensions: Extensions(coingeckoId: id),
        chainId: 0,
        address: '0',
        decimals: 0,
        logoURI: thumb,
        tags: const [],
      );
}
