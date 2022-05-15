import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/presentation/screens/authenticated/swap_tokens/screens/swap_token_order_screen.dart';
import 'package:cryptoplease/presentation/screens/authenticated/swap_tokens/screens/swap_token_process_screen.dart';
import 'package:cryptoplease/presentation/screens/authenticated/swap_tokens/screens/swap_token_selector_screen.dart';

const swapTokenRoutes = [
  AutoRoute<void>(path: '', page: SwapTokenOrderScreen),
  AutoRoute<void>(page: SwapTokenProcessScreen),
  AutoRoute<Token>(page: SwapTokenSelectorScreen),
];
