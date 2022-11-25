import 'package:cryptoplease_api/cryptoplease_api.dart';

extension SwapSlippageExt on SwapSlippage {
  int toJupiterBps() {
    double slippage;
    switch (this) {
      case SwapSlippage.zpOne:
        slippage = 0.1;
        break;
      case SwapSlippage.zpFive:
        slippage = 0.5;
        break;
      case SwapSlippage.onePercent:
        slippage = 1.0;
        break;
    }

    return slippage.ceil().toDouble().toInt() * 100;
  }
}

extension SwapMatchExt on SwapMatch {
  SwapMode toJupiterMode() {
    switch (this) {
      case SwapMatch.inAmount:
        return SwapMode.exactIn;
      case SwapMatch.outAmount:
        return SwapMode.exactOut;
    }
  }
}
