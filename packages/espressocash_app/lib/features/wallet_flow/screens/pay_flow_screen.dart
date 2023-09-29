import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';
import '../../../routes.gr.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/theme.dart';
import '../widgets/pay_item.dart';

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
  Widget build(BuildContext context) => CpTheme.black(
        child: Scaffold(
          appBar: CpAppBar(
            title: Text(context.l10n.walletTransactionMethodTitle),
          ),
          body: Column(
            children: [
              const SizedBox(height: 32),
              PayMethodItem(
                title: context.l10n.walletEspressoPayTitle,
                subtitle: context.l10n.walletEspressoPaySubtitle,
                buttonText: context.l10n.walletEspressoPayBtnTitle,
                onPressed: onLink,
                buttonTrailing: const Icon(
                  Icons.keyboard_arrow_right_outlined,
                  color: Colors.white,
                  size: 34,
                ),
              ),
              const Divider(
                color: Color(0xff454243),
                thickness: 1.5,
              ),
              PayMethodItem(
                title: context.l10n.walletManualPayTitle,
                subtitle: context.l10n.walletManualPaySubtitle,
                buttonText: context.l10n.walletManualPayBtnTitle,
                onPressed: onManual,
                buttonTrailing: const Icon(
                  Icons.keyboard_arrow_right_outlined,
                  color: Colors.white,
                  size: 34,
                ),
              ),
            ],
          ),
        ),
      );
}
