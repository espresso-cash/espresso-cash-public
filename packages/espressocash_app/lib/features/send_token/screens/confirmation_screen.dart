import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:solana/solana.dart';

import '../../../di.dart';
import '../../../l10n/device_locale.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/button.dart';
import '../../../ui/colors.dart';
import '../../../ui/dialogs.dart';
import '../../../ui/number_formatter.dart';
import '../../conversion_rates/widgets/amount_with_equivalent.dart';
import '../../conversion_rates/widgets/extensions.dart';
import '../../currency/models/amount.dart';
import '../../fees/models/fee_type.dart';
import '../../fees/services/fee_calculator.dart';
import '../../token_details/widgets/token_app_bar.dart';
import '../../tokens/token.dart';

class SendTokenConfirmationScreen extends StatefulWidget {
  const SendTokenConfirmationScreen({
    super.key,
    required this.initialAmount,
    required this.recipient,
    required this.label,
    required this.token,
    this.isEnabled = true,
  });

  static Future<Decimal?> push(
    BuildContext context, {
    required String initialAmount,
    required Ed25519HDPublicKey recipient,
    String? label,
    required Token token,
    required bool isEnabled,
  }) =>
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SendTokenConfirmationScreen(
            initialAmount: initialAmount,
            recipient: recipient,
            label: label,
            token: token,
            isEnabled: isEnabled,
          ),
        ),
      );

  final String initialAmount;
  final Ed25519HDPublicKey recipient;
  final String? label;
  final Token token;
  final bool isEnabled;

  @override
  State<SendTokenConfirmationScreen> createState() => _ScreenState();
}

class _ScreenState extends State<SendTokenConfirmationScreen> {
  late final TextEditingController _amountController;
  late Future<CryptoAmount> _feeAmount;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController(text: widget.initialAmount);
    _feeAmount = sl<FeeCalculator>().call(FeeTypeDirect(widget.recipient));
  }

  void _handleSubmitted() {
    final locale = DeviceLocale.localeOf(context);
    final amount = _amountController.text.toDecimalOrZero(locale);
    if (amount == Decimal.zero) {
      showWarningDialog(
        context,
        title: context.l10n.zeroAmountTitle,
        message: context.l10n.zeroAmountMessage(context.l10n.operationSend),
      );
    } else {
      Navigator.pop(context, amount);
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: CpColors.dashboardBackgroundColor,
        body: Stack(
          children: <Widget>[
            SafeArea(
              child: NestedScrollView(
                headerSliverBuilder: (context, _) => [
                  TokenAppBar(
                    token: widget.token,
                    color: CpColors.dashboardBackgroundColor,
                    displayText: false,
                  ),
                ],
                physics: const NeverScrollableScrollPhysics(),
                body: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(31),
                    topRight: Radius.circular(31),
                  ),
                  child: LayoutBuilder(
                    builder: (
                      BuildContext context,
                      BoxConstraints viewportConstraints,
                    ) =>
                        DecoratedBox(
                      decoration: const BoxDecoration(),
                      child: IntrinsicHeight(
                        child: Column(
                          children: [
                            const SizedBox(height: 36),
                            Expanded(
                              child: DecoratedBox(
                                decoration: const BoxDecoration(
                                  color: CpColors.dashboardBackgroundColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(31),
                                    topRight: Radius.circular(31),
                                  ),
                                ),
                                child: Center(
                                  child: Column(
                                    children: [
                                      AmountWithEquivalent(
                                        inputController: _amountController,
                                        token: widget.token,
                                        collapsed: widget.isEnabled,
                                        backgroundColor:
                                            CpColors.dashboardBackgroundColor,
                                      ),
                                      const SizedBox(height: 72),
                                      FutureBuilder(
                                        future: _feeAmount,
                                        builder: (context, fee) => _Info(
                                          '${substring(widget.recipient.toBase58(), 0, 6)}'
                                          '\u2026'
                                          '${substring(widget.recipient.toBase58(), widget.recipient.toBase58().length - 6)}',
                                          fee.connectionState !=
                                                  ConnectionState.waiting
                                              ? fee.data != null
                                                  ? '\$${fee.data!.format(DeviceLocale.localeOf(context), skipSymbol: true)}'
                                                  : 'Unable to fetch fee'
                                              : 'Fetching fee...',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 47.0,
                                left: 25,
                                right: 25,
                              ),
                              child: CpButton(
                                text: context.l10n.pay,
                                minWidth: MediaQuery.sizeOf(context).width,
                                onPressed: _handleSubmitted,
                                size: CpButtonSize.big,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}

class _Info extends StatelessWidget {
  const _Info(this.walletAddres, this.fees);

  final String walletAddres;
  final String fees;

  @override
  Widget build(BuildContext context) => _SendInfoContainer(
        title: '',
        content: Column(
          children: [
            _InfoItem(
              label: 'Wallet address',
              value: walletAddres,
            ),
            const SizedBox(height: 6),
            _InfoItem(
              label: 'Fees',
              value: fees,
            ),
          ],
        ),
      );
}

class _InfoItem extends StatelessWidget {
  const _InfoItem({
    required this.label,
    required this.value,
  });
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xff999999),
              ),
            ),
          ],
        ),
      );
}

class _SendInfoContainer extends StatelessWidget {
  const _SendInfoContainer({
    required this.title,
    required this.content,
  });

  final String title;
  final Widget content;

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 22),
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 28),
        decoration: const ShapeDecoration(
          color: CpColors.darkBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(28),
            ),
          ),
        ),
        child: content,
      );
}
