import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';

import '../../../core/amount.dart';
import '../../../core/currency.dart';
import '../../../core/presentation/format_amount.dart';
import '../../../core/tokens/token_list.dart';
import '../../../core/wallet.dart';
import '../../../di.dart';
import '../../../l10n/device_locale.dart';
import '../../conversion_rates/services/amount_ext.dart';
import '../../incoming_split_key_payments/screens/incoming_split_key_payment_screen.dart';
import '../../incoming_split_key_payments/widgets/extensions.dart';
import '../../outgoing_direct_payments/screens/odp_confirmation_screen.dart';
import '../../outgoing_direct_payments/screens/odp_details_screen.dart';
import '../../outgoing_direct_payments/widgets/extensions.dart';
import '../../payment_request/models/payment_request.dart';
import '../models/qr_scanner_request.dart';
import '../screens/qr_scanner_screen.dart';

extension BuilContextExt on BuildContext {
  Future<void> launchQrScannerFlow({
    ValueSetter<FiatAmount>? onFiatAmountChanged,
    required CryptoCurrency cryptoCurrency,
    FiatAmount? defaultFiatAmount,
  }) async {
    final request =
        await router.push<QrScannerRequest>(QrScannerScreen.route());

    if (request == null) return;
    if (!mounted) return;

    if (request is QrScannerSingleKeyPayment) {
      final escrow = await walletFromKey(
        encodedKey: request.firstPart.key,
      );
      if (!mounted) return;

      final id = await createISKP(
        escrow: escrow,
        version: request.firstPart.apiVersion,
      );

      if (!mounted) return;
      unawaited(router.push(IncomingSplitKeyPaymentScreen.route(id: id)));
    } else {
      final recipient = request.recipient;
      if (recipient == null) return;

      final name = request.mapOrNull(
        solanaPay: (r) => r.request.label,
        address: (r) => r.addressData.name,
      );
      final requestAmount = request.whenOrNull(
        solanaPay: (r) => r.cryptoAmount(sl<TokenList>()),
      );

      if (!mounted) return;

      final isEnabled = requestAmount == null || requestAmount.value == 0;
      defaultFiatAmount = defaultFiatAmount ??
          const FiatAmount(value: 0, fiatCurrency: Currency.usd);
      final initialAmount = requestAmount ?? defaultFiatAmount;
      final formatted = initialAmount.value == 0
          ? ''
          : initialAmount.format(DeviceLocale.localeOf(this), skipSymbol: true);

      final fiatDecimal = await router.push<Decimal>(
        ODPConfirmationScreen.route(
          initialAmount: formatted,
          recipient: recipient,
          label: name,
          token: cryptoCurrency.token,
          isEnabled: isEnabled,
        ),
      );
      if (!mounted) return;

      if (fiatDecimal != null) {
        final finalAmount = defaultFiatAmount.copyWithDecimal(fiatDecimal);
        onFiatAmountChanged?.call(finalAmount);

        final cryptoAmount = finalAmount.toTokenAmount(cryptoCurrency.token) ??
            CryptoAmount(value: 0, cryptoCurrency: cryptoCurrency);

        final id = await createODP(
          amountInUsdc: cryptoAmount.decimal,
          receiver: recipient,
          reference: request.reference,
        );

        if (!mounted) return;
        await router.push(ODPDetailsScreen.route(id: id));
      }
    }
  }
}
