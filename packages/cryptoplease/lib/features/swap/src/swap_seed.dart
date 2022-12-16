import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/amount.dart';
import '../../../core/tokens/token.dart';

part 'swap_seed.freezed.dart';

enum Slippage { zpOne, zpFive, onePercent }

@freezed
class SwapSeed with _$SwapSeed {
  const factory SwapSeed({
    required CryptoAmount amount,
    required Token inputToken,
    required Token outputToken,
    required Slippage slippage,
  }) = _SwapSeed;
}
