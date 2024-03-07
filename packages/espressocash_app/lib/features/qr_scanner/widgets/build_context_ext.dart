import 'dart:async';

import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';

import '../../../core/amount.dart';
import '../../../core/currency.dart';
import '../../../core/presentation/format_amount.dart';
import '../../../core/wallet.dart';
import '../../../di.dart';
import '../../../l10n/device_locale.dart';
import '../../../routing.dart';
import '../../conversion_rates/data/repository.dart';
import '../../conversion_rates/services/amount_ext.dart';
import '../../incoming_link_payments/screens/incoming_link_payment_screen.dart';
import '../../incoming_link_payments/widgets/extensions.dart';
import '../../outgoing_direct_payments/screens/odp_confirmation_screen.dart';
import '../../outgoing_direct_payments/screens/odp_details_screen.dart';
import '../../outgoing_direct_payments/widgets/extensions.dart';
import '../../payment_request/models/payment_request.dart';
import '../../tokens/token_list.dart';
import '../models/qr_address_data.dart';
import '../models/qr_scanner_request.dart';
import '../screens/qr_scanner_screen.dart';

extension BuildContextExt on BuildContext {
  Future<void> launchQrScannerFlow({
    ValueSetter<FiatAmount>? onFiatAmountChanged,
    required CryptoCurrency cryptoCurrency,
    FiatAmount? defaultFiatAmount,
  }) async {
    final request = await const QrScannerRoute().push<QrScannerRequest>(this);

    if (request == null) return;
    if (!mounted) return;

    if (request is QrScannerLinkPayment) {
      final escrow = await walletFromKey(encodedKey: request.payment.key);
      if (!mounted) return;

      final id = await createILP(escrow: escrow);

      if (!mounted) return;
      IncomingLinkPaymentRoute(id).go(this);
    } else {
      final recipient = request.recipient;
      if (recipient == null) return;

      final name = request.mapOrNull(
        solanaPay: (r) => r.request.label,
      );
      final requestAmount = request.whenOrNull(
        solanaPay: (r) => r.cryptoAmount(sl<TokenList>()),
      );

      if (!mounted) return;

      final isEnabled = requestAmount == null || requestAmount.value == 0;
      defaultFiatAmount = defaultFiatAmount ??
          const FiatAmount(value: 0, fiatCurrency: Currency.usd);
      final FiatAmount initialAmount = requestAmount?.toFiatAmount(
            Currency.usd,
            ratesRepository: sl<ConversionRatesRepository>(),
          ) ??
          defaultFiatAmount;
      final formatted = initialAmount.value == 0
          ? ''
          : initialAmount.format(DeviceLocale.localeOf(this), skipSymbol: true);

      final fiatDecimal = await ODPConfirmationRoute(
        (
          initialAmount: formatted,
          recipient: recipient,
          label: name,
          token: cryptoCurrency.token,
          isEnabled: isEnabled,
        ),
      ).push<Decimal>(this);
      if (!mounted) return;

      if (fiatDecimal != null) {
        final CryptoAmount cryptoAmount;

        if (isEnabled) {
          final finalAmount = defaultFiatAmount.copyWithDecimal(fiatDecimal);
          onFiatAmountChanged?.call(finalAmount);

          cryptoAmount = finalAmount.toTokenAmount(cryptoCurrency.token) ??
              CryptoAmount(value: 0, cryptoCurrency: cryptoCurrency);
        } else {
          cryptoAmount = requestAmount;
        }

        final id = await createODP(
          amountInUsdc: cryptoAmount.decimal,
          receiver: recipient,
          reference: request.reference,
        );

        if (!mounted) return;
        ODPDetailsRoute(id).go(this);
      }
    }
  }

  Future<String?> launchQrForAddress() async {
    final request = await const QrScannerRoute().push<QrScannerRequest>(this);

    if (request == null) return null;
    if (!mounted) return null;

    if (request is QrScannerAddressRequest) {
      return switch (request.addressData) {
        QrAddressDataSolana(:final address) => address.toBase58(),
        QrAddressDataEvm(:final address) => address,
      };
    }
  }
}
