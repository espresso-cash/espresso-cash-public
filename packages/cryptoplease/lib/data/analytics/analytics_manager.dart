import 'package:cryptoplease/bl/analytics/analytics_manager.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class FirebaseAnalyticsManager implements AnalyticsManager {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  @override
  void logShareableLinkPressed() =>
      _analytics.logEvent(name: 'shareableLinkPressed');
}
