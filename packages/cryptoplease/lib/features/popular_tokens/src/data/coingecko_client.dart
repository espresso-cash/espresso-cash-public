// ignore_for_file: invalid_annotation_target

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../config.dart';
import '../../../../core/tokens/token.dart';
import '../market_token.dart';

part 'coingecko_client.freezed.dart';
part 'coingecko_client.g.dart';

@injectable
@RestApi(baseUrl: 'https://api.coingecko.com/api/v3')
abstract class MarketsCoingeckoClient {
  @factoryMethod
  factory MarketsCoingeckoClient(Dio dio) = _MarketsCoingeckoClient;

  @GET('/coins/markets')
  Future<List<MarketsResponseDto>> getMarketTokens(
    @Queries() MarketsRequestDto request,
  );
}

@freezed
class MarketsRequestDto with _$MarketsRequestDto {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory MarketsRequestDto({
    required String vsCurrency,
    required String order,
    required int perPage,
    @Default(1) int page,
  }) = _TokenDetailsRequestDto;

  factory MarketsRequestDto.fromJson(Map<String, dynamic> json) =>
      _$MarketsRequestDtoFromJson(json);
}

@freezed
class MarketsResponseDto with _$MarketsResponseDto {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory MarketsResponseDto({
    String? id,
    String? symbol,
    String? name,
    String? image,
    double? currentPrice,
    int? marketCapRank,
  }) = _MarketsResponseDto;

  const MarketsResponseDto._();

  factory MarketsResponseDto.fromJson(Map<String, dynamic> json) =>
      _$MarketsResponseDtoFromJson(json);
}

extension MarketsResponseDtoExt on MarketsResponseDto {
  CoingeckoToken fromCoingecko() => CoingeckoToken(
        chainId: currentChainId,
        address: id ?? '',
        symbol: symbol?.toUpperCase() ?? '',
        name: name ?? '',
        decimals: 0,
        logoURI: image,
        tags: const [],
        extensions: Extensions(coingeckoId: id),
        currentPrice: currentPrice ?? 0,
        marketCapRank: marketCapRank ?? 0,
      );
}
