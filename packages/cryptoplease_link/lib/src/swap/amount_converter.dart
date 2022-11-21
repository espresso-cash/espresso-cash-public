import 'package:cryptoplease_api/cryptoplease_api.dart';

Future<int> convertToUsdc(int amountInSol) async {
  final response = await _client.getPrice(const PriceRequestDto(id: 'SOL'));

  return (amountInSol * response.price).round();
}

final _client = JupiterPriceClient();
