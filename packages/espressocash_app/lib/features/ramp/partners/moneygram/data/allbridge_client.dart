import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

import 'allbridge_dto.dart';
part 'allbridge_client.g.dart';

@RestApi(baseUrl: 'http://localhost:3000')
@injectable
abstract class AllbridgeApiClient {
  @factoryMethod
  factory AllbridgeApiClient() => _AllbridgeApiClient(Dio());

  @GET('/transfer/status')
  Future<BridgeStatusResponseDto> fetchBridgeStatus(
    @Queries() BridgeStatusRequestDto requestDto,
  );
}
