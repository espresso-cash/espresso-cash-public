import 'package:cryptoplease/core/currency.dart';

class UserPreferences {
  UserPreferences({this.fiatCurrency = Currency.usd});

  FiatCurrency fiatCurrency = Currency.usd;
}
