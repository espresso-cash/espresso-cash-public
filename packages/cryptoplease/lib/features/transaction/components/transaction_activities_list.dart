import 'package:cryptoplease/core/accounts/bl/account.dart';
import 'package:cryptoplease/di.dart';
import 'package:cryptoplease/features/transaction/bl/bloc.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionActivitiesList extends StatefulWidget {
  const TransactionActivitiesList({
    Key? key,
    this.padding,
  }) : super(key: key);

  final EdgeInsetsGeometry? padding;

  @override
  State<TransactionActivitiesList> createState() =>
      _TransactionActivitiesListState();
}

class _TransactionActivitiesListState extends State<TransactionActivitiesList> {
  late final TransactionBloc transactionBloc;

  @override
  void initState() {
    super.initState();
    transactionBloc = sl<TransactionBloc>(
      param1: context.read<MyAccount>().wallet,
    )..add(const TransactionEvent.fetch());
  }

// TODO(rhbrunetto): fix it
  @override
  Widget build(BuildContext context) =>
      BlocBuilder<TransactionBloc, TransactionState>(
        bloc: transactionBloc,
        builder: (context, state) => state.maybeMap(
          orElse: always(
            const Center(
              child: CircularProgressIndicator(),
            ),
          ),
          failure: (state) => Center(
            child: Text(state.error.toString()),
          ),
          success: (state) => ListView.builder(
            padding: widget.padding,
            itemBuilder: (context, i) {
              final item = state.result.elementAt(i);

              return ListTile(title: Text(item.toString()));
            },
            itemCount: state.result.length,
          ),
        ),
      );
}
