import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:cryptoplease_link/src/constants.dart';

Future<double> getUsdcPrice() async => _priceClient
    .getPrice(const PriceRequestDto(id: 'SOL'))
    .then((response) => response.data.price);

int convert(num amountInSol, double price) =>
    (amountInSol * price / solDecimals * usdcDecimals).round();

final _priceClient = JupiterPriceClient();
