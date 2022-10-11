import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/features/add_funds/presentation/add_funds_screen.dart';
import 'package:cryptoplease/features/add_funds/presentation/cash_out_screen.dart';

const addFundsRoutes = [
  AutoRoute<void>(page: AddFundsScreen),
  AutoRoute<void>(page: CashOutScreen),
];
