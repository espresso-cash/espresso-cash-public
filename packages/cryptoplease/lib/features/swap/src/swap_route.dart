import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/amount.dart';

part 'swap_route.freezed.dart';

enum Slippage { zpOne, zpFive, onePercent }

@freezed
class SwapRoute with _$SwapRoute {
  const factory SwapRoute({
    required int inAmount,
    required int outAmount,
    required CryptoAmount fee,
    required String encodedTx,
  }) = _SwapRoute;
}
