import 'package:auto_route/auto_route.dart';

import '../../../../features/token_details/presentation/token_details_screen.dart';
import 'investments_screen.dart';

const investmentRoutes = [
  CustomRoute<void>(
    initial: true,
    page: InvestmentsScreen,
    maintainState: false,
  ),
  AutoRoute<void>(page: TokenDetailsScreen, maintainState: false),
];
