import 'package:freezed_annotation/freezed_annotation.dart';

import '../../currency/models/amount.dart';

part 'swap_seed.freezed.dart';

enum Slippage { zpOne, zpFive, onePercent }

@freezed
class SwapSeed with _$SwapSeed {
  const factory SwapSeed({
    required CryptoAmount input,
    required CryptoAmount output,
    int? platformFeeBps,
    String? priceImpact,
    String? providerLabel,
    required Slippage slippage,
  }) = _SwapSeed;
}
