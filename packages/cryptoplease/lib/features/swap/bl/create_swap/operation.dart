import 'package:cryptoplease/features/swap/bl/create_swap/bloc.dart';

enum SwapOperation { buy, sell }

extension SwapOperationExt on SwapOperation {
  SwapEditingMode toInitialEditingMode() {
    switch (this) {
      case SwapOperation.buy:
        return const SwapEditingMode.output();
      case SwapOperation.sell:
        return const SwapEditingMode.input();
    }
  }
}
