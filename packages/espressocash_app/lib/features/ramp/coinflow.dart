import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'screens/coinflow/coinflow_withdraw_screen.dart';

extension BuildContextExt on BuildContext {
  void launchCoinflowOffRamp() => router.push(CoinflowOffRampScreen.route());
}
