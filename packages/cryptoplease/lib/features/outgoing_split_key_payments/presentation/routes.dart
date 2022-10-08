import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/features/outgoing_split_key_payments/presentation/oskp_screen.dart';
import 'package:cryptoplease/features/outgoing_split_key_payments/presentation/share_links_screen.dart';

const oskpRoutes = [
  AutoRoute<void>(page: OSKPScreen),
  AutoRoute<void>(page: ShareLinksScreen),
];
