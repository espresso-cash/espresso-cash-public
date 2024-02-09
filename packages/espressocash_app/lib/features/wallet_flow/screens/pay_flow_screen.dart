import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import '../../../l10n/l10n.dart';
import '../../../routes.gr.dart';
import '../widgets/pay_main_page.dart';

@RoutePage()
class PayFlowScreen extends StatelessWidget {
  const PayFlowScreen({
    super.key,
    required this.onLink,
    required this.onManual,
  });
  final VoidCallback onLink;
  final VoidCallback onManual;

  static const route = PayFlowRoute.new;

  @override
  Widget build(BuildContext context) => PayMainPage(
        title: context.l10n.walletTransactionMethodTitle,
        headerIcon: Assets.images.sendMoneyGraphic,
        headerBackground: Assets.images.sendMoneyBg,
        theme: PayTheme.dark,
        description: context.l10n.walletEspressoPayLabel,
        moreOptionsLabel: context.l10n.walletPayOther,
        onContinue: onLink,
        onMoreOptions: onManual,
      );
}
