import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../ui/app_bar.dart';
import '../../../../ui/bordered_row.dart';
import '../../../../ui/button.dart';
import '../../../../ui/theme.dart';
import '../../../l10n/l10n.dart';
import '../../../routes.gr.dart';

@RoutePage<bool?>()
class OffRampConfirmationScreen extends StatelessWidget {
  const OffRampConfirmationScreen({
    super.key,
    required this.provider,
  });

  static const route = OffRampConfirmationRoute.new;

  final String provider;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return CpTheme.dark(
      child: Scaffold(
        appBar: CpAppBar(
          title: Text(context.l10n.ramp_approveTransactionTitle),
        ),
        body: Column(
          children: [
            CpBorderedRow(
              title: Text(context.l10n.ramp_providerTitle),
              content: BorderedRowChip(
                child: Text(provider, style: _textStyle),
              ),
            ),
            const Spacer(),
            const SizedBox(height: 21),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: CpButton(
                text: context.l10n.ramp_btnApprove,
                minWidth: width,
                onPressed: () => context.router.pop(true),
                size: CpButtonSize.big,
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

const _textStyle = TextStyle(
  fontSize: 17,
  fontWeight: FontWeight.w500,
);
