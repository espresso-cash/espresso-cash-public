import 'package:flutter/material.dart';

import '../../../../config.dart';
import '../../../../core/presentation/utils.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../l10n/l10n.dart';
import '../../../../ui/app_bar.dart';
import '../../../../ui/colors.dart';
import '../../../../ui/content_padding.dart';
import '../../../../ui/partner_button.dart';
import '../../../../ui/theme.dart';

class CashOutScreen extends StatelessWidget {
  const CashOutScreen({super.key});

  @override
  Widget build(BuildContext context) => CpTheme.dark(
        child: Scaffold(
          backgroundColor: CpColors.darkBackground,
          appBar: CpAppBar(
            leading: const CloseButton(),
            title: Text(context.l10n.cashOut.toUpperCase()),
          ),
          body: CpContentPadding(
            child: ListView(
              physics: const ClampingScrollPhysics(),
              children: [
                Text(
                  context.l10n.cashOutSubtitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14.5),
                ),
                const SizedBox(height: 24),
                PartnerButton(
                  onTap: () => context.openLink(ftxCashoutSupportUrl),
                  image: Assets.images.logoFtx,
                  backgroundColor: const Color(0xff12a8c9),
                ),
              ],
            ),
          ),
        ),
      );
}
