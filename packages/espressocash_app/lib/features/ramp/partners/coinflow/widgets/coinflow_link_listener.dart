import 'package:flutter/material.dart';

import '../../../../../config.dart';
import '../../../../../di.dart';
import '../../../../accounts/models/account.dart';
import '../../../../dynamic_links/widgets/dynamic_link_handler.dart';
import '../../../models/ramp_type.dart';
import '../../../widgets/ramp_buttons.dart';
import 'launch.dart';

class CoinflowLinkListener extends StatefulWidget {
  const CoinflowLinkListener({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<StatefulWidget> createState() => _CoinflowLinkListenerState();
}

class _CoinflowLinkListenerState extends State<CoinflowLinkListener>
    with DynamicLinkHandler {
  static bool _isCoinflowDeepLink(Uri uri) =>
      uri.scheme == espressoCashLinkProtocol && uri.path == '/coinflow';

  @override
  bool handleDynamicLink(Uri uri) {
    if (!_isCoinflowDeepLink(uri)) return false;

    _handleCoinflowDeepLink();

    return true;
  }

  Future<void> _handleCoinflowDeepLink() async {
    final profile = await context.ensureProfileData(RampType.offRamp);

    if (mounted && profile != null) {
      await context.launchCoinflowOffRamp(
        address: sl<MyAccount>().wallet.publicKey.toBase58(),
        profile: profile,
      );
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
