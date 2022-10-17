import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddFundsRepository {
  AddFundsRepository(this._client);

  final CryptopleaseClient _client;

  Future<String> signFundsRequest({
    required String address,
    required Token token,
  }) async {
    final requestDto = AddFundsRequestDto(
      receiverAddress: address,
      tokenSymbol: token.symbol,
    );

    final response = await _client.addFunds(requestDto);

    return response.signedUrl;
  }
}
