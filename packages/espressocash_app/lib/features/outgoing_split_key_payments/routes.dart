import 'package:auto_route/auto_route.dart';

import 'src/widgets/oskp_confirmation_screen.dart';
import 'src/widgets/oskp_screen.dart';
import 'src/widgets/share_links_screen.dart';

const oskpRoutes = [
  AutoRoute<void>(page: OSKPScreen),
  AutoRoute<void>(page: OSKPConfirmationScreen),
  AutoRoute<void>(page: ShareLinksScreen),
];
