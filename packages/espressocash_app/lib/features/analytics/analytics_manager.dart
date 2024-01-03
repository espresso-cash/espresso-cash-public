import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AnalyticsManager {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  FirebaseAnalyticsObserver get analyticsObserver =>
      FirebaseAnalyticsObserver(analytics: _analytics);

  void swapTransactionCreated({
    required String from,
    required String to,
    required int amount,
  }) =>
      _analytics.logEvent(
        name: 'swapTransactionCreated',
        parameters: {
          'from': from,
          'to': to,
          'amount': amount,
        },
      );

  // User creates shareable link.
  void linkCreated() => _analytics.logEvent(name: 'linkCreated');

  // User receives shareable link
  void linkReceived() => _analytics.logEvent(name: 'linkReceived');

  // User cancelled the link creation
  void linkCancelled() => _analytics.logEvent(name: 'linkCancelled');

  // User creates a direct payment
  void directPaymentCreated() =>
      _analytics.logEvent(name: 'directPaymentCreated');

  // User creates an onramp payment
  void onRampPaymentCreated() =>
      _analytics.logEvent(name: 'onRampPaymentCreated');

  // User creates an offramp payment
  void offRampPaymentCreated() =>
      _analytics.logEvent(name: 'offRampPaymentCreated');

  // User completes onboarding
  void onboardingCompleted() => _analytics.setUserProperty(
        name: 'completedOnboarding',
        value: 'true',
      );
}
