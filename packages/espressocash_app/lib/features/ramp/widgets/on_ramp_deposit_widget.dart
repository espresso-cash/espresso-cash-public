import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../../gen/assets.gen.dart';
import '../../../l10n/device_locale.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/back_button.dart';
import '../../../ui/button.dart';
import '../../../ui/dialogs.dart';
import '../../../ui/page_spacer_wrapper.dart';
import '../../../ui/theme.dart';
import '../../../ui/web_view_screen.dart';
import '../../conversion_rates/widgets/extensions.dart';
import '../../currency/models/amount.dart';
import '../../ramp_partner/models/ramp_partner.dart';
import '../partners/moneygram/widgets/style.dart';
import '../services/on_ramp_order_service.dart';

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
  const OnRampDepositWidget({super.key, required this.deposit, required this.partner});

  final RampPartner partner;
  final Deposit deposit;

  void _handleConfirmPress() => sl<OnRampOrderService>().confirmDeposit(deposit.orderId);

  @override
  Widget build(BuildContext context) {
    final locale = DeviceLocale.localeOf(context);

    final formattedTransferAmount = deposit.transferAmount.format(locale);

    return switch (partner) {
      RampPartner.moneygram => _MoneygramDepositContent(
        deposit: deposit,
        formattedTransferAmount: formattedTransferAmount,
        onConfirmPress: _handleConfirmPress,
      ),
      RampPartner.brijRedirect ||
      RampPartner.coinflow => const SizedBox.shrink(),
    };
  }
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

  void _handleConfirmPress(BuildContext context) => showConfirmationDialog(
    context,
    title: 'Confirm Deposit',
    titleStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
    message: 'Have you deposit the funds to the selected MoneyGram location?',
    messageStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.white),
    onConfirm: onConfirmPress.call,
  );

  @override
  Widget build(BuildContext context) => CpTheme.light(
    child: Scaffold(
      appBar: AppBar(
        title: Text(
          context.l10n.depositTitle.toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17, color: Colors.black),
        ),
        leading: const CpBackButton(),
        elevation: 0,
        shape: const Border(),
      ),
      body: Stack(
        children: [
          const _MoneygramBackground(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Assets.gifs.moneygramConfirmationAnimation.image(width: 320),
                const SizedBox(height: 16),
                Assets.images.moneygramLogo.image(height: 32),
                const SizedBox(height: 16),
                Text(
                  context.l10n.confirmYourTransferOf,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  formattedTransferAmount,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 46,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    context.l10n.moneygramInstructionText,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      letterSpacing: 0.41,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 45),
                  child: CpButton(
                    size: CpButtonSize.big,
                    width: double.infinity,
                    onPressed: () => _handleConfirmPress(context),
                    text: context.l10n.confirmTransfer,
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    WebViewScreen.push(
                      context,
                      url: Uri.parse(deposit.moreInfoUrl ?? ''),
                      title: context.l10n.depositTitle.toUpperCase(),
                      theme: const CpThemeData.light(),
                      onLoaded: (controller) async {
                        await controller.evaluateJavascript(source: await loadMoneygramStyle());
                      },
                    );
                  },
                  child: SizedBox(
                    height: CpButtonSize.big.height,
                    child: Center(
                      child: Text(
                        context.l10n.viewMoneygramTransferInstructions,
                        style: const TextStyle(
                          color: Color(0xffCB6E00),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _MoneygramBackground extends StatelessWidget {
  const _MoneygramBackground();

  @override
  Widget build(BuildContext context) => Align(
    alignment: Alignment.bottomCenter,
    child: Stack(
      children: [
        Assets.icons.logoBgAlternative.svg(alignment: Alignment.bottomCenter),
        const FadeGradient(
          height: 150,
          color: FadeGradientColor.white,
          direction: FadeGradientDirection.topDown,
        ),
      ],
    ),
  );
}
