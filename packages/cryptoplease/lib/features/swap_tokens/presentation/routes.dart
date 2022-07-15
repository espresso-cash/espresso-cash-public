import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/features/swap_tokens/presentation/screens/swap_token_order_screen.dart';
import 'package:cryptoplease/features/swap_tokens/presentation/screens/swap_token_process_screen.dart';
import 'package:cryptoplease/features/swap_tokens/presentation/screens/swap_token_selector_screen.dart';

const swapTokenRoutes = [
  AutoRoute<void>(path: '', page: SwapTokenOrderScreen),
  AutoRoute<void>(page: SwapTokenProcessScreen),
  AutoRoute<Token>(page: SwapTokenSelectorScreen),
];
