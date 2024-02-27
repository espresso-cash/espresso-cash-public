import 'package:auto_route/auto_route.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:solana/solana.dart';

import '../../../core/amount.dart';
import '../../../core/presentation/format_amount.dart';
import '../../../gen/assets.gen.dart';
import '../../../l10n/device_locale.dart';
import '../../../l10n/l10n.dart';
import '../../../routes.gr.dart';
import '../../../routing.dart';
import '../../blockchain/models/blockchain.dart';
import '../../outgoing_direct_payments/screens/odp_confirmation_screen.dart';
import '../../outgoing_direct_payments/screens/odp_details_screen.dart';
import '../../outgoing_direct_payments/screens/odp_input_screen.dart';
import '../../outgoing_direct_payments/widgets/extensions.dart';
import '../../outgoing_dln_payments/screens/confirmation_screen.dart';
import '../widgets/pay_main_page.dart';

@RoutePage()
class PayFlowScreen extends StatefulWidget {
  const PayFlowScreen({
    super.key,
    required this.amount,
  });

  final CryptoAmount amount;

  static const route = PayFlowRoute.new;

  @override
  State<PayFlowScreen> createState() => _PayFlowScreenState();
}

class _PayFlowScreenState extends State<PayFlowScreen> {
  void _handlePrimaryPressed() =>
      context.goNamed(Routes.confirmOLP, extra: widget.amount);

  void _handleSecondaryPressed() {
    context.router.push(
      ODPInputScreen.route(
        onSubmit: (Blockchain network, String address) async {
          if (network == Blockchain.solana) {
            final formatted =
                widget.amount.format(context.locale, skipSymbol: true);

            final recipient = Ed25519HDPublicKey.fromBase58(address);

            final confirmedFiatAmount = await context.router.push<Decimal>(
              ODPConfirmationScreen.route(
                initialAmount: formatted,
                recipient: recipient,
                label: null,
                token: widget.amount.token,
                isEnabled: false,
              ),
            );

            if (confirmedFiatAmount == null) return;
            if (!mounted) return;

            final confirmedCryptoAmount = widget.amount.decimal;

            if (!mounted) return;
            final id = await context.createODP(
              amountInUsdc: confirmedCryptoAmount,
              receiver: recipient,
              reference: null,
            );

            if (!mounted) return;
            await context.router.pop();

            if (!mounted) return;
            await context.router.replace(ODPDetailsScreen.route(id: id));
          } else {
            await context.router.push(
              OutgoingDlnPaymentConfirmationScreen.route(
                amount: widget.amount,
                blockchain: network,
                receiverAddress: address,
              ),
            );
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) => PayMainPage(
        title: context.l10n.walletTransactionMethodTitle,
        headerIcon: Assets.images.sendMoneyGraphic,
        headerBackground: Assets.images.cashInBg,
        theme: PayTheme.dark,
        description: context.l10n.walletEspressoPayLabel,
        moreOptionsLabel: context.l10n.walletPayOther,
        onContinue: _handlePrimaryPressed,
        onMoreOptions: _handleSecondaryPressed,
      );
}
