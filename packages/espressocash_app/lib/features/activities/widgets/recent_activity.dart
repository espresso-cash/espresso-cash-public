import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:intl/intl.dart';

import '../../../di.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/button.dart';
import '../../../ui/colors.dart';
import '../../../ui/home_tile.dart';
import '../../../ui/theme.dart';
import '../data/transaction_repository.dart';
import '../models/transaction.dart';
import '../services/tx_updater.dart';
import 'common_tile.dart';
import 'odp_tile.dart';
import 'off_ramp_tile.dart';
import 'olp_tile.dart';
import 'on_ramp_tile.dart';
import 'outgoing_dln_tile.dart';
import 'payment_request_tile.dart';
import 'tr_tile.dart';
import 'transaction_item.dart';

class RecentTokenActivityWidget extends StatefulWidget {
  const RecentTokenActivityWidget({
    super.key,
    required this.tokenAddress,
  });

  final String tokenAddress;

  @override
  State<RecentTokenActivityWidget> createState() =>
      _RecentTokenActivityWidgetState();
}

class _RecentTokenActivityWidgetState extends State<RecentTokenActivityWidget> {
  late final Stream<IList<String>> _txs;
  final Map<String, List<String>> groupedData = {};
  final Set<String> fetchedTransactionIds = {};
  final Map<String, Transaction> transactionsCache = {};

  @override
  void initState() {
    super.initState();
    _txs = sl<TransactionRepository>().watchByAddress(widget.tokenAddress);
    sl<TxUpdater>().call(tokenAddress: widget.tokenAddress);
    _txs.listen((data) {
      if (mounted) {
        for (final e in data) {
          if (!fetchedTransactionIds.contains(e)) {
            sl<TransactionRepository>().watch(e).listen((transaction) {
              if (mounted) {
                transactionsCache[e] = transaction;
                addTransaction(e, transaction);
              }
            });
          }
        }
      }
    });
  }

  String formatDate(String date) {
    final parsedDate = DateTime.parse(date);
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(days: 1));

    if (parsedDate.year == now.year &&
        parsedDate.month == now.month &&
        parsedDate.day == now.day) {
      return 'Today';
    } else if (parsedDate.year == yesterday.year &&
        parsedDate.month == yesterday.month &&
        parsedDate.day == yesterday.day) {
      return 'Yesterday';
    } else {
      return DateFormat('MMM d, yyyy').format(parsedDate);
    }
  }

  void addTransaction(String transactionId, Transaction transaction) {
    final date = DateFormat('yyyy-MM-dd').format(
      transaction.map(
        common: (t) => t.created!,
        activity: (txActivity) => txActivity.activity.map(
          outgoingPaymentRequest: (p) => p.created,
          outgoingDirectPayment: (p) => p.created,
          outgoingLinkPayment: (p) => p.created,
          onRamp: (it) => it.created,
          offRamp: (it) => it.created,
          outgoingDlnPayment: (it) => it.created,
          transactionRequest: (it) => it.created,
        ),
      ),
    );

    if (!fetchedTransactionIds.contains(transactionId)) {
      fetchedTransactionIds.add(transactionId);

      groupedData
        ..putIfAbsent(date, () => [])
        ..update(date, (list) => list..add(transactionId));
    }
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<IList<String>>(
        stream: _txs,
        builder: (context, snapshot) {
          final data = snapshot.data;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          if (data == null) return const SizedBox.shrink();

          return HomeTile(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(height: 16),
                if (data.isEmpty)
                  const Center(
                    child: _NoActivity(),
                  )
                else ...[
                  Column(
                    children: groupedData.entries.map((entry) {
                      final date = entry.key;
                      final transactionIds = entry.value;
                      final tx = txIdMap(transactionIds).toList();

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 12.0,
                              bottom: 9.0,
                            ),
                            child: Text(
                              formatDate(date),
                              style: dashboardSectionTitleTextStyle,
                            ),
                          ),
                          _Card(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight: transactionIds.length * 60,
                                minWidth: MediaQuery.sizeOf(context).width,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    children: tx,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 8),
                ],
              ],
            ),
          );
        },
      );

  Iterable<Widget> txIdMap(List<String> transactionIds) => transactionIds.map(
        (e) {
          final tx = transactionsCache[e];
          if (tx == null) {
            return const SizedBox.shrink();
          }

          return tx.map(
            common: (t) => CommonTile(
              key: ValueKey(t.tx.id),
              txCommon: t,
              showIcon: false,
            ),
            activity: (txActivity) => txActivity.activity.map(
              outgoingPaymentRequest: (p) => PaymentRequestTile(
                key: ValueKey(p.id),
                id: p.id,
                showIcon: false,
              ),
              outgoingDirectPayment: (p) => ODPTile(
                key: ValueKey(p.id),
                activity: p,
                showIcon: false,
              ),
              outgoingLinkPayment: (p) => OLPTile(
                key: ValueKey(p.id),
                activity: p,
                showIcon: false,
              ),
              onRamp: (it) => OnRampTile(
                key: ValueKey(it.id),
                activity: it,
                showIcon: false,
              ),
              offRamp: (it) => OffRampTile(
                key: ValueKey(it.id),
                activity: it,
                showIcon: false,
              ),
              outgoingDlnPayment: (it) => OutgoingDlnTile(
                key: ValueKey(it.id),
                activity: it,
                showIcon: false,
              ),
              transactionRequest: (it) => TrTile(
                key: ValueKey(it.id),
                activity: it,
                showIcon: false,
              ),
            ),
          );
        },
      );
}

class RecentActivityWidget extends StatefulWidget {
  const RecentActivityWidget({
    super.key,
    this.onSendMoneyPressed,
    required this.onTransactionsPressed,
    this.tokenAddress,
  });

  final VoidCallback? onSendMoneyPressed;
  final VoidCallback onTransactionsPressed;
  final String? tokenAddress;

  @override
  State<RecentActivityWidget> createState() => _RecentActivityWidgetState();
}

class _RecentActivityWidgetState extends State<RecentActivityWidget> {
  final int _activityCount = 3;

  late final Stream<IList<String>> _txs;

  @override
  void initState() {
    super.initState();
    _txs = sl<TransactionRepository>().watchCount(_activityCount);
    sl<TxUpdater>().call();
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<IList<String>>(
        stream: _txs,
        builder: (context, snapshot) {
          final data = snapshot.data;

          if (data == null) return const SizedBox.shrink();

          return HomeTile(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    context.l10n.recentActivityLbl,
                    style: dashboardSectionTitleTextStyle,
                  ),
                ),
                const SizedBox(height: 16),
                if (data.isEmpty)
                  Center(
                    child: _NoActivity(
                      onSendMoneyPressed: widget.onSendMoneyPressed,
                    ),
                  )
                else ...[
                  _Card(
                    child: Column(
                      children: data
                          .map(
                            (e) => _KeepAlive(
                              key: ValueKey(e),
                              child: CpTheme.black(
                                child: TransactionItem(tx: e, showIcon: false),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // TODO(KB): Check if needed
                  // ignore: avoid-single-child-column-or-row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CpButton(
                        text: context.l10n.recentActivitySeeAll,
                        size: CpButtonSize.micro,
                        variant: CpButtonVariant.dark,
                        onPressed: widget.onTransactionsPressed,
                      ),
                    ],
                  ),
                ],
              ],
            ),
          );
        },
      );
}

class _NoActivity extends StatelessWidget {
  const _NoActivity({this.onSendMoneyPressed});

  final VoidCallback? onSendMoneyPressed;

  @override
  Widget build(BuildContext context) => onSendMoneyPressed != null
      ? _Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Text(
                  context.l10n.recentActivityEmpty,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 16),
                CpButton(
                  minWidth: 120,
                  size: CpButtonSize.wide,
                  text: context.l10n.yes,
                  onPressed: onSendMoneyPressed,
                ),
              ],
            ),
          ),
        )
      : const Padding(
          padding: EdgeInsets.only(top: 72.0),
          child: Text(
            'No recent activity',
            style: TextStyle(
              color: Color(0xFF484848),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        );
}

class _Card extends StatelessWidget {
  const _Card({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        decoration: const ShapeDecoration(
          color: CpColors.darkBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(28),
            ),
          ),
        ),
        child: child,
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
