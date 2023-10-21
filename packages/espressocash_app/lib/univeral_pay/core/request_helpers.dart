import 'package:flutter/material.dart';
import 'package:solana/solana.dart';
import 'package:solana/solana_pay.dart';

import '../../core/amount.dart';
import '../../core/currency.dart';
import '../../l10n/device_locale.dart';
import '../../ui/number_formatter.dart';
import '../config.dart';

SolanaPayRequest? tryParseUniversalPayRequest(Uri link) {
  final linkWithCorrectScheme = link.scheme == 'https' &&
          link.host == espressoUniversalPayDomain &&
          link.queryParameters['recipient'] != null
      ? Uri(
          scheme: 'solana',
          path: link.queryParameters['recipient'],
          queryParameters: {...link.queryParameters}
            ..remove('t')
            ..remove('recipient'),
        )
      : link;

  return SolanaPayRequest.tryParse(linkWithCorrectScheme.toString());
}

extension SolanaPayRequestExt on SolanaPayRequest {
  Uri toUniversalPayLink() {
    final link = Uri.parse(toUrl());

    return link.replace(
      scheme: 'https',
      path: '/send',
      host: espressoUniversalPayDomain,
      queryParameters: {
        't': 'universalpay',
        'recipient': link.path,
        ...link.queryParameters,
      },
    );
  }
}

extension SolanaPayExt on BuildContext {
  SolanaPayRequest? createUniversalRequest({
    required String? amount,
    required String? receiver,
    required String? reference,
  }) {
    if (amount == null || receiver == null || reference == null) {
      return null;
    }

    final locale = DeviceLocale.localeOf(this);
    final decimalAmount = amount.toDecimalOrZero(locale);

    final cryptoAmount = Amount.fromDecimal(
      value: decimalAmount,
      currency: Currency.usdc,
    ) as CryptoAmount;

    return SolanaPayRequest(
      recipient: Ed25519HDPublicKey.fromBase58(receiver),
      amount: cryptoAmount.decimal,
      splToken: cryptoAmount.token.publicKey,
      reference: [Ed25519HDPublicKey.fromBase58(reference)],
    );
  }
}
