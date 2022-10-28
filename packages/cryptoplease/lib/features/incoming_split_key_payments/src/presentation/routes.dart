import 'package:auto_route/auto_route.dart';

import 'first_part_ready_screen.dart';
import 'incoming_split_key_payment_screen.dart';

const iskpRoutes = [
  AutoRoute<void>(page: FirstPartReadyScreen),
  AutoRoute<void>(page: IncomingSplitKeyPaymentScreen),
];
