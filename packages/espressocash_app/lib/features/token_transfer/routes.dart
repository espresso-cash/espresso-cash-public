import 'package:auto_route/auto_route.dart';

import 'src/widgets/confirm_token_screen.dart';
import 'src/widgets/recieve_token_screen.dart';
import 'src/widgets/send_token_screen.dart';

const tokenTransferRoutes = [
  AutoRoute<void>(page: TokenReceiveScreen),
  AutoRoute<void>(page: TokenSendScreen),
  AutoRoute<void>(page: TokenConfirmScreen),
];
