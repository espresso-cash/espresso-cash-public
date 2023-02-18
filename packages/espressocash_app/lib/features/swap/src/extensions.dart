import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../core/accounts/bl/account.dart';
import '../../../di.dart';
import '../../../ui/loader.dart';
import '../models/swap.dart';
import 'swap/swap_service.dart';
import 'swap_route.dart';

extension SwapExt on BuildContext {
  Future<String> createSwap(SwapRoute route) async =>
      runWithLoader(this, () async {
        final swap = await sl<SwapService>().create(
          route: route,
          account: read<MyAccount>().wallet,
        );

        return swap.id;
      });

  Future<void> retrySwap(Swap swap) async => runWithLoader(
        this,
        () => sl<SwapService>().retry(
          swap,
          account: read<MyAccount>().wallet,
        ),
      );
}
