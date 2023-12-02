import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../core/amount.dart';
import '../../../core/fee_label.dart';
import '../../../core/presentation/format_amount.dart';
import '../../../l10n/device_locale.dart';
import '../../../l10n/l10n.dart';
import '../../../routes.gr.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/back_button.dart';
import '../../../ui/button.dart';
import '../../../ui/chip.dart';
import '../../../ui/content_padding.dart';
import '../../../ui/info_widget.dart';
import '../../../ui/theme.dart';

@RoutePage()
class OffRampConfirmationScreen extends StatelessWidget {
  const OffRampConfirmationScreen({
    super.key,
    required this.withdrawAmount,
    required this.fee,
    required this.onSubmit,
    this.receiveAmount,
  });

  static const route = OffRampConfirmationRoute.new;

  final Amount withdrawAmount;
  final Amount? receiveAmount;
  final Amount fee;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) => CpTheme.black(
        child: Scaffold(
          appBar: CpAppBar(
            title: Text(
              context.l10n.offRampWithdrawTitle.toUpperCase(),
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 17,
              ),
            ),
            leading: CpBackButton(
              onPressed: () => context.router.popUntilRoot(),
            ),
          ),
          body: CpContentPadding(
            child: _TokenCreateLinkContent(
              withdrawAmount: withdrawAmount,
              receiveAmount: receiveAmount,
              fee: fee,
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const FeeLabel(type: FeeType.splitKey()),
                  const SizedBox(height: 21),
                  CpButton(
                    width: double.infinity,
                    onPressed: onSubmit,
                    text: context.l10n.ramp_btnContinue,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

class _TokenCreateLinkContent extends StatelessWidget {
  const _TokenCreateLinkContent({
    required this.withdrawAmount,
    required this.fee,
    this.receiveAmount,
  });

  final Amount withdrawAmount;
  final Amount? receiveAmount;
  final Amount fee;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const SizedBox(height: 60),
          _AmountView(
            withdrawAmount: withdrawAmount,
            receiveAmount: receiveAmount,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: CpInfoWidget(
              message: Text(context.l10n.offRampWithdrawNotice),
              variant: CpInfoVariant.black,
            ),
          ),
          const Spacer(),
        ],
      );
}

class _AmountView extends StatelessWidget {
  const _AmountView({required this.withdrawAmount, this.receiveAmount});

  final Amount withdrawAmount;
  final Amount? receiveAmount;

  @override
  Widget build(BuildContext context) {
    final locale = DeviceLocale.localeOf(context);
    final formattedAmount = withdrawAmount.format(
      locale,
      maxDecimals: withdrawAmount.currency.decimals,
    );

    final formattedReceiveAmount = receiveAmount?.format(
      locale,
      maxDecimals: withdrawAmount.currency.decimals,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FittedBox(
          child: Text(
            formattedAmount,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 55,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 24),
          child: CpChip(
            // TODO(KB): Check if needed
            // ignore: avoid-single-child-column-or-row
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (formattedReceiveAmount != null)
                  FittedBox(
                    child: Text(
                      context.l10n
                          .offRampReceiveAmount(formattedReceiveAmount)
                          .toUpperCase(),
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
