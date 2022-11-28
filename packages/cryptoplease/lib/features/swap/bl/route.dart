import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/amount.dart';

part 'route.freezed.dart';

enum Slippage { zpOne, zpFive, onePercent }

@freezed
class SwapRoute with _$SwapRoute {
  const factory SwapRoute({
    required Decimal amount,
    required Decimal inAmount,
    required Decimal outAmount,
    required CryptoAmount fee,
    required String encodedTx,
  }) = _SwapRoute;
}
