import 'package:flutter/material.dart';

import '../../../../l10n/l10n.dart';
import '../../../../ui/app_bar.dart';
import '../../../../ui/colors.dart';
import '../../../../ui/content_padding.dart';
import '../../../../ui/theme.dart';

class OffRampScreen extends StatelessWidget {
  const OffRampScreen({super.key});

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
              ],
            ),
          ),
        ),
      );
}
