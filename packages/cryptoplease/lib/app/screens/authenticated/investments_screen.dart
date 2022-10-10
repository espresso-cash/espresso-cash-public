import 'package:cryptoplease/app/components/refresh_balance_wrapper.dart';
import 'package:cryptoplease/app/screens/authenticated/components/app_bar.dart';
import 'package:cryptoplease/app/screens/authenticated/components/balance_list_widget.dart';
import 'package:cryptoplease/app/screens/authenticated/components/header_buttons.dart';
import 'package:cryptoplease/app/screens/authenticated/components/stablecoin_empty_widget.dart';
import 'package:cryptoplease/app/screens/authenticated/components/total_balance_widget.dart';
import 'package:cryptoplease/app/screens/authenticated/components/wallet_tab_bar.dart';
import 'package:cryptoplease/core/balances/bl/balances_bloc.dart';
import 'package:cryptoplease/core/balances/presentation/watch_balance.dart';
import 'package:cryptoplease/core/user_preferences.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InvestmentsScreen extends StatefulWidget {
  const InvestmentsScreen({Key? key}) : super(key: key);

  @override
  State<InvestmentsScreen> createState() => _InvestmentsScreenState();
}

class _InvestmentsScreenState extends State<InvestmentsScreen> {
  @override
  Widget build(BuildContext context) => RefreshBalancesWrapper(
        builder: (context, onRefresh) =>
            BlocBuilder<BalancesBloc, BalancesState>(
          builder: (context, state) {
            final total = context.watchUserTotalFiatBalance(
              context.watch<UserPreferences>().fiatCurrency,
            );

            final isLoading = state.processingState.maybeMap(
              processing: (_) => true,
              orElse: () => false,
            );

            return DefaultTabController(
              length: 2,
              child: CpHeaderedList(
                onRefresh: onRefresh,
                headerAppBar: const HomeScreenAppBar(),
                headerButtons: const [
                  SwapButton(),
                  SendButton(),
                  ReceiveButton(),
                ],
                headerContent: TotalBalanceWidget(balance: total),
                stickyBottomHeader: const WalletTabBar(),
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    BalanceListWidget(
                      tokens: state.nonStableTokens,
                      isLoading: isLoading,
                      emptyWidget: CpEmptyMessageWidget(
                        message: context.l10n.noDataPullToRefresh,
                      ),
                    ),
                    BalanceListWidget(
                      tokens: state.stableTokens,
                      isLoading: isLoading,
                      emptyWidget: const StableCoinEmptyWidget(),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
}
