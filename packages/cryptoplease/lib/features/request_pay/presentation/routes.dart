import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/features/request_pay/presentation/screens/request_pay_screen.dart';
import 'package:cryptoplease/features/request_pay/presentation/screens/request_token_select_screen.dart';

const requestPayRoutes = [
  AutoRoute<void>(path: '', page: RequestPayScreen),
  AutoRoute<Token>(page: RequestTokenSelectScreen, fullscreenDialog: true),
];
