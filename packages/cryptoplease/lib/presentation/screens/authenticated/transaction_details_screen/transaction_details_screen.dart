import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/bl/transactions/details/transaction_details_bloc.dart';
import 'package:cryptoplease/config.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/screens/authenticated/transaction_details_screen/components/transaction_details_view.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana/solana.dart';

class TransactionDetailsScreenData {
  const TransactionDetailsScreenData({
    required this.transactionSignature,
    required this.token,
  });

  final String transactionSignature;
  final Token token;
}

class TransactionDetailsScreen extends StatelessWidget {
  const TransactionDetailsScreen({
    Key? key,
    required this.data,
  }) : super(key: key);

  final TransactionDetailsScreenData data;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: CpAppBar(
          title: Text(context.l10n.transactionDetails.toUpperCase()),
        ),
        body: BlocProvider<TransactionDetailsBloc>(
          create: (_) => TransactionDetailsBloc(RpcClient(solanaRpcUrl)),
          child: TransactionDetailsView(
            transactionHash: data.transactionSignature,
            token: data.token,
          ),
        ),
      );
}
