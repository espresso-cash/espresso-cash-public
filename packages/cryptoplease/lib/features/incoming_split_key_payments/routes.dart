import 'package:auto_route/auto_route.dart';

import 'src/presentation/first_part_ready_screen.dart';
import 'src/presentation/incoming_split_key_payment_screen.dart';

const iskpRoutes = [
  AutoRoute<void>(page: FirstPartReadyScreen),
  AutoRoute<void>(page: IncomingSplitKeyPaymentScreen),
];
