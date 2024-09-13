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
    this.backgroundColor = CpColors.darkGoldBackgroundColor,
  });

  final Color backgroundColor;

  @override
  Widget build(BuildContext context) => SliverAppBar(
        leading: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: CpIconButton(
              icon: Assets.icons.qrScanner.svg(color: Colors.black),
              variant: CpIconButtonVariant.dark,
              onPressed: () => context.launchQrScannerFlow(
                cryptoCurrency: Currency.usdc,
              ),
            ),
          ),
        ),
        shape: const Border(),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 4.0, right: 8.0),
          child: Center(
            child: Assets.images.logo.image(height: 32),
          ),
        ),
        pinned: true,
        snap: false,
        floating: false,
        elevation: 0,
        backgroundColor: backgroundColor,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CpIconButton(
              icon: Assets.icons.settingsButtonIcon.svg(color: Colors.black),
              variant: CpIconButtonVariant.dark,
              onPressed: () => ProfileScreen.push(context),
            ),
          ),
          const SizedBox(width: 12),
        ],
        toolbarHeight: kToolbarHeight + 4,
      );
}

class HomeScaffoldAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const HomeScaffoldAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: AppBar(
          leading: Center(
            child: CpIconButton(
              icon: Assets.icons.qrScanner.svg(color: Colors.black),
              variant: CpIconButtonVariant.dark,
              onPressed: () => context.launchQrScannerFlow(
                cryptoCurrency: Currency.usdc,
              ),
            ),
          ),
          shape: const Border(),
          title: Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Assets.images.logo.image(height: 32),
            ),
          ),
          elevation: 0,
          backgroundColor: CpColors.darkGoldBackgroundColor,
          actions: [
            CpIconButton(
              icon: Assets.icons.settingsButtonIcon.svg(color: Colors.black),
              variant: CpIconButtonVariant.dark,
              onPressed: () => ProfileScreen.push(context),
            ),
            const SizedBox(width: 12),
          ],
          toolbarHeight: kToolbarHeight + 4,
        ),
      );

  @override
  Size get preferredSize => const Size(double.infinity, kToolbarHeight + 4);
}
