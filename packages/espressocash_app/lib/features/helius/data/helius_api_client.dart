import 'package:injectable/injectable.dart';

import '../../../di.dart';
import '../../rpc/rpc_client.dart';
import 'dto.dart';

@injectable
class HeliusApiClient {
  HeliusApiClient({
    @rpcUrl required Uri clientRpcUrl,
  }) : _rpcClient = JsonRpcClient(baseUrl: clientRpcUrl);

  final JsonRpcClient _rpcClient;

  Future<GetPriorityFeeEstimateResponse?> getPriorityFeeEstimate(
    GetPriorityFeeEstimateRequest request,
  ) async {
    final response = await _rpcClient.sendRequest(
      JsonRpcRequest(
        id: 1,
        method: 'getPriorityFeeEstimate',
        params: [request.toJson()],
      ),
    );

    return response.data.result == null
        ? null
        : GetPriorityFeeEstimateResponse.fromJson(
            response.data.result as Map<String, dynamic>,
          );
  }
}
