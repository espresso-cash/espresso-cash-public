import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

import '../../../../../config.dart';
import '../../../../accounts/models/account.dart';
import '../../../../dynamic_links/widgets/dynamic_link_handler.dart';
import '../../../models/ramp_type.dart';
import '../../../widgets/ramp_buttons.dart';
import 'launch.dart';

class CoinflowLinkListener extends SingleChildStatefulWidget {
  const CoinflowLinkListener({
    super.key,
    super.child,
  });

  @override
  State<StatefulWidget> createState() => _LogoutListenerState();
}

class _LogoutListenerState extends SingleChildState<CoinflowLinkListener>
    with DynamicLinkHandler {
  @override
  bool handleDynamicLink(Uri uri) =>
      uri.let(isCoinflowDeepLink).let((isCoinflowLink) {
        if (isCoinflowLink) {
          _handleCoinflowDeepLink();
        }

        return isCoinflowLink;
      });

  Future<void> _handleCoinflowDeepLink() async {
    final profile = await context.ensureProfileData(RampType.offRamp);

    if (context.mounted && profile != null) {
      await context.launchCoinflowOffRamp(
        address: context.read<MyAccount>().wallet.publicKey.toBase58(),
        profile: profile,
      );
    }
  }

  @override
  Widget buildWithChild(BuildContext context, Widget? child) =>
      child ?? const SizedBox.shrink();
}

bool isCoinflowDeepLink(Uri uri) =>
    uri.scheme == espressoCashLinkProtocol && uri.path == '/coinflow';
