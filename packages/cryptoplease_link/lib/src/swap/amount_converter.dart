import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:cryptoplease_link/src/constants.dart';

Future<int> convertSolToUsdc(num amountInSol) async {
  final response = await _client.getPrice(const PriceRequestDto(id: 'SOL'));

  return (amountInSol * response.price / solDecimals * usdcDecimals).round();
}

final _client = JupiterPriceClient();
