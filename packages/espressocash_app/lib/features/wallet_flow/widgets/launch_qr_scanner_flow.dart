import 'dart:async';

import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../../l10n/device_locale.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/snackbar.dart';
import '../../accounts/models/wallet.dart';
import '../../conversion_rates/data/repository.dart';
import '../../conversion_rates/services/amount_ext.dart';
import '../../conversion_rates/widgets/extensions.dart';
import '../../currency/models/amount.dart';
import '../../currency/models/currency.dart';
import '../../incoming_link_payments/screens/incoming_link_payment_screen.dart';
import '../../incoming_link_payments/widgets/extensions.dart';
import '../../outgoing_direct_payments/screens/odp_confirmation_screen.dart';
import '../../outgoing_direct_payments/screens/odp_details_screen.dart';
import '../../outgoing_direct_payments/widgets/extensions.dart';
import '../../payment_request/models/payment_request.dart';
import '../../qr_scanner/models/qr_scanner_request.dart';
import '../../qr_scanner/screens/qr_scanner_screen.dart';
import '../../tokens/token_list.dart';
import '../../transaction_request/widgets/extensions.dart';

extension BuildContextExt on BuildContext {
  Future<void> launchQrScannerFlow({
    ValueSetter<FiatAmount>? onFiatAmountChanged,
    required CryptoCurrency cryptoCurrency,
    FiatAmount? defaultFiatAmount,
  }) async {
    final request = await QrScannerScreen.push(this);

    if (request == null) return;
    if (!mounted) return;

    if (request is QrScannerLinkPayment) {
      final escrow = await walletFromKey(encodedKey: request.payment.key);
      if (!mounted) return;

      final id = await createILP(escrow: escrow);

      if (!mounted) return;
      IncomingLinkPaymentScreen.push(this, id: id);
    } else if (request is QrScannerSolanaPayTransactionRequest) {
      final transaction = request.request;

      await processSolanaTransactionRequest(transaction);
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

      if (request is QrScannerSolanaPayRequest) {
        final isPaid = await isSolanaPayRequestPaid(request: request.request);
        if (!mounted) return;

        if (isPaid) {
          showCpSnackbar(this, message: l10n.paymentRequestPaidMessage);

          return;
        }
      }

      final fiatDecimal = await ODPConfirmationScreen.push(
        this,
        initialAmount: formatted,
        recipient: recipient,
        label: name,
        token: cryptoCurrency.token,
        isEnabled: isEnabled,
      );
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
        ODPDetailsScreen.open(this, id: id);
      }
    }
  }
}
