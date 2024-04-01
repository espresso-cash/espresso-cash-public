import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../../gen/assets.gen.dart';
import '../../../l10n/device_locale.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/back_button.dart';
import '../../../ui/button.dart';
import '../../../ui/chip.dart';
import '../../../ui/colors.dart';
import '../../../ui/content_padding.dart';
import '../../../ui/info_widget.dart';
import '../../../ui/theme.dart';
import '../../conversion_rates/widgets/extensions.dart';
import '../../currency/models/amount.dart';
import '../../fees/models/fee_type.dart';
import '../../fees/widgets/fee_label.dart';
import '../services/off_ramp_order_service.dart';

class OffRampConfirmation extends StatelessWidget {
  const OffRampConfirmation({
    super.key,
    required this.order,
  });

  final OffRampOrder order;

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
            leading: const CpBackButton(),
          ),
          body: Stack(
            children: [
              SizedBox(
                height: double.infinity,
                child:
                    Assets.icons.logoBg.svg(alignment: Alignment.bottomCenter),
              ),
              _Content(
                withdrawAmount: order.amount,
                receiveAmount: order.receiveAmount,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FeeLabel(
                          type: FeeType.withdraw(
                            amount: order.amount.value,
                            partner: order.partner,
                            address: order.depositAddress,
                          ),
                        ),
                        const SizedBox(height: 21),
                        CpButton(
                          size: CpButtonSize.big,
                          width: double.infinity,
                          onPressed: () =>
                              sl<OffRampOrderService>().retry(order.id),
                          text: context.l10n.ramp_btnContinue,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}

class _Content extends StatelessWidget {
  const _Content({
    required this.withdrawAmount,
    this.receiveAmount,
  });

  final Amount withdrawAmount;
  final Amount? receiveAmount;

  @override
  Widget build(BuildContext context) => CpContentPadding(
        child: Column(
          children: [
            const SizedBox(height: 16),
            _AmountView(
              withdrawAmount: withdrawAmount,
              receiveAmount: receiveAmount,
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.all(16),
              child: CpInfoWidget(
                message: Text(context.l10n.offRampWithdrawNotice),
                variant: CpInfoVariant.black,
              ),
            ),
            const Spacer(),
          ],
        ),
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
      skipSymbol: true,
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
        const SizedBox(height: 40),
        if (formattedReceiveAmount != null)
          _ReceiveChip(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: context.l10n
                        .offRampReceiveAmount(
                          formattedReceiveAmount,
                        )
                        .toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text:
                        ' ${receiveAmount?.currency.symbol.toUpperCase() ?? ''}',
                    style: const TextStyle(
                      color: CpColors.yellowColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
      ],
    );
  }
}

class _ReceiveChip extends StatelessWidget {
  const _ReceiveChip({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 55,
        child: CpChip(
          padding: CpChipPadding.normal,
          backgroundColor: Colors.black,
          child: child,
        ),
      );
}
