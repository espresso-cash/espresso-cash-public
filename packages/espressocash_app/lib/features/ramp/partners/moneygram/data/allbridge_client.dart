import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

import 'allbridge_dto.dart';
part 'allbridge_client.g.dart';

@RestApi(baseUrl: 'https://allbridge.espressocash.com')
@injectable
abstract class AllbridgeApiClient {
  @factoryMethod
  factory AllbridgeApiClient() => _AllbridgeApiClient(Dio());

  @GET('/transfer/status')
  Future<BridgeStatusResponseDto> fetchBridgeStatus(
    @Queries() BridgeStatusRequestDto requestDto,
  );

  @GET('/raw/stellar/restore')
  Future<String> restoreStellarTx(
    @Queries() RestoreStellarTxRequestDto requestDto,
  );
}
