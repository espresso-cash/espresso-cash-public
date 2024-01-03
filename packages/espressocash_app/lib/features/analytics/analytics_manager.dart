import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:injectable/injectable.dart';

import '../accounts/models/ec_wallet.dart';
import '../authenticated/auth_scope.dart';
import '../ramp/models/ramp_partner.dart';

@LazySingleton(scope: authScope)
class AnalyticsManager {
  AnalyticsManager(this._wallet);

  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  final ECWallet _wallet;

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
          'userAddress': _wallet.address,
        },
      );

  // User creates shareable link.
  void linkCreated(int amount) => _analytics.logEvent(
        name: 'linkCreated',
        parameters: {
          'amount': amount,
          'userAddress': _wallet.address,
        },
      );

// User receives shareable link
  void linkReceived() => _analytics.logEvent(
        name: 'linkReceived',
        parameters: {
          'userAddress': _wallet.address,
        },
      );

  // User cancelled the link creation
  void linkCancelled() => _analytics.logEvent(name: 'linkCancelled');

  // User creates a direct payment
  void directPaymentCreated(int amount) => _analytics.logEvent(
        name: 'directPaymentCreated',
        parameters: {
          'amount': amount,
          'userAddress': _wallet.address,
        },
      );

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
          'userAddress': _wallet.address,
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
          'userAddress': _wallet.address,
        },
      );

  // User completes onboarding
  void onboardingCompleted() => _analytics.setUserProperty(
        name: 'completedOnboarding',
        value: 'true',
      );
}
