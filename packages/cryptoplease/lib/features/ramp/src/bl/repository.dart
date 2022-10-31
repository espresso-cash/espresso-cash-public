import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/tokens/token.dart';

@injectable
class OnRampRepository {
  OnRampRepository(this._client);

  final CryptopleaseClient _client;

  Future<String> signFundsRequest({
    required String address,
    required Token token,
  }) async {
    final requestDto = AddFundsRequestDto(
      receiverAddress: address,
      tokenSymbol: token.moonpaySymbol,
    );

    final response = await _client.addFunds(requestDto);

    return response.signedUrl;
  }
}

extension on Token {
  String get moonpaySymbol {
    if (address == Token.usdc.address) {
      return 'usdc_sol';
    } else {
      return symbol;
    }
  }
}
