import 'package:dfunc/dfunc.dart';

import 'client.dart';

class UniversalPayRepository {
  const UniversalPayRepository(this._client);

  final UniversalPayApiClient _client;

  Future<String> getEvmAddress({
    required String receiver,
    required String reference,
  }) =>
      _client.generateEvmAddress(receiver, reference).letAsync((r) => r.result);

  Future<double> getBlockchainFee({
    required String chainId,
    required String amount,
  }) =>
      _client.getFees(chainId, amount).letAsync((r) => r.totalFees);
}
