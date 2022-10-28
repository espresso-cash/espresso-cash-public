import 'package:auto_route/auto_route.dart';
import 'package:decimal/decimal.dart';

import 'odp_confirmation_screen.dart';
import 'odp_details_screen.dart';

const odpRoutes = [
  AutoRoute<void>(page: ODPDetailsScreen),
  AutoRoute<Decimal>(page: ODPConfirmationScreen),
];
