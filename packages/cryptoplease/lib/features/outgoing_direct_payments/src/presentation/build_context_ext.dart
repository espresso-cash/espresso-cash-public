import 'package:auto_route/auto_route.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solana/solana.dart';
import 'package:uuid/uuid.dart';

import '../../../../app/routes.gr.dart';
import '../../../../core/amount.dart';
import '../../../../core/currency.dart';
import '../bl/bloc.dart';

extension OdpRoutesExt on BuildContext {
  void createAndOpenDirectPayment({
    required Decimal amountInUsdc,
    required Ed25519HDPublicKey receiver,
    required Ed25519HDPublicKey? reference,
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
        reference: reference,
      ),
    );

    router.push(ODPDetailsRoute(id: id));
  }
}
