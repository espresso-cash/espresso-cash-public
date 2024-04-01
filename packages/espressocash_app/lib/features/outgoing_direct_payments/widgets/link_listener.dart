import 'package:collection/collection.dart';
import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:espressocash_common/dart.dart';
import 'package:espressocash_common/flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solana/solana_pay.dart';

import '../../../routing.dart';
import '../../../utils/solana_pay.dart';
import '../../conversion_rates/data/repository.dart';
import '../../conversion_rates/services/amount_ext.dart';
import '../../dynamic_links/widgets/dynamic_link_handler.dart';
import '../screens/odp_confirmation_screen.dart';
import '../screens/odp_details_screen.dart';
import 'extensions.dart';

class ODPLinkListener extends StatefulWidget {
  const ODPLinkListener({super.key, required this.child});

  final Widget child;

  @override
  State<ODPLinkListener> createState() => _ODPLinkListenerState();
}

class _ODPLinkListenerState extends State<ODPLinkListener>
    with DynamicLinkHandler {
  @override
  bool handleDynamicLink(Uri uri) {
    final solanaPayRequest = tryParseSolanaPayRequest(uri);
    if (solanaPayRequest != null) {
      if (solanaPayRequest.splToken != Token.usdc.publicKey) {
        // This is not USDC token, silently ignore for now
        return true;
      }

      _processSolanaPayRequest(solanaPayRequest);

      return true;
    }

    return false;
  }

  Future<void> _processSolanaPayRequest(SolanaPayRequest request) async {
    const fiat = Currency.usd;
    const crypto = Currency.usdc;
    final rates = context.read<ConversionRatesRepository>();

    final amount = request.amount
        .maybeFlatMap((it) => Amount.fromDecimal(value: it, currency: crypto))
        .maybeFlatMap((it) => it as CryptoAmount)
        .maybeFlatMap((it) => it.toFiatAmount(fiat, ratesRepository: rates))
        .ifNull(() => const FiatAmount(value: 0, fiatCurrency: Currency.usd));

    final formatted = amount.value == 0
        ? ''
        : amount.format(context.locale, skipSymbol: true);

    final confirmedFiatAmount = await ODPConfirmationRoute(
      (
        initialAmount: formatted,
        recipient: request.recipient,
        label: request.label,
        token: crypto.token,
        isEnabled: amount.value == 0,
      ),
    ).push<Decimal>(context);

    if (confirmedFiatAmount == null) return;
    if (!mounted) return;

    final confirmedCryptoAmount = amount
        .copyWithDecimal(confirmedFiatAmount)
        .toTokenAmount(Token.usdc)
        ?.decimal;

    if (confirmedCryptoAmount == null) return;

    final id = await context.createODP(
      amountInUsdc: confirmedCryptoAmount,
      receiver: request.recipient,
      reference: request.reference?.firstOrNull,
    );

    if (!mounted) return;
    ODPDetailsRoute(id).go(context);
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
