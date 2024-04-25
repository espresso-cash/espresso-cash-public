import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import '../../../routing.dart';
import '../../../ui/colors.dart';
import '../../../ui/icon_button.dart';
import '../../currency/models/currency.dart';
import '../../profile/screens/profile_screen.dart';
import '../../qr_scanner/widgets/build_context_ext.dart';

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
            icon: Assets.icons.qrScanner.svg(),
            variant: CpIconButtonVariant.black,
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
            icon: Assets.icons.settingsButtonIcon.svg(color: Colors.white),
            variant: CpIconButtonVariant.black,
            onPressed: () => const ProfileRoute().go(context),
          ),
          const SizedBox(width: 12),
        ],
        toolbarHeight: kToolbarHeight + 12,
      );
}
