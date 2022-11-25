import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:cryptoplease_link/src/constants.dart';

Future<int> extractFee(JupiterRoute route) async {
  final totalFeeInSol = route.fees?.totalFeeAndDeposits;

  if (totalFeeInSol == null) {
    throw Exception('Route has no fee object');
  }

  return convertSolToUsdc(totalFeeInSol);
}

Future<int> convertSolToUsdc(num amountInSol) => _client
    .getPrice(const PriceRequestDto(id: 'SOL'))
    .then((response) => response.data.price)
    .then(
      (price) => (amountInSol * price / solDecimals * usdcDecimals).round(),
    );

final _client = JupiterPriceClient();
