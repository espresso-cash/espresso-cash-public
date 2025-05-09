import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/bottom_button.dart';
import '../../../ui/button.dart';
import '../../../ui/colors.dart';
import '../../../ui/theme.dart';

class ManageDataAccessScreen extends StatelessWidget {
  const ManageDataAccessScreen({super.key});

  static void push(BuildContext context) => Navigator.of(
    context,
  ).push<void>(MaterialPageRoute(builder: (context) => const ManageDataAccessScreen()));

  @override
  Widget build(BuildContext context) => CpTheme.dark(
    child: Scaffold(
      backgroundColor: CpColors.blackGreyColor,
      appBar: CpAppBar(title: Text(context.l10n.manageDataAccess.toUpperCase())),
      body: const _Content(),
    ),
  );
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(
      top: 40,
      left: 40,
      right: 40,
      bottom: MediaQuery.paddingOf(context).bottom,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(context.l10n.networkPartners.toUpperCase()),
        ),
        const Spacer(),
        CpBottomButton(
          horizontalPadding: 0,
          text: context.l10n.deleteAllData,
          onPressed: () {},
          variant: CpButtonVariant.danger,
        ),
      ],
    ),
  );
}
