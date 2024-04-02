import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:solana/solana_pay.dart';

import '../../../l10n/device_locale.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/bordered_row.dart';
import '../../../ui/button.dart';
import '../../../ui/colors.dart';
import '../../../ui/theme.dart';
import '../../conversion_rates/widgets/extensions.dart';
import '../../currency/models/amount.dart';
import '../../fees/models/fee_type.dart';
import '../../fees/widgets/fee_label.dart';
import '../widgets/merchant_logo_icon.dart';

class OTRConfirmationScreen extends StatelessWidget {
  const OTRConfirmationScreen({
    super.key,
    required this.request,
    required this.amount,
    this.message,
  });

  final TransactionRequestInfo request;
  final CryptoAmount amount;
  final String? message;

  void _handleSubmitted(BuildContext context) {
    context.pop(amount);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return CpTheme.black(
      child: Scaffold(
        appBar: const CpAppBar(),
        body: SafeArea(
          child: Column(
            children: [
              MerchantLogoIcon(logoUrl: request.icon),
              Text(
                request.label,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 38),
              Text(
                amount.format(context.locale, maxDecimals: 2),
                style: const TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 38),
              CpBorderedRow(
                title: const Text('Message'),
                content: Text(message ?? ''),
                dividerColor: CpColors.darkDividerColor,
              ),
              const Spacer(),
              const FeeLabel(type: FeeType.link()),
              const SizedBox(height: 21),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: CpButton(
                  text: context.l10n.pay,
                  minWidth: width,
                  onPressed: () => _handleSubmitted(context),
                  size: CpButtonSize.big,
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

class OTRConfirmationRoute extends GoRouteData {
  const OTRConfirmationRoute(this.$extra);

  final OTRConfirmationParams $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      OTRConfirmationScreen(
        request: $extra.request,
        amount: $extra.amount,
        message: $extra.message,
      );
}

typedef OTRConfirmationParams = ({
  TransactionRequestInfo request,
  CryptoAmount amount,
  String? message,
});
