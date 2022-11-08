import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/accounts/bl/account.dart';
import '../../../../di.dart';
import '../../../../l10n/l10n.dart';
import '../../../../ui/dialogs.dart';
import '../bl/bloc.dart';
import 'transaction_item.dart';

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
