import 'package:injectable/injectable.dart';

import 'currency.dart';

@singleton
class UserPreferences {
  UserPreferences({this.fiatCurrency = Currency.usd});

  FiatCurrency fiatCurrency = Currency.usd;
}
