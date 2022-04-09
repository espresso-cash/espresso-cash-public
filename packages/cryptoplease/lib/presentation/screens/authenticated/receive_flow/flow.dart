import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/config.dart';
import 'package:cryptoplease/presentation/routes.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

extension ReceiveFlowExt on BuildContext {
  void navigateToSendFlow({Token? token}) => navigateTo(
        RequestTypeRoute(
          onLinkSelected: () {
            if (isProd) {
              showCpSnackbar(this, message: 'Coming soon!');
            } else {
              navigateTo(LinkRequestFlowRoute(initialToken: token));
            }
          },
          onAddressSelected: () => navigateTo(const ShareAddressRoute()),
        ),
      );
}
