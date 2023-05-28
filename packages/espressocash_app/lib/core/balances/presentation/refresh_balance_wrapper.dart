import 'package:dfunc/dfunc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

import '../../../gen/assets.gen.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/snackbar.dart';
import '../../accounts/bl/account.dart';
import '../../conversion_rates/bl/conversion_rates_bloc.dart';
import '../../processing_state.dart';
import '../../user_preferences.dart';
import '../bl/balances_bloc.dart';

final _logger = Logger('RefreshBalanceWrapper');

typedef RefreshBalancesBuilder = Widget Function(
  BuildContext context,
  AsyncCallback callback,
);

class RefreshBalancesWrapper extends StatefulWidget {
  const RefreshBalancesWrapper({
    super.key,
    required this.builder,
  });

  final RefreshBalancesBuilder builder;

  @override
  State<RefreshBalancesWrapper> createState() => _RefreshBalancesWrapperState();
}

class _RefreshBalancesWrapperState extends State<RefreshBalancesWrapper> {
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
  Widget build(BuildContext context) => widget.builder(
        context,
        () => _onRefreshWithErrorHandling(context),
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
