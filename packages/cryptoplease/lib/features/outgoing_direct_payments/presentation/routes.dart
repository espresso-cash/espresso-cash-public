import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/features/outgoing_direct_payments/presentation/odp_confirmation_screen.dart';
import 'package:cryptoplease/features/outgoing_direct_payments/presentation/odp_details_screen.dart';
import 'package:decimal/decimal.dart';

const odpRoutes = [
  AutoRoute<void>(page: ODPDetailsScreen),
  AutoRoute<Decimal>(page: ODPConfirmationScreen),
];
