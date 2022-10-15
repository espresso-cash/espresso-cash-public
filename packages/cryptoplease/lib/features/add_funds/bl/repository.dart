import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddFundsRepository {
  AddFundsRepository(this._client);

  final CryptopleaseClient _client;

  Future<String> signFundsRequest(
    String address,
    Amount amount,
  ) async {
    final requestDto = AddFundsRequestDto(
      receiverAddress: address,
      tokenSymbol: amount.currency.symbol,
      value: amount.decimal.toString(),
    );

    final response = await _client.addFunds(requestDto);

    return response.signedUrl;
  }
}
