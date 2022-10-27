import 'package:cryptoplease/config.dart';
import 'package:cryptoplease/core/presentation/utils.dart';
import 'package:cryptoplease/gen/assets.gen.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/ui/app_bar.dart';
import 'package:cryptoplease/ui/colors.dart';
import 'package:cryptoplease/ui/content_padding.dart';
import 'package:cryptoplease/ui/partner_button.dart';
import 'package:cryptoplease/ui/theme.dart';
import 'package:flutter/material.dart';

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
