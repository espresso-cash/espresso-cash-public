import 'package:decimal/decimal.dart';
import 'package:injectable/injectable.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';

@lazySingleton
class AnalyticsManager {
  const AnalyticsManager(this._analytics);

  final Mixpanel _analytics;

  void swapTransactionCreated({
    required String from,
    required String to,
    required int amount,
  }) =>
      _analytics.track(
        'swapTransactionCreated',
        properties: {
          'from': from,
          'to': to,
          'amount': amount,
        },
      );

  void setWalletAddress(String? address) {
    if (address == null) {
      _analytics.reset();
    } else {
      _analytics.identify(address);
      _analytics.getPeople().set('walletAddress', address);
    }
  }

  void setUsdcBalance(Decimal value) {
    _analytics.getPeople().set('usdcBalance', value.toDouble());
  }

  void setTotalInvestmentsBalance(Decimal value) {
    _analytics.getPeople().set('investmentsBalance', value.toDouble());
  }

  void setProfileCountryCode(String countryCode) {
    _analytics.getPeople().set('profileCountryCode', countryCode);
  }

  void singleLinkCreated({
    required Decimal amount,
  }) =>
      _analytics.track(
        'singleLinkCreated',
        properties: {'amount': amount.toDouble()},
      );

  void singleLinkCanceled({
    required Decimal amount,
  }) =>
      _analytics.track(
        'singleLinkCanceled',
        properties: {'amount': amount.toDouble()},
      );

  void singleLinkReceived() => _analytics.track('singleLinkReceived');

  void directPaymentSent({
    required Decimal amount,
  }) =>
      _analytics.track(
        'directPaymentSent',
        properties: {'amount': amount.toDouble()},
      );
}
