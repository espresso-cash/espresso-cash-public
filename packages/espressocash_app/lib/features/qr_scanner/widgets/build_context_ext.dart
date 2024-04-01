import 'dart:async';

import 'package:decimal/decimal.dart';
import 'package:espressocash_common/espressocash_common.dart';
import 'package:flutter/material.dart';
import 'package:solana/solana.dart';
import 'package:solana/solana_pay.dart';

import '../../../di.dart';
import '../../../l10n/device_locale.dart';
import '../../../routing.dart';
import '../../../ui/loader.dart';
import '../../../utils/solana_client.dart';
import '../../accounts/models/ec_wallet.dart';
import '../../accounts/models/wallet.dart';
import '../../conversion_rates/data/repository.dart';
import '../../conversion_rates/services/amount_ext.dart';
import '../../conversion_rates/widgets/extensions.dart';
import '../../incoming_link_payments/screens/incoming_link_payment_screen.dart';
import '../../incoming_link_payments/widgets/extensions.dart';
import '../../outgoing_direct_payments/screens/odp_confirmation_screen.dart';
import '../../outgoing_direct_payments/screens/odp_details_screen.dart';
import '../../outgoing_direct_payments/widgets/extensions.dart';
import '../../payment_request/models/payment_request.dart';
import '../../tokens/token_list.dart';
import '../../transaction_request/screens/confirmation_screen.dart';
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
    } else if (request is QrScannerSolanaPayTransactionRequest) {
      final transaction = request.request;

      await runWithLoader(this, () async {
        //TODO update and move this somewhere
        final info = await transaction.get();

        final wallet = sl<ECWallet>().publicKey;

        final client = sl<SolanaClient>();
        final respTx = await transaction.post(account: wallet.toBase58());

        final tx = await client.processSolanaPayTransactionRequest(
          transaction: respTx.transaction,
          signer: wallet,
        );

        // TODO catch simulate error, mostlikely insufficient funds
        final simulate = await client.simulateTransfer(
          tx: tx,
          account: wallet,
          currency: Currency.usdc,
        );

        unawaited(
          //TODO remove unawaited
          OTRConfirmationRoute(
            (
              request: info,
              amount: CryptoAmount(
                value: simulate?.amountTransferred ?? 0,
                cryptoCurrency: Currency.usdc,
              ),
              message: respTx.message,
            ),
          ).push<void>(this),
        );

        // TODO after confirmation, send the tx
      });
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
