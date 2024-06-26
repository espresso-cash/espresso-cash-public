import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../data/db/db.dart';
import '../../../../stellar/constants.dart';
import '../../../../stellar/models/stellar_wallet.dart';
import '../../../../stellar/service/stellar_client.dart';
import '../../../models/ramp_type.dart';
import 'dto.dart';
import 'moneygram_interceptor.dart';

part 'moneygram_client.g.dart';

@RestApi(baseUrl: moneygramBaseUrl)
@injectable
abstract class MoneygramApiClient {
  @factoryMethod
  factory MoneygramApiClient(
    MyDatabase db,
    StellarClient stellarClient,
    StellarWallet stellarWallet,
  ) =>
      _MoneygramApiClient(
        Dio()
          ..interceptors
              .add(MoneygramInterceptor(db, stellarClient, stellarWallet)),
      );

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

extension StringExt on String {
  String toAuthHeader() => 'Bearer $this';
}
