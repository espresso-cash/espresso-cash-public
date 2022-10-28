import 'package:auto_route/auto_route.dart';

import 'oskp_confirmation_screen.dart';
import 'oskp_screen.dart';
import 'share_links_screen.dart';

const oskpRoutes = [
  AutoRoute<void>(page: OSKPScreen),
  AutoRoute<void>(page: OSKPConfirmationScreen),
  AutoRoute<void>(page: ShareLinksScreen),
];
