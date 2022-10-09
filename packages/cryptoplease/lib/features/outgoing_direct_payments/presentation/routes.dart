import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/app/routes.dart';
import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/currency.dart';
import 'package:cryptoplease/features/outgoing_direct_payments/bl/bloc.dart';
import 'package:cryptoplease/features/outgoing_direct_payments/presentation/payment_screen.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solana/solana.dart';
import 'package:uuid/uuid.dart';

const odpRoutes = [
  AutoRoute<void>(page: PaymentScreen),
];

extension OdpRoutesExt on BuildContext {
  void createAndOpenDirectPayment({
    required Decimal amountInUsdc,
    required Ed25519HDPublicKey receiver,
  }) {
    const currency = Currency.usdc;
    final id = const Uuid().v4();

    read<ODPBloc>().add(
      ODPEvent.create(
        id: id,
        receiver: receiver,
        amount: CryptoAmount(
          value: currency.decimalToInt(amountInUsdc),
          currency: currency,
        ),
      ),
    );

    router.push(PaymentRoute(id: id));
  }
}
