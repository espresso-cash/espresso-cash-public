import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:scalex_api/scalex.dart';
import 'package:scalex_api/src/constants.dart';
import 'package:scalex_api/src/interceptor.dart';

part 'client.g.dart';

@RestApi(baseUrl: scalexBaseUrl)
abstract class ScalexApiClient {
  factory ScalexApiClient() =>
      _ScalexApiClient(Dio()..interceptors.add(ScalexInterceptor()));

  @POST('/webpay/tx/initiate')
  Future<ScalexResponseDto<GenerateIFrameDto>> generateIFrameUrl(
    @Body() GenerateIFrameBodyDto body,
  );

  @GET('/business/tx/{reference_id}')
  Future<ScalexResponseDto<TransactionDto>> getTransaction(
    @Path('reference_id') String referenceId,
  );
}
