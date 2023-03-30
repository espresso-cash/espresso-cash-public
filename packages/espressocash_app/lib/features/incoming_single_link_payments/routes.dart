import 'package:auto_route/auto_route.dart';

import 'src/widgets/first_part_qr.dart';
import 'src/widgets/incoming_single_link_payment_screen.dart';

const islpRoutes = [
  AutoRoute<void>(page: FirstPartQrScreen),
  AutoRoute<void>(page: IncomingSingleLinkScreen),
];
