import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/bl/transactions/details/transaction_details_bloc.dart';
import 'package:cryptoplease/presentation/screens/authenticated/transaction_details_screen/components/transaction_details.dart';
import 'package:cryptoplease/presentation/screens/authenticated/transaction_details_screen/components/transaction_details_loading_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionDetailsView extends StatefulWidget {
  const TransactionDetailsView({
    Key? key,
    required this.transactionHash,
    required this.token,
  }) : super(key: key);

  final String transactionHash;
  final Token token;

  @override
  _TransactionDetailsViewState createState() => _TransactionDetailsViewState();
}

class _TransactionDetailsViewState extends State<TransactionDetailsView> {
  @override
  void initState() {
    super.initState();
    context.read<TransactionDetailsBloc>().add(
          TransactionDetailsEvent.load(transactionHash: widget.transactionHash),
        );
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<TransactionDetailsBloc, TransactionDetailsState>(
        builder: (context, state) => state.map(
          ready: (data) => TransactionDetails(
            instructions: data.instructions,
            token: widget.token,
            dateTime: data.dateTime,
            signature: data.signature,
            status: data.status,
          ),
          loading: (_) => const TransactionDetailsLoadingView(),
          error: (_) => _TransactionDetailsError(),
        ),
      );
}

class _TransactionDetailsError extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const Text('error message');
}
