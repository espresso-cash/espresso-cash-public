import 'package:injectable/injectable.dart';

import '../../../core/amount.dart';
import '../../../core/currency.dart';
import '../../../core/tokens/token.dart';
import '../data/repository.dart';

@injectable
class ConvertToFiat {
  const ConvertToFiat(this._repository);

  final ConversionRatesRepository _repository;

  Amount? call(Amount amount) => switch (amount) {
        CryptoAmount(:final token, :final value) => _convert(
            fiatCurrency: Currency.usd,
            token: token,
            amount: value,
          ),
        FiatAmount() => amount,
      };

  Amount? _convert({
    required FiatCurrency fiatCurrency,
    required Token token,
    required int amount,
  }) {
    final conversionRate = _repository.readRate(
      CryptoCurrency(token: token),
      to: fiatCurrency,
    );
    if (conversionRate == null) return null;

    final tokenAmount = Amount.fromToken(value: amount, token: token);

    return tokenAmount.convert(rate: conversionRate, to: fiatCurrency);
  }
}
