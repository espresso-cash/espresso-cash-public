import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsManager {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  /// User pressed on the first shareable link.
  void logShareableLinkPressed() =>
      _analytics.logEvent(name: 'shareableLinkPressed');
}
