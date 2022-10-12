import 'package:cryptoplease_api/cryptoplease_api.dart';

class SwapRepository {
  SwapRepository(this._client, this._jupiterClient);

  final CryptopleaseClient _client;
  final JupiterAggregatorClient _jupiterClient;
}
