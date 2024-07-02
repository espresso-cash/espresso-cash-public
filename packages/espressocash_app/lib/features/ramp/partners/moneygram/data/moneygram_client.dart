import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../stellar/constants.dart';
import '../../../models/ramp_type.dart';
import 'dto.dart';
import 'moneygram_interceptor.dart';

part 'moneygram_client.g.dart';

@RestApi(baseUrl: moneygramBaseUrl)
@injectable
abstract class MoneygramApiClient {
  @factoryMethod
  factory MoneygramApiClient(MoneygramInterceptor interceptor) =>
      _MoneygramApiClient(Dio()..interceptors.add(interceptor));

  @POST('/sep24/transactions/withdraw/interactive')
  Future<MgWithdrawResponseDto> generateWithdrawUrl(
    @Body() MgWithdrawRequestDto body,
    @Header('Authorization') String authHeader,
  );

  @POST('/sep24/transactions/deposit/interactive')
  Future<MgWithdrawResponseDto> generateDepositUrl(
    @Body() MgWithdrawRequestDto body,
    @Header('Authorization') String authHeader,
  );

  @GET('/sep24/transaction')
  Future<MgFetchTransactionResponseDto> fetchTransaction({
    @Query('id') required String id,
    @Header('Authorization') required String authHeader,
    @Header('type') RampType? rampType,
  });
}
