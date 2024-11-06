import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'fiat_rates_client.g.dart';

@injectable
@RestApi(baseUrl: 'https://hexarate.paikama.co/')
abstract class FiatRatesClient {
  @factoryMethod
  factory FiatRatesClient(Dio dio) = _FiatRatesClient;

  @GET('/api/rates/latest/USD')
  Future<FiatRatesResponse> getRates({
    @Query('target') required String target,
  });
}

class FiatRatesResponse {
  const FiatRatesResponse({
    required this.base,
    required this.target,
    required this.mid,
    required this.unit,
    required this.timestamp,
  });

  factory FiatRatesResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;

    return FiatRatesResponse(
      base: data['base'] as String,
      target: data['target'] as String,
      mid: data['mid'] as double,
      unit: data['unit'] as int,
      timestamp: DateTime.parse(data['timestamp'] as String),
    );
  }

  final String base;
  final String target;
  final double mid;
  final int unit;
  final DateTime timestamp;
}
