import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:provider/provider.dart';

import '../../../../di.dart';
import '../transaction.dart';
import '../transaction_repository.dart';
import '../updater/bloc.dart';
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
  late final Stream<IList<Transaction>> _txs;

  @override
  void initState() {
    super.initState();
    _txs = sl<TransactionRepository>().watchAll();

    context.read<TxUpdaterBloc>().add(const TxUpdaterEvent.fetch());
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<IList<Transaction>>(
        stream: _txs,
        builder: (context, snapshot) {
          final data = snapshot.data;

          if (data == null) return const SizedBox.shrink();

          return ListView.builder(
            padding: widget.padding,
            itemBuilder: (context, i) => TransactionItem(tx: data[i]),
            itemCount: data.length,
          );
        },
      );
}
