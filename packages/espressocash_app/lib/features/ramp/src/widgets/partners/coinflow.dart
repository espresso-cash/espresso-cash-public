import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../models/profile_data.dart';
import '../../screens/coinflow/coinflow_withdraw_screen.dart';

extension BuildContextExt on BuildContext {
  void launchCoinflowOffRamp({
    required ProfileData profile,
    required String address,
  }) =>
      router.push(
        CoinflowOffRampScreen.route(
          profile: profile,
          address: address,
        ),
      );
}
