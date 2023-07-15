import 'package:injectable/injectable.dart';

import 'currency.dart';

@singleton
class UserPreferences {
  UserPreferences();

  FiatCurrency fiatCurrency = Currency.usd;
}
