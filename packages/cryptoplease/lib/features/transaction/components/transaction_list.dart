import 'package:cryptoplease/app/components/dialogs.dart';
import 'package:cryptoplease/core/accounts/bl/account.dart';
import 'package:cryptoplease/di.dart';
import 'package:cryptoplease/features/transaction/bl/bloc.dart';
import 'package:cryptoplease/features/transaction/components/transaction_item.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionList extends StatefulWidget {
  const TransactionList({
    Key? key,
    this.padding,
  }) : super(key: key);

  final EdgeInsetsGeometry? padding;

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  late final TransactionBloc transactionBloc;

  @override
  void initState() {
    super.initState();
    transactionBloc = sl<TransactionBloc>(
      param1: context.read<MyAccount>().wallet,
    )..add(const TransactionEvent.fetch());
  }

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<TransactionBloc, TransactionState>(
        bloc: transactionBloc,
        listener: (context, state) => state.maybeWhen(
          failure: (error) => showErrorDialog(
            context,
            context.l10n.transactionFetchFailed,
            error,
          ),
          orElse: ignore,
        ),
        builder: (context, state) => state.maybeMap(
          success: (state) => ListView.builder(
            padding: widget.padding,
            itemBuilder: (context, i) => TransactionItem(
              txFetched: state.result.elementAt(i),
            ),
            itemCount: state.result.length,
          ),
          processing: always(const Center(child: CircularProgressIndicator())),
          orElse: always(const SizedBox.shrink()),
        ),
      );
}
