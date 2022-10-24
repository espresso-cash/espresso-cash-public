import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/app/screens/authenticated/investments/investments_screen.dart';
import 'package:cryptoplease/features/token_details/presentation/token_details_screen.dart';

const investmentRoutes = [
  CustomRoute<void>(
    initial: true,
    page: InvestmentsScreen,
    maintainState: false,
  ),
  AutoRoute<void>(page: TokenDetailsScreen, maintainState: false),
];
