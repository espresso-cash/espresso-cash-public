import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import '../../../ui/colors.dart';
import '../../../ui/icon_button.dart';
import '../../currency/models/currency.dart';
import '../../profile/screens/profile_screen.dart';
import '../../wallet_flow/widgets/launch_qr_scanner_flow.dart';

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({
    super.key,
    this.backgroundColor = CpColors.darkBackground,
    this.scrollController,
  });

  final Color backgroundColor;
  final ScrollController? scrollController;

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
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
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Center(
            child: Assets.images.logo.image(height: 32),
          ),
        ),
        pinned: true,
        snap: false,
        floating: false,
        elevation: 0,
        backgroundColor: widget.backgroundColor,
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
