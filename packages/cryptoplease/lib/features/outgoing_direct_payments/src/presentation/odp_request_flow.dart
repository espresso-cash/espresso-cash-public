import 'package:auto_route/auto_route.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:solana/solana.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/amount.dart';
import '../../../../core/currency.dart';
import '../../../../core/presentation/format_amount.dart';
import '../../../../core/tokens/token.dart';
import '../../../../di.dart';
import '../../../../l10n/device_locale.dart';
import '../../../../routes.gr.dart';
import '../../module.dart';
import '../bl/odp_request.dart';

extension ConfirmOdpRequestExt on BuildContext {
  Future<void> confirmODPRequest(ODPRequest request) async {
    final formatted = request.amount.value == 0
        ? ''
        : request.amount.format(DeviceLocale.localeOf(this), skipSymbol: true);

    final confirmedAmount = await router.push<Decimal>(
      ODPConfirmationRoute(
        initialAmount: formatted,
        recipient: request.receiver,
        label: request.label,
        token: Token.usdc,
        isEnabled: request.amount.value == 0,
      ),
    );
    if (confirmedAmount == null) return;

    await sl<ODPRequestRepository>().delete(request);

    createAndOpenDirectPayment(
      amountInUsdc: confirmedAmount,
      receiver: request.receiver,
      reference: request.reference,
    );
  }
}

Future<ODPRequest> createAndSaveODPRequest({
  required Decimal amountInUsdc,
  required Ed25519HDPublicKey receiver,
  required Ed25519HDPublicKey? reference,
  required String? label,
}) async {
  final id = const Uuid().v4();
  const currency = Currency.usdc;
  final amount = Amount.fromDecimal(value: amountInUsdc, currency: currency);

  final request = ODPRequest(
    id: id,
    receiver: receiver,
    amount: amount as CryptoAmount,
    reference: reference,
    label: label,
    created: DateTime.now(),
  );

  await sl<ODPRequestRepository>().save(request);

  return request;
}
