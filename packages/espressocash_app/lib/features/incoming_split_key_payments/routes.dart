import 'package:auto_route/auto_route.dart';

import 'src/widgets/first_part_qr_screen.dart';
import 'src/widgets/first_part_ready_screen.dart';
import 'src/widgets/incoming_split_key_payment_screen.dart';

const iskpRoutes = [
  AutoRoute<void>(page: FirstPartReadyScreen),
  AutoRoute<void>(page: FirstPartQrScreen),
  AutoRoute<void>(page: IncomingSplitKeyPaymentScreen),
];
