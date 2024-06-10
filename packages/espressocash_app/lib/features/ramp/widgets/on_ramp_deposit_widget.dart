import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../di.dart';
import '../../../l10n/device_locale.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/back_button.dart';
import '../../../ui/button.dart';
import '../../../ui/colors.dart';
import '../../../ui/content_padding.dart';
import '../../../ui/dialogs.dart';
import '../../../ui/rounded_rectangle.dart';
import '../../../ui/snackbar.dart';
import '../../../ui/text_button.dart';
import '../../../ui/theme.dart';
import '../../../ui/web_view_screen.dart';
import '../../conversion_rates/widgets/extensions.dart';
import '../../currency/models/amount.dart';
import '../../ramp_partner/models/ramp_partner.dart';
import '../data/on_ramp_order_service.dart';
import 'countdown_timer.dart';

typedef Deposit = ({
  String orderId,
  DateTime orderCreated,
  CryptoAmount? receiveAmount,
  String bankAccount,
  String bankName,
  DateTime transferExpiryDate,
  FiatAmount transferAmount,
  String? moreInfoUrl,
});

class OnRampDepositWidget extends StatelessWidget {
  const OnRampDepositWidget({
    super.key,
    required this.deposit,
    required this.partner,
  });

  final RampPartner partner;
  final Deposit deposit;

  void _handleConfirmPress(BuildContext context) => showConfirmationDialog(
        context,
        title: 'Confirm Deposit',
        titleStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        message:
            'Have you deposit the funds to the selected MoneyGram location?',
        messageStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
        onConfirm: () {
          sl<OnRampOrderService>().confirmDeposit(deposit.orderId);
        },
      );

  @override
  Widget build(BuildContext context) {
    final locale = DeviceLocale.localeOf(context);

    final formattedTransferAmount = deposit.transferAmount.format(locale);

    final formattedReceiveAmount = deposit.receiveAmount?.format(
      locale,
      skipSymbol: true,
      maxDecimals: 2,
    );

    return switch (partner) {
      RampPartner.scalex => _ScalexDepositContent(
          deposit: deposit,
          formattedTransferAmount: formattedTransferAmount,
          formattedReceiveAmount: formattedReceiveAmount,
          onConfirmPress: () => _handleConfirmPress(context),
        ),
      RampPartner.moneygram => _MoneygramDepositContent(
          deposit: deposit,
          formattedTransferAmount: formattedTransferAmount,
          onConfirmPress: () => _handleConfirmPress(context),
        ),
      RampPartner.kado ||
      RampPartner.rampNetwork ||
      RampPartner.coinflow ||
      RampPartner.guardarian =>
        const SizedBox.shrink(),
    };
  }
}

class _ScalexDepositContent extends StatelessWidget {
  const _ScalexDepositContent({
    required this.deposit,
    required this.formattedTransferAmount,
    required this.formattedReceiveAmount,
    required this.onConfirmPress,
  });

  final Deposit deposit;
  final String formattedTransferAmount;
  final String? formattedReceiveAmount;
  final VoidCallback onConfirmPress;

  @override
  Widget build(BuildContext context) => CpTheme.black(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              context.l10n.depositTitle.toUpperCase(),
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 17,
              ),
            ),
            leading: const CpBackButton(),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 24),
                child: CountdownTimer(
                  expiryDate: deposit.transferExpiryDate,
                  startDate: deposit.orderCreated,
                ),
              ),
            ],
            elevation: 0,
            shape: const Border(),
          ),
          body: CpContentPadding(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(height: 16),
                _InstructionItem(
                  index: 1,
                  text: context.l10n.depositInstruction1,
                ),
                const SizedBox(height: 8),
                _ItemWidget(
                  title: context.l10n.depositTransferAmount,
                  value: formattedTransferAmount,
                ),
                const SizedBox(height: 24),
                _ItemWidget(
                  title: '${deposit.bankName} Account',
                  value: deposit.bankAccount,
                ),
                const SizedBox(height: 16),
                _InstructionItem(
                  index: 2,
                  text: context.l10n.depositInstruction2,
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(left: 42),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: context.l10n.depositReceiveAmount(
                            formattedReceiveAmount ?? '',
                          ),
                        ),
                        TextSpan(
                          text:
                              ' ${deposit.receiveAmount?.currency.symbol.toUpperCase() ?? ''}',
                          style: const TextStyle(
                            color: CpColors.yellowColor,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.23,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 42),
                  child: Text(
                    context.l10n.depositDisclaimer,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: CpButton(
                width: double.infinity,
                onPressed: onConfirmPress,
                text: context.l10n.ramp_btnContinue,
              ),
            ),
          ),
        ),
      );
}

class _MoneygramDepositContent extends StatelessWidget {
  const _MoneygramDepositContent({
    required this.deposit,
    required this.formattedTransferAmount,
    required this.onConfirmPress,
  });

  final Deposit deposit;
  final String formattedTransferAmount;
  final VoidCallback onConfirmPress;

  @override
  Widget build(BuildContext context) => CpTheme.black(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              context.l10n.depositTitle.toUpperCase(),
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 17,
              ),
            ),
            leading: const CpBackButton(),
            elevation: 0,
            shape: const Border(),
          ),
          body: CpContentPadding(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(height: 16),
                const _InstructionItem(
                  index: 1,
                  text:
                      'Head to your chosen MoneyGram location to pay for your purchase',
                ),
                const SizedBox(height: 8),
                _ItemWidget(
                  title: context.l10n.depositTransferAmount,
                  value: formattedTransferAmount,
                  showCopy: false,
                ),
                const SizedBox(height: 24),
                const _InstructionItem(
                  index: 2,
                  text: 'Follow instructions from More info link below',
                ),
                const SizedBox(height: 16),
                _InstructionItem(
                  index: 3,
                  text: context.l10n.depositInstruction2,
                ),
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.only(left: 42),
                  child: Text(
                    'Be sure to bring the Photo ID you used, and be prepared to follow additional instructions from the agent',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CpButton(
                    width: double.infinity,
                    onPressed: onConfirmPress,
                    text: context.l10n.ramp_btnContinue,
                  ),
                  if (deposit.moreInfoUrl case final link?) ...[
                    const SizedBox(height: 12),
                    CpTextButton(
                      text: 'More Info',
                      variant: CpTextButtonVariant.light,
                      onPressed: () async {
                        await WebViewScreen.push(
                          context,
                          url: Uri.parse(link),
                          title: 'MoneyGram',
                          theme: const CpThemeData.light(),
                        );
                      },
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      );
}

class _InstructionItem extends StatelessWidget {
  const _InstructionItem({
    required this.text,
    required this.index,
  });
  final int index;
  final String text;

  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: CpColors.yellowColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$index',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.23,
                ),
              ),
            ),
          ),
        ],
      );
}

class _ItemWidget extends StatelessWidget {
  const _ItemWidget({
    required this.value,
    required this.title,
    this.showCopy = true,
  });

  final String title;
  final String value;
  final bool showCopy;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.23,
            ),
          ),
          const SizedBox(height: 12),
          CpRoundedRectangle(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            backgroundColor: Colors.black,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      value,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                if (showCopy)
                  Align(
                    alignment: Alignment.centerRight,
                    child: CpButton(
                      text: context.l10n.copy,
                      minWidth: 80,
                      onPressed: () {
                        final data = ClipboardData(text: value);
                        Clipboard.setData(data);
                        showClipboardSnackbar(context);
                      },
                      size: CpButtonSize.micro,
                    ),
                  ),
              ],
            ),
          ),
        ],
      );
}
