import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../accounts/bl/account.dart';
import '../conversion_rates/bl/conversion_rates_bloc.dart';
import '../processing_state.dart';
import '../user_preferences.dart';
import 'bl/balances_bloc.dart';

extension RefreshBalanceExt on BuildContext {
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
    final bloc = read<ConversionRatesBloc>();
    final currency = read<UserPreferences>().fiatCurrency;

    final conversionEvent = ConversionRatesEvent.refreshRequested(
      currency: currency,
      tokens: read<BalancesBloc>().state.userTokens,
    );
    bloc.add(conversionEvent);

    return _listenForProcessingStateAndThrowOnError(bloc.stream);
  }

  AsyncResult<void> _updateBalances() async {
    final bloc = read<BalancesBloc>();
    final account = read<MyAccount>();

    bloc.add(BalancesEvent.requested(address: account.address));

    return _listenForProcessingStateAndThrowOnError(bloc.stream);
  }

  AsyncResult<void> refreshBalances() {
    final balances = _updateBalances();
    final conversionRates = _updateConversionRates();

    return balances.flatMapAsync((_) => conversionRates);
  }
}
