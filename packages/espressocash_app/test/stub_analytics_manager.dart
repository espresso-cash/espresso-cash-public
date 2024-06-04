import 'package:decimal/decimal.dart';
import 'package:espressocash_app/features/analytics/analytics_manager.dart';

class StubAnalyticsManager implements AnalyticsManager {
  const StubAnalyticsManager();

  @override
  void directPaymentSent({required Decimal amount}) {}

  @override
  void setProfileCountryCode(String countryCode) {}

  @override
  void setUsdcBalance(Decimal value) {}

  @override
  void setWalletAddress(String? address) {}

  @override
  void singleLinkCanceled({required Decimal amount}) {}

  @override
  void singleLinkCreated({required Decimal amount}) {}

  @override
  void singleLinkReceived() {}

  @override
  void swapTransactionCreated({
    required String from,
    required String to,
    required int amount,
  }) {}

  @override
  void setTotalInvestmentsBalance(Decimal value) {}
}
