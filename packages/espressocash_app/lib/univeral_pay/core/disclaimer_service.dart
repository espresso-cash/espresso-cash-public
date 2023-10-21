class DisclaimerService {
  factory DisclaimerService() => _instance;

  DisclaimerService._internal();
  static final DisclaimerService _instance = DisclaimerService._internal();

  bool _hasAccepted = false;

  bool get hasAccepted => _hasAccepted;

  void acceptDisclaimer() {
    _hasAccepted = true;
  }
}
