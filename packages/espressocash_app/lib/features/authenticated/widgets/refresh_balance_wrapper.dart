import 'package:dfunc/dfunc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import '../../../di.dart';
import '../../../gen/assets.gen.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/snackbar.dart';
import '../../../utils/processing_state.dart';
import '../../balances/data/repository.dart';
import '../../balances/services/balances_bloc.dart';
import '../../balances/widgets/context_ext.dart';
import '../../conversion_rates/data/repository.dart';
import '../../currency/models/currency.dart';

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
    Stream<ProcessingState> stream,
  ) =>
      stream
          .firstWhere(
            (state) => switch (state) {
              ProcessingStateProcessing() => false,
              ProcessingStateError() || ProcessingStateNone() => true,
            },
          )
          .then(
            (s) => switch (s) {
              ProcessingStateError(:final e) => Either.left(e),
              _ => const Either.right(null),
            },
          );

  AsyncResult<void> _updateConversionRates() async {
    final tokens = await sl<TokenBalancesRepository>().readUserTokens();

    return sl<ConversionRatesRepository>()
        .refresh(defaultFiatCurrency, tokens)
        .doOnLeftAsync((_) {
      if (!mounted) return;

      _showConversionRatesFetchErrorToast(context);
    });
  }

  AsyncResult<void> _updateBalances() {
    context.notifyBalanceAffected();

    return _listenForProcessingStateAndThrowOnError(sl<BalancesBloc>().stream);
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
      message: context.l10n.balances_lblConnectionError,
      icon: Assets.icons.toastWarning.image(),
    );

void _showConversionRatesFetchErrorToast(BuildContext context) =>
    showCpSnackbar(
      context,
      message: context.l10n.weWereUnableToFetchTokenPrice,
      icon: Assets.icons.toastWarning.image(),
    );
