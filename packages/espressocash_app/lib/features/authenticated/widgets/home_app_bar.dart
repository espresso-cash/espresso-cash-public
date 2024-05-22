import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import '../../../ui/colors.dart';
import '../../../ui/icon_button.dart';
import '../../currency/models/currency.dart';
import '../../profile/screens/profile_screen.dart';
import '../../wallet_flow/widgets/launch_qr_scanner_flow.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
    this.backgroundColor = CpColors.darkBackground,
  });

  final Color backgroundColor;

  @override
  Widget build(BuildContext context) => SliverAppBar(
        leading: Center(
          child: CpIconButton(
            icon: Assets.icons.qrScanner.svg(color: Colors.black),
            variant: CpIconButtonVariant.dark,
            onPressed: () =>
                context.launchQrScannerFlow(cryptoCurrency: Currency.usdc),
          ),
        ),
        shape: const Border(),
        title: Center(
          child: Assets.images.logo.image(height: 32),
        ),
        pinned: true,
        snap: false,
        floating: false,
        elevation: 0,
        backgroundColor: backgroundColor,
        actions: [
          CpIconButton(
            icon: Assets.icons.settingsButtonIcon.svg(color: Colors.black),
            variant: CpIconButtonVariant.dark,
            onPressed: () => ProfileScreen.push(context),
          ),
          const SizedBox(width: 12),
        ],
        toolbarHeight: kToolbarHeight + 12,
      );
}
