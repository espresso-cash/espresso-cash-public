import 'package:injectable/injectable.dart';

import '../../currency/models/amount.dart';
import '../../currency/models/currency.dart';
import '../../tokens/token.dart';
import '../data/repository.dart';

@injectable
class ConvertToUsd {
  const ConvertToUsd(this._repository);

  final ConversionRatesRepository _repository;

  Amount? call(Amount amount) => switch (amount) {
        CryptoAmount(:final token, :final value) => _convert(
            token: token,
            amount: value,
          ),
        FiatAmount() => amount,
      };

  Amount? _convert({
    required Token token,
    required int amount,
  }) {
    const fiatCurrency = Currency.usd;
    final conversionRate =
        _repository.readRate(CryptoCurrency(token: token), to: fiatCurrency);

    if (conversionRate == null) return null;

    final tokenAmount = Amount.fromToken(value: amount, token: token);

    return tokenAmount.convert(rate: conversionRate, to: fiatCurrency);
  }
}
