import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:provider/provider.dart';

import '../../../di.dart';
import '../../../ui/loader.dart';
import '../src/transaction_repository.dart';
import '../src/updater/bloc.dart';
import '../src/widgets/no_activity.dart';
import '../src/widgets/transaction_item.dart';

class TransactionList extends StatefulWidget {
  const TransactionList({
    super.key,
    this.padding,
  });

  final EdgeInsetsGeometry? padding;

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  late final Stream<IList<String>> _txs;

  @override
  void initState() {
    super.initState();
    _txs = sl<TransactionRepository>().watchAll();

    context.read<TxUpdaterBloc>().add(const TxUpdaterEvent.fetch());
  }

  @override
  Widget build(BuildContext context) => RefreshIndicator(
        onRefresh: () => context.read<TxUpdaterBloc>().update(),
        child: StreamBuilder<IList<String>>(
          stream: _txs,
          builder: (context, snapshot) {
            final data = snapshot.data;

            if (data == null) return const SizedBox.shrink();

            final isLoading = context.select<TxUpdaterBloc, bool>(
              (value) => value.state.isProcessing,
            );

            return data.isEmpty
                ? Center(
                    child: isLoading
                        ? const LoadingIndicator()
                        : const NoActivity(),
                  )
                : ListView.custom(
                    padding: widget.padding,
                    childrenDelegate: SliverChildBuilderDelegate(
                      (context, i) => _KeepAlive(
                        key: ValueKey(data[i]),
                        child: TransactionItem(tx: data[i]),
                      ),
                      childCount: data.length,
                      findChildIndexCallback: (Key key) {
                        final ValueKey<String> valueKey =
                            key as ValueKey<String>;
                        final String keyValue = valueKey.value;
                        final index = data.indexOf(keyValue);

                        return index == -1 ? null : index;
                      },
                    ),
                  );
          },
        ),
      );
}

class _KeepAlive extends StatefulWidget {
  const _KeepAlive({
    required Key key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  State<_KeepAlive> createState() => _KeepAliveState();
}

class _KeepAliveState extends State<_KeepAlive>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return widget.child;
  }
}
