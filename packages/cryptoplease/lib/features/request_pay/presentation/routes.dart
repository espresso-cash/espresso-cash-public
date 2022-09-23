import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/features/request_pay/presentation/screens/direct_pay_confirm_screen.dart';
import 'package:cryptoplease/features/request_pay/presentation/screens/direct_pay_screen.dart';
import 'package:cryptoplease/features/request_pay/presentation/screens/request_pay_screen.dart';

const requestPayRoutes = [
  AutoRoute<void>(path: '', page: RequestPayScreen),
];

const requestDirectRoutes = [
  AutoRoute<void>(page: DirectPayScreen),
  AutoRoute<void>(page: DirectPayConfirmScreen),
];
