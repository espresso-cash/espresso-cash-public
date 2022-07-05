import 'package:cryptoplease/bl/currency.dart';
import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:dio/dio.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:retrofit/retrofit.dart';

part 'coingecko_client.freezed.dart';
part 'coingecko_client.g.dart';

@RestApi(baseUrl: 'https://api.coingecko.com/api/v3/simple')
abstract class CoingeckoClient {
  factory CoingeckoClient() =>
      _CoingeckoClient(Dio()..options.listFormat = ListFormat.csv);

  @GET('/price')
  Future<Map<String, PricesMapDto>> getPrice(@Queries() RateRequestDto request);
}

@freezed
class PricesMapDto with _$PricesMapDto {
  const factory PricesMapDto({
    double? usd,
    double? eur,
  }) = _PricesMapDto;

  const PricesMapDto._();

  factory PricesMapDto.fromJson(Map<String, dynamic> data) =>
      _$PricesMapDtoFromJson(data);

  Decimal to(Currency currency) {
    if (currency == Currency.usd) {
      return usd?.let((s) => Decimal.parse(s.toString())) ?? Decimal.zero;
    } else {
      throw FormatException('unsupported fiat currency ${currency.name}');
    }
  }
}

@freezed
class RateRequestDto with _$RateRequestDto {
  // ignore: invalid_annotation_target, it's valid
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory RateRequestDto({
    required IList<String> ids,
    required IList<String> vsCurrencies,
  }) = _RateRequestDto;

  factory RateRequestDto.fromJson(Map<String, dynamic> json) =>
      _$RateRequestDtoFromJson(json);
}
