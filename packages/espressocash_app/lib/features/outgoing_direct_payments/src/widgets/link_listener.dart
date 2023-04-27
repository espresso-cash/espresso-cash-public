import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solana/solana_pay.dart';

import '../../../../config.dart';
import '../../../../core/amount.dart';
import '../../../../core/conversion_rates/amount_ext.dart';
import '../../../../core/conversion_rates/bl/repository.dart';
import '../../../../core/currency.dart';
import '../../../../core/dynamic_links_notifier.dart';
import '../../../../core/presentation/format_amount.dart';
import '../../../../core/tokens/token.dart';
import '../../../../l10n/device_locale.dart';
import '../../../../routes.gr.dart';
import '../../widgets/extensions.dart';

class ODPLinkListener extends StatefulWidget {
  const ODPLinkListener({super.key, required this.child});

  final Widget child;

  @override
  State<ODPLinkListener> createState() => _ODPLinkListenerState();
}

class _ODPLinkListenerState extends State<ODPLinkListener> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.watch<DynamicLinksNotifier>().processLink((link) {
      final solanaPayRequest = tryParse(link);
      if (solanaPayRequest != null) {
        if (solanaPayRequest.splToken != Token.usdc.publicKey) {
          // This is not USDC token, silently ignore for now
          return true;
        }

        _processSolanaPayRequest(solanaPayRequest);

        return true;
      }

      return false;
    });
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
        : amount.format(DeviceLocale.localeOf(context), skipSymbol: true);

    final confirmedFiatAmount = await context.router.push<Decimal>(
      ODPConfirmationRoute(
        initialAmount: formatted,
        recipient: request.recipient,
        label: request.label,
        token: crypto.token,
        isEnabled: amount.value == 0,
      ),
    );

    if (confirmedFiatAmount == null) return;
    if (!mounted) return;

    final confirmedCryptoAmount = amount
        .copyWithDecimal(confirmedFiatAmount)
        .toTokenAmount(Token.usdc, ratesRepository: rates)
        ?.decimal;

    if (confirmedCryptoAmount == null) return;

    final id = await context.createODP(
      amountInUsdc: confirmedCryptoAmount,
      receiver: request.recipient,
      reference: request.reference?.firstOrNull,
    );

    if (!mounted) return;
    await context.router.push(ODPDetailsRoute(id: id));
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

SolanaPayRequest? tryParse(Uri link) {
  final linkWithCorrectScheme = link.scheme == 'https' &&
          (link.host == 'solana.$cpLinkDomain' ||
              link.host == 'sol.$cpLinkDomain' ||
              link.host == solanaPayHost ||
              link.host == solanaPayEspressoCashHost) &&
          link.pathSegments.any((s) => s.isNotEmpty)
      ? Uri(
          scheme: 'solana',
          path: link.pathSegments.firstOrNull,
          queryParameters: link.queryParameters,
        )
      : link;

  return SolanaPayRequest.tryParse(linkWithCorrectScheme.toString());
}
