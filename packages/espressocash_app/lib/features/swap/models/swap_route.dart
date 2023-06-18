import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/amount.dart';
import 'swap_seed.dart';

part 'swap_route.freezed.dart';

@freezed
class SwapRoute with _$SwapRoute {
  const factory SwapRoute({
    required int inAmount,
    required int outAmount,
    required CryptoAmount fee,
    required String encodedTx,
    required SwapSeed seed,
    required BigInt slot,
  }) = _SwapRoute;
}
