import 'dart:async';

import 'package:dfunc/dfunc.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:injectable/injectable.dart';

import '../accounts/data/account_repository.dart';
import '../ramp/models/ramp_partner.dart';

@lazySingleton
class AnalyticsManager {
  AnalyticsManager(this._repository);

  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  final AccountRepository _repository;

  FirebaseAnalyticsObserver get analyticsObserver =>
      FirebaseAnalyticsObserver(analytics: _analytics);

  FutureOr<String?> get _walletAddress =>
      _repository.loadAccount().letAsync((e) => e?.address);

  Future<void> swapTransactionCreated({
    required String from,
    required String to,
    required int amount,
  }) async =>
      _analytics.logEvent(
        name: 'swapTransactionCreated',
        parameters: {
          'from': from,
          'to': to,
          'amount': amount,
          'userAddress': await _walletAddress,
        },
      );

  // User creates shareable link.
  Future<void> linkCreated(int amount) async => _analytics.logEvent(
        name: 'linkCreated',
        parameters: {
          'amount': amount,
          'userAddress': await _walletAddress,
        },
      );

// User receives shareable link
  Future<void> linkReceived() async => _analytics.logEvent(
        name: 'linkReceived',
        parameters: {
          'userAddress': await _walletAddress,
        },
      );

  // User cancelled the link creation
  void linkCancelled() => _analytics.logEvent(name: 'linkCancelled');

  // User creates a direct payment
  Future<void> directPaymentCreated(int amount) async => _analytics.logEvent(
        name: 'directPaymentCreated',
        parameters: {
          'amount': amount,
          'userAddress': await _walletAddress,
        },
      );

// User creates an onramp payment
  Future<void> onRampPaymentCreated({
    required int amount,
    required RampPartner partner,
  }) async =>
      _analytics.logEvent(
        name: 'onRampPaymentCreated',
        parameters: {
          'amount': amount,
          'partner': partner.toString(),
          'userAddress': await _walletAddress,
        },
      );

// User creates an offramp payment
  Future<void> offRampPaymentCreated({
    required int amount,
    required RampPartner partner,
  }) async =>
      _analytics.logEvent(
        name: 'offRampPaymentCreated',
        parameters: {
          'amount': amount,
          'partner': partner.toString(),
          'userAddress': await _walletAddress,
        },
      );

  // User completes onboarding
  void onboardingCompleted() => _analytics.setUserProperty(
        name: 'completedOnboarding',
        value: 'true',
      );
}
