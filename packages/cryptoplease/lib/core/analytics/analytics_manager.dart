import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AnalyticsManager {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  /// User pressed on the first shareable link.
  void shareableLinkPressed() =>
      _analytics.logEvent(name: 'shareableLinkPressed');

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
}
