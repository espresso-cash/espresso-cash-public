import '../../core/tokens/token.dart';

extension TokenExt on Token {
  bool get canBeSwapped => address != coingeckoId;
}
