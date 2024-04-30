import 'package:decimal/decimal.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:solana/solana.dart';

import '../../../gen/assets.gen.dart';
import '../../../l10n/device_locale.dart';
import '../../../l10n/l10n.dart';
import '../../../routing.dart';
import '../../authenticated/authenticated_navigator_key.dart';
import '../../blockchain/models/blockchain.dart';
import '../../conversion_rates/widgets/extensions.dart';
import '../../currency/models/amount.dart';
import '../../outgoing_direct_payments/screens/odp_confirmation_screen.dart';
import '../../outgoing_direct_payments/screens/odp_details_screen.dart';
import '../../outgoing_direct_payments/screens/odp_input_screen.dart';
import '../../outgoing_direct_payments/widgets/extensions.dart';
import '../../outgoing_dln_payments/screens/confirmation_screen.dart';
import '../../outgoing_link_payments/screens/olp_confirmation_screen.dart';
import '../widgets/pay_main_page.dart';

class PayScreen extends StatefulWidget {
  const PayScreen({
    super.key,
    required this.amount,
  });

  final CryptoAmount amount;

  @override
  State<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  void _handlePrimaryPressed() =>
      OLPConfirmationRoute(widget.amount).push<void>(context);

  void _handleSecondaryPressed() {
    ODPInputRoute(
      (Blockchain network, String address) async {
        if (network == Blockchain.solana) {
          final formatted =
              widget.amount.format(context.locale, skipSymbol: true);

          final recipient = Ed25519HDPublicKey.fromBase58(address);

          final confirmedFiatAmount = await ODPConfirmationRoute(
            (
              initialAmount: formatted,
              recipient: recipient,
              label: null,
              token: widget.amount.token,
              isEnabled: false,
            ),
          ).push<Decimal>(context);

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

          ODPDetailsRoute(id).go(context);
        } else {
          OutgoingDlnPaymentConfirmationScreen.push(
            context,
            amount: widget.amount,
            blockchain: network,
            receiverAddress: address,
          );
        }
      },
    ).push<void>(context);
  }

  @override
  Widget build(BuildContext context) => PayMainPage(
        title: context.l10n.walletTransactionMethodTitle,
        headerIcon: Assets.images.sendMoneyGraphic,
        headerBackground: Assets.images.formPageOrangeBg,
        theme: PayTheme.dark,
        description: context.l10n.walletEspressoPayLabel,
        moreOptionsLabel: context.l10n.walletPayOther,
        onContinue: _handlePrimaryPressed,
        onMoreOptions: _handleSecondaryPressed,
      );
}

class PayRoute extends GoRouteData {
  const PayRoute(this.$extra);

  final CryptoAmount $extra;

  static final GlobalKey<NavigatorState> $parentNavigatorKey =
      authenticatedNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      PayScreen(amount: $extra);
}
