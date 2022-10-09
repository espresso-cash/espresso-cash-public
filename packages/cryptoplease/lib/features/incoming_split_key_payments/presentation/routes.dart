import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/features/incoming_split_key_payments/presentation/first_part_ready_screen.dart';
import 'package:cryptoplease/features/incoming_split_key_payments/presentation/incoming_split_key_payment_screen.dart';

const iskpRoutes = [
  AutoRoute<void>(page: FirstPartReadyScreen),
  AutoRoute<void>(page: IncomingSplitKeyPaymentScreen),
];
