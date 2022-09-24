import 'package:cryptoplease/core/tokens/token.dart';
import 'package:flutter/foundation.dart';

abstract class TokenInfoRepository implements ChangeNotifier {
  Future<void> getTokenInfo(Token crypto);
  Future<void> getMarketChart(Token crypto);
}
