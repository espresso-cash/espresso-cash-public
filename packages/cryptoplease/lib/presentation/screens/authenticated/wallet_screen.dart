import 'package:cryptoplease/bl/accounts/account.dart';
import 'package:cryptoplease/bl/balances/balances_bloc.dart';
import 'package:cryptoplease/bl/conversion_rates/conversion_rates_bloc.dart';
import 'package:cryptoplease/bl/processing_state.dart';
import 'package:cryptoplease/bl/user_preferences.dart';
import 'package:cryptoplease/gen/assets.gen.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/screens/authenticated/components/app_bar.dart';
import 'package:cryptoplease/presentation/screens/authenticated/components/balance_list_widget.dart';
import 'package:cryptoplease/presentation/screens/authenticated/components/header_buttons.dart';
import 'package:cryptoplease/presentation/screens/authenticated/components/stablecoin_empty_widget.dart';
import 'package:cryptoplease/presentation/screens/authenticated/components/total_balance_widget.dart';
import 'package:cryptoplease/presentation/screens/authenticated/components/wallet_tab_bar.dart';
import 'package:cryptoplease/presentation/watch_balance.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

final _logger = Logger('BalancesScreen');

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  AsyncResult<void> _listenForProcessingStateAndThrowOnError(
    Stream<StateWithProcessingState> stream,
  ) async =>
      stream
          .firstWhere(
            (state) => state.processingState.when(
              processing: F,
              error: T,
              none: T,
            ),
          )
          .then(
            (s) => s.processingState.maybeMap(
              error: (s) => Either.left(s.e),
              orElse: () => const Either.right(null),
            ),
          );

  AsyncResult<void> _updateConversionRates() {
    final bloc = context.read<ConversionRatesBloc>();
    final currency = context.read<UserPreferences>().fiatCurrency;

    final conversionEvent = ConversionRatesEvent.refreshRequested(
      currency: currency,
      tokens: context.read<BalancesBloc>().state.userTokens,
    );
    bloc.add(conversionEvent);

    return _listenForProcessingStateAndThrowOnError(bloc.stream);
  }

  AsyncResult<void> _updateBalances() async {
    final bloc = context.read<BalancesBloc>();
    final account = context.read<MyAccount>();

    bloc.add(BalancesEvent.requested(address: account.address));

    return _listenForProcessingStateAndThrowOnError(bloc.stream);
  }

  AsyncResult<void> _onPulledToRefreshBalances() {
    final balances = _updateBalances();
    final conversionRates = _updateConversionRates();

    return balances.flatMapAsync((_) => conversionRates);
  }

  @override
  void initState() {
    super.initState();
    _onPulledToRefreshBalances();
  }

  Future<void> _onRefreshWithErrorHandling(BuildContext context) =>
      _onPulledToRefreshBalances().doOnLeftAsync(
        (error) {
          if (error is BalancesRequestException) {
            _showFetchBalancesErrorToast(context);
          } else if (error is ConversionRatesRequestException) {
            _showConversionRatesFetchErrorToast(context);
          } else {
            _logger.severe('Failed to update', error);
          }
        },
      );

  @override
  Widget build(BuildContext context) =>
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
              onRefresh: () => _onRefreshWithErrorHandling(context),
              headerAppBar: const HomeScreenAppBar(),
              headerButtons: const [
                AddFundsButton(),
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
      );
}

void _showFetchBalancesErrorToast(BuildContext context) => showCpSnackbar(
      context,
      message: context.l10n.cannotConnectToTheNetwork,
      icon: Assets.icons.toastWarning.image(),
    );

void _showConversionRatesFetchErrorToast(BuildContext context) =>
    showCpSnackbar(
      context,
      message: context.l10n.weWereUnableToFetchTokenPrice,
      icon: Assets.icons.toastWarning.image(),
    );
