import 'package:dio/dio.dart';
import 'package:espressocash_backend/src/scalex/client/constants.dart';
import 'package:espressocash_backend/src/scalex/client/interceptor.dart';
import 'package:espressocash_backend/src/scalex/client/model.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'client.g.dart';

@RestApi(baseUrl: scalexBaseUrl)
abstract class ScalexApiClient {
  factory ScalexApiClient() =>
      _ScalexApiClient(Dio()..interceptors.add(const ScalexInterceptor()));

  @POST('/webpay/tx/initiate')
  Future<ScalexResponseDto<GenerateIFrameDto>> generateIFrameUrl(
    @Body() GenerateIFrameBodyDto body,
  );

  @GET('/business/tx/{reference_id}')
  Future<ScalexResponseDto<TransactionDto>> getTransaction(
    @Path('reference_id') String referenceId,
  );
}
