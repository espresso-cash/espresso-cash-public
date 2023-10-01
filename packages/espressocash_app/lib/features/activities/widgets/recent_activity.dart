import 'package:auto_route/auto_route.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:provider/provider.dart';

import '../../../di.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/button.dart';
import '../../../ui/colors.dart';
import '../../../ui/loader.dart';
import '../../../ui/theme.dart';
import '../../wallet_flow/screens/wallet_flow_screen.dart';
import '../data/transaction_repository.dart';
import '../screens/activities_screen.dart';
import '../services/bloc.dart';
import 'transaction_item.dart';

class RecentActivityWidget extends StatefulWidget {
  const RecentActivityWidget({super.key});

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

    context.read<TxUpdaterBloc>().add(const TxUpdaterEvent.fetch());
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<IList<String>>(
        stream: _txs,
        builder: (context, snapshot) {
          final data = snapshot.data;

          if (data == null) return const SizedBox.shrink();

          final isLoading = context.select<TxUpdaterBloc, bool>(
            (value) => value.state.isProcessing,
          );

          return Container(
            color: CpColors.dashboardBackgroundColor,
            padding: const EdgeInsets.all(16),
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
                const SizedBox(height: 12),
                if (data.isEmpty)
                  Center(
                    child: isLoading ? const _Loading() : const _NoActivity(),
                  )
                else ...[
                  _Card(
                    child: Column(
                      children: data
                          .map(
                            (e) => _KeepAlive(
                              key: ValueKey(e),
                              child: TransactionItem(tx: e),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CpButton(
                        text: context.l10n.recentActivitySeeAll,
                        size: CpButtonSize.micro,
                        variant: CpButtonVariant.black,
                        onPressed: () => context.router.navigate(
                          ActivitiesScreen.route(goToTransactions: true),
                        ),
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
  const _NoActivity();

  @override
  Widget build(BuildContext context) => _Card(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Text(
                context.l10n.recentActivityEmpty,
                style: const TextStyle(
                  color: Color(0xFF2D2B2C),
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 16),
              CpButton(
                minWidth: 120,
                size: CpButtonSize.wide,
                text: context.l10n.yes,
                onPressed: () =>
                    context.router.navigate(WalletFlowScreen.route()),
              ),
            ],
          ),
        ),
      );
}

class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) => const _Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: LoadingIndicator(),
        ),
      );
}

class _Card extends StatelessWidget {
  const _Card({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(4),
        decoration: const ShapeDecoration(
          color: Colors.white,
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
