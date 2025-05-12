import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart' hide Notification;

import '../../../di.dart';
import '../../../ui/colors.dart';
import '../data/transaction_repository.dart';
import '../services/tx_updater.dart';
import 'no_activity.dart';
import 'transaction_item.dart';

class TransactionList extends StatefulWidget {
  const TransactionList({super.key, this.padding});

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
    sl<TxUpdater>().call();
  }

  @override
  Widget build(BuildContext context) => RefreshIndicator(
    onRefresh: () => sl<TxUpdater>().call(),
    color: CpColors.primaryColor,
    backgroundColor: Colors.white,
    child: StreamBuilder<IList<String>>(
      stream: _txs,
      builder: (context, snapshot) {
        final data = snapshot.data;

        if (data == null) return const SizedBox.shrink();

        return data.isEmpty
            ? const Center(child: NoActivity())
            : CustomScrollView(
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              slivers: [
                const SliverPadding(padding: EdgeInsets.only(top: _topPadding)),
                SliverPadding(
                  padding: widget.padding ?? EdgeInsets.zero,
                  sliver: DecoratedSliver(
                    decoration: const BoxDecoration(
                      color: CpColors.blackGreyColor,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    sliver: SliverPadding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, i) => _KeepAlive(
                            key: ValueKey(data[i]),
                            child: TransactionItem(tx: data[i]),
                          ),
                          childCount: data.length,
                          findChildIndexCallback: (Key key) {
                            // ignore: avoid-type-casts, local value
                            final ValueKey<String> valueKey = key as ValueKey<String>;
                            final String keyValue = valueKey.value;
                            final index = data.indexOf(keyValue);

                            return index == -1 ? null : index;
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
      },
    ),
  );
}

class _KeepAlive extends StatefulWidget {
  const _KeepAlive({required Key key, required this.child}) : super(key: key);

  final Widget child;

  @override
  State<_KeepAlive> createState() => _KeepAliveState();
}

class _KeepAliveState extends State<_KeepAlive> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return widget.child;
  }
}

const double _topPadding = 30;
