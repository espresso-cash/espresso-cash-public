import 'package:dfunc/dfunc.dart';
import 'package:injectable/injectable.dart';

import 'client.dart';

@Injectable(scope: 'landing')
class UniversalPayRepository {
  const UniversalPayRepository(this._client);

  final UniversalPayApiClient _client;

  Future<String> getEvmAddress({
    required String receiver,
    required String reference,
  }) =>
      _client
          .generateEvmAddress(receiver: receiver, reference: reference)
          .letAsync((r) => r.result);

  Future<int> getTotalAmount({
    required String chainId,
    required String amount,
    required String address,
  }) =>
      _client
          .getFees(chainId: chainId, amount: amount, address: address)
          .letAsync((r) => r.makerAmountRounded);
}
