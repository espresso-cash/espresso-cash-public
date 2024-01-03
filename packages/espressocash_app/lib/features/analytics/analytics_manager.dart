import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:injectable/injectable.dart';

import '../ramp/models/ramp_partner.dart';

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
  void linkCreated(int amount) => _analytics.logEvent(
        name: 'linkCreated',
        parameters: {
          'amount': amount,
        },
      );

// User receives shareable link
  void linkReceived() => _analytics.logEvent(name: 'linkReceived');

  // User cancelled the link creation
  void linkCancelled() => _analytics.logEvent(name: 'linkCancelled');

  // User creates a direct payment
  void directPaymentCreated() =>
      _analytics.logEvent(name: 'directPaymentCreated');

// User creates an onramp payment
  void onRampPaymentCreated({
    required int amount,
    required RampPartner partner,
  }) =>
      _analytics.logEvent(
        name: 'onRampPaymentCreated',
        parameters: {
          'amount': amount,
          'partner': partner.toString(),
        },
      );

// User creates an offramp payment
  void offRampPaymentCreated({
    required int amount,
    required RampPartner partner,
  }) =>
      _analytics.logEvent(
        name: 'offRampPaymentCreated',
        parameters: {
          'amount': amount,
          'partner': partner.toString(),
        },
      );

  // User completes onboarding
  void onboardingCompleted() => _analytics.setUserProperty(
        name: 'completedOnboarding',
        value: 'true',
      );
}
